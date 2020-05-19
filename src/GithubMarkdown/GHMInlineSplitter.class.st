Class {
	#name : #GHMInlineSplitter,
	#superclass : #Object,
	#instVars : [
		'string',
		'string_array',
		'inlineType_array',
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
	string_array := SequenceableCollection new.
	inlineType_array := SequenceableCollection new.
	index = 1.
	self read: aString
]
