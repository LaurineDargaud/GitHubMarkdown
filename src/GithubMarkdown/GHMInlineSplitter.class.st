Class {
	#name : #GHMInlineSplitter,
	#superclass : #Object,
	#instVars : [
		'string',
		'result_array',
		'index',
		'delimiter_stack',
		'allDelimiters'
	],
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMInlineSplitter >> allDelimiters [
	^ allDelimiters
]

{ #category : #process }
GHMInlineSplitter >> emphasisProcess [
	| first_opener first_opener_index associate_closer associate_closer_index |
	
	"1. search first opener"
	first_opener_index := delimiter_stack findFirst: [ :delimiter | delimiter isOpener ].
	"1. a. opener not found = exit"
	first_opener_index isZero ifTrue: [ "quit" ].
	"1. b. opener found"
	first_opener := delimiter_stack at: first_opener_index.
	
	"2. search first closer with same type after opener found index"	
	associate_closer_index := (delimiter_stack allButFirst: first_opener_index) findFirst: [ :delimiter | delimiter isCloser and: delimiter type = first_opener type].
	"2. a. first closer with same type not found"
	associate_closer_index isZero ifTrue: [ 
		delimiter_stack := delimiter_stack withIndexSelect: [ :value :i | (i = first_opener_index) not ].
		self halt.
		^ self emphasisProcess.
	].
	"2. b. closer found"
	associate_closer_index := associate_closer_index + first_opener_index.
	associate_closer := delimiter_stack at: associate_closer_index.
	result_array add: 
		(GHMInlineBlock_v2
			from: first_opener index + first_opener size
			to: associate_closer index - associate_closer size
			withKind: first_opener type
			withString: string).
	delimiter_stack := delimiter_stack withIndexSelect: [:value :i | i > first_opener_index and: i < associate_closer_index ].
	self halt.
	^ self emphasisProcess
	
	
	
		
]

{ #category : #accessing }
GHMInlineSplitter >> index [
	^ index
]

{ #category : #accessing }
GHMInlineSplitter >> indexIncrement [
	index := self index + 1
]

{ #category : #initialization }
GHMInlineSplitter >> initialize [
	allDelimiters := Dictionary new.
	GHMAbstractDelimiter subclasses do: [ :subclass | allDelimiters at: subclass new markup put: (subclass name asClass)].
]

{ #category : #process }
GHMInlineSplitter >> linkOrImageProcess [
	
]

{ #category : #actions }
GHMInlineSplitter >> read: aString [
	| head rest |
	aString ifNotEmpty: [ 
		head := aString first.
		rest := aString allButFirst.
		self searchForDelimiterAtHead: head.
		self indexIncrement.
		^ self read: rest.
		 ]
	ifEmpty:
		[ ^ self emphasisProcess ]
]

{ #category : #actions }
GHMInlineSplitter >> searchForDelimiterAtHead: aChar [
	allDelimiters at: (aChar asString)
		ifPresent: [ :class |
			(class new type == 'linkNameCloser') 
				ifTrue: [ ^ self linkOrImageProcess ]			
				ifFalse: [ delimiter_stack add: (class index: index)]
			 ] 
		ifAbsent: [ "do nothing" ]
]

{ #category : #public }
GHMInlineSplitter >> start: aString [
	delimiter_stack := Stack new.
	result_array := Set new.
	index := 1.
	string := aString.
	self read: aString
]
