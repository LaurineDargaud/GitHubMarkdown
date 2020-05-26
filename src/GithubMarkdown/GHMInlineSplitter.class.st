"
I represent the class which is in charge of splitting sentences to parse inline blocks.

To proceed: `GHMInlineSplitter new start: stringToParse`
"
Class {
	#name : #GHMInlineSplitter,
	#superclass : #Object,
	#instVars : [
		'string',
		'resultArray',
		'index',
		'delimiterStack',
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
	| processResult |
	(aDelimiterSubclass isCloser and: aDelimiterSubclass new type = 'linkName') 
		ifTrue: [ processResult := self linkOrImageProcess: aDelimiterSubclass ]			
		ifFalse: [ delimiterStack add: (aDelimiterSubclass index: index)]
]

{ #category : #process }
GHMInlineSplitter >> emphasisProcess [
	| resultEmphasisArray |
	resultEmphasisArray := self emphasisProcessClass startWithStack: (delimiterStack select: [:delimiter | delimiter isActive ]) withString: string.
	resultArray ifNotEmpty: [ resultEmphasisArray do: [:each | resultArray add: each ] ] ifEmpty: [ ^ resultEmphasisArray ].
	^ resultArray asArray
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
	super initialize.
	self initializeDelimiters
]

{ #category : #initialization }
GHMInlineSplitter >> initializeDelimiters [
	allDelimiters := Dictionary new.
	self abstractDelimiterClass subclasses 
		do: [ :subclass | allDelimiters 
										at: subclass markup 
										put: (self class environment at: subclass name) ].
]

{ #category : #process }
GHMInlineSplitter >> linkOrImageProcess: closerSubclass [
	| openerIndex opener urlCloserStringIndex correctSubstring correctURL children|
	"1. search the linkname closer delimiter"
	openerIndex := delimiterStack findLast: [ :delimiter | delimiter isOpener and: (delimiter type = #linkName or: delimiter type  = #figure)].
	openerIndex isZero ifTrue: [ ^ nil ].
	opener := delimiterStack at: openerIndex.
	"2. check we find a ( just after closer in string"
	((string allButFirst: index + closerSubclass size - 1) beginsWith: self urlOpenerDelimiterClass markup) 
		ifFalse: [ delimiterStack := (delimiterStack withIndexSelect: [ :value :i | (i = openerIndex) not ]). ^ nil ].
	"3. search url closer"
	urlCloserStringIndex := string indexOfSubCollection: self urlCloserDelimiterClass markup startingAt: index 
		ifAbsent: [ delimiterStack := (delimiterStack withIndexSelect: [ :value :i | (i = openerIndex) not ]). ^ nil ].
	"4. link or figure found"
	correctSubstring := string collect: [ :c | c ] from: (opener index + opener size) to: (index-1).
	correctURL := string collect: [ :c | c ] from: (index + closerSubclass size + self urlOpenerDelimiterClass size) to: (urlCloserStringIndex - 1).
	children := self class new start: correctSubstring.
	resultArray add: 
		(GHMInlineBlockWithUrl_v2
			from: opener index
			to: urlCloserStringIndex 
			withKind: opener type
			withSubstring: correctSubstring
			withChildren: children
			withURL: correctURL).
	"5. keep going process"
	delimiterStack := (delimiterStack withIndexSelect: [ :value :i | (i = openerIndex) not ]).
	index := urlCloserStringIndex + self urlCloserDelimiterClass size - closerSubclass size.
	^ nil
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
	delimiterStack := Stack new.
	resultArray := LinkedList new.
	index := 1.
	string := aString.
	^ self read: aString
]

{ #category : #'class references' }
GHMInlineSplitter >> urlCloserDelimiterClass [
	^ GHMURLCloserDelimiter
]

{ #category : #'class references' }
GHMInlineSplitter >> urlOpenerDelimiterClass [
	^ GHMURLOpenerDelimiter 
]
