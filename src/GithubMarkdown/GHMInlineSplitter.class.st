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

{ #category : #'class references' }
GHMInlineSplitter >> abstractDelimiterClass [
	^ GHMAbstractDelimiter
]

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
	result_array := self emphasisProcessClass startWithStack: delimiter_stack withResult: LinkedList new withStart: 1 withEnd: string size withString: string.
	^ result_array
]

{ #category : #'class references' }
GHMInlineSplitter >> emphasisProcessClass [
	^ GHMInlineEmphasisProcess
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
	self abstractDelimiterClass subclasses select: [ :subclass | subclass new isActive ] thenDo: [ :subclass | allDelimiters at: subclass new markup put: (subclass name asClass)].
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
	index := 1.
	string := aString.
	^ self read: aString
]
