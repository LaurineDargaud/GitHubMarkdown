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
GHMInlineSplitter >> delimiterFoundProcess: aDelimiterSubclass [
	(aDelimiterSubclass new type == 'linkNameCloser') 
		ifTrue: [ ^ self linkOrImageProcess ]			
		ifFalse: [ delimiter_stack add: (aDelimiterSubclass index: index)]
]

{ #category : #process }
GHMInlineSplitter >> emphasisProcess [
	| first_opener first_opener_index associate_closer associate_closer_index |
	
	"1. search first opener"
	first_opener_index := delimiter_stack findFirst: [ :delimiter | delimiter isOpener ].
	"1. a. opener not found = exit"
	first_opener_index isZero ifTrue: [ ^ result_array asArray ].
	"1. b. opener found"
	first_opener := delimiter_stack at: first_opener_index.
	
	"2. search first closer with same type after opener found index"	
	associate_closer_index := (delimiter_stack allButFirst: first_opener_index) findFirst: [ :delimiter | delimiter isCloser and: delimiter type = first_opener type].
	"2. a. first closer with same type not found >> when a pair isn't complete"
	associate_closer_index isZero ifTrue: [ 
		delimiter_stack := delimiter_stack withIndexSelect: [ :value :i | (i = first_opener_index) not ].
		^ self emphasisProcess.
	].
	"2. b. closer found"
	associate_closer_index := associate_closer_index + first_opener_index.
	associate_closer := delimiter_stack at: associate_closer_index.
	result_array add: 
		(GHMInlineBlock_v2
			from: first_opener index + first_opener size
			to: associate_closer index - 1
			withKind: first_opener type
			withString: string).
	delimiter_stack := delimiter_stack withIndexSelect: [:value :i | (i between: first_opener_index and: associate_closer_index) not ].
	^ self emphasisProcess
	
	
	
		
]

{ #category : #accessing }
GHMInlineSplitter >> index [
	^ index
]

{ #category : #actions }
GHMInlineSplitter >> indexIncrement [
	^ self indexIncrement: 1
]

{ #category : #actions }
GHMInlineSplitter >> indexIncrement: anInteger [
	index := self index + anInteger
]

{ #category : #initialization }
GHMInlineSplitter >> initialize [
	allDelimiters := Dictionary new.
	GHMAbstractDelimiter subclasses select: [ :subclass | subclass new isActive ] thenDo: [ :subclass | allDelimiters at: subclass new markup put: (subclass name asClass)].
]

{ #category : #process }
GHMInlineSplitter >> linkOrImageProcess [
	|linkNameCloser_index linkNameCloser |
	"1. search the linkname closer delimiter"
	linkNameCloser_index := delimiter_stack findLast: [ :delimiter | delimiter isOpener and: delimiter type = #linkName].
]

{ #category : #actions }
GHMInlineSplitter >> read: aString [
	| incrementation |
	incrementation := 1.
	aString ifEmpty: [ ^ self emphasisProcess ].
	allDelimiters keysDo: [ :key | 
		(aString beginsWith: key) 
			ifTrue: [ 
				self delimiterFoundProcess: (allDelimiters at: key).
				incrementation := key size.
			].
	].
	self indexIncrement: incrementation.
	^ self read: (aString allButFirst: incrementation)
	
]

{ #category : #public }
GHMInlineSplitter >> start: aString [
	delimiter_stack := Stack new.
	result_array := LinkedList new.
	index := 1.
	string := aString.
	^ self read: aString
]
