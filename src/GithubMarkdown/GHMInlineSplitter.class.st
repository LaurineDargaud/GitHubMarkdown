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
]

{ #category : #process }
GHMInlineSplitter >> emphasisProcessWithCurrentPosition [
	^ self emphasisProcessWithCurrentPosition: 1 withOpenersBottom: 1 withStackBottom: 1
]

{ #category : #process }
GHMInlineSplitter >> emphasisProcessWithCurrentPosition: aCurrentPosition withOpenersBottom: anOpenersBottom withStackBottom: aStackBottom [
	| current_position openers_bottom stack_bottom first_closer first_closer_index associate_opener associate_opener_index |
	
	"0. initialization"
	current_position := aCurrentPosition.
	openers_bottom := anOpenersBottom.
	stack_bottom := aStackBottom.
	
	"1. search first closer"
	first_closer_index := delimiter_stack findFirst: [ :delimiter | delimiter isCloser ].
	"1. a. closer not found = exit"
	first_closer_index isZero ifTrue: [ ^ self exitProcess ].
	"1. b. closer found"
	first_closer := delimiter_stack at: first_closer_index.
	
	"2. search first opener with same type pulling up from found closer index"
	associate_opener_index := (delimiter_stack allButLast: delimiter_stack - first_closer_index ) findLast: [ :delimiter | delimiter isOpener and: delimiter type = first_closer type].
	"2. a. first opener not found"
	associate_opener_index isZero ifTrue: [  ].
	"2. b. opener found"
	associate_opener := delimiter_stack at: associate_opener_index.
	
	
	
		
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
		index := index + 1.
		^ self read: rest.
		 ]
	ifEmpty:
		[ ^ self emphasisProcess ]
]

{ #category : #actions }
GHMInlineSplitter >> searchForDelimiterAtHead: aChar [
	allDelimiters at: aChar 
		ifPresent: [ :class |
			(class type == 'linkNameCloser') 
				ifTrue: [ ^ self linkOrImageProcess ]			
				ifFalse: [ delimiter_stack add: (class index: index)]
			 ] 
		ifAbsent: [ "do nothing" ]
]

{ #category : #actions }
GHMInlineSplitter >> start: aString [
	delimiter_stack := Stack new.
	result_array := SequenceableCollection new.
	index = 1.
	self read: aString
]
