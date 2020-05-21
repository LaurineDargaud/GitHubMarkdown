"
I am a recursive algorithm to find different kinds of emphasis i.e. inline formats in a text line.

To proceed, call my constructor which start automatically the emphasis process.

I need:
- stack = stack of delimiters determined by the inline splitter algorithm
- string = the initial text line

At the end, I return an array of GHMInlineBlock which represents the initial text line.
"
Class {
	#name : #GHMInlineEmphasisProcess,
	#superclass : #Object,
	#instVars : [
		'stack',
		'result',
		'string',
		'start',
		'end',
		'startIndex',
		'endIndex',
		'first_opener',
		'first_opener_index',
		'associate_closer',
		'associate_closer_index',
		'children'
	],
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #'new & start' }
GHMInlineEmphasisProcess class >> startWithStack: aStack withResult: aResultArray withStart: aStartSubstringIndex withEnd: anEndSubstringIndex withString: aString [
	| newProcess |
	newProcess := self new stack: aStack; result: aResultArray; start: aStartSubstringIndex; end: anEndSubstringIndex; string: aString; yourself.
	^ newProcess emphasisProcess.
]

{ #category : #'new & start' }
GHMInlineEmphasisProcess class >> startWithStack: aStack withString: aString [
	^ self startWithStack: aStack withResult: LinkedList new withStart: 1 withEnd: aString size withString: aString
]

{ #category : #actions }
GHMInlineEmphasisProcess >> addBasicTextBlocks [
	| string_array |
	string_array := string asArray.
	string_array doWithIndex: [ :each :i | (i between: start and: end) ifFalse: [ string_array at: i put: nil ]  ].
	result do: [ :anInlineBlock | anInlineBlock start to: anInlineBlock end do: [ :k | string_array at: k put: nil ] ].
	string_array splitOn: nil indicesDo: [ :startIndex :endIndex | 
		| substring |
		substring := string collect: [ :c | c ] from: startIndex to: endIndex.
		(substring isEmpty) ifFalse: [ 
			result add: 
				(GHMInlineBlock_v2
					from: startIndex
					to: endIndex
					withKind: #basic
					withSubstring: substring
					withChildren: Array empty)
			 ]
	].
	^ (result sort: [ :block :block2 | block start < block2 start ]) asArray
]

{ #category : #actions }
GHMInlineEmphasisProcess >> childrenInNestedCase [
	^ self class 
		startWithStack: (stack withIndexSelect: [:value :i | i between: first_opener_index + 1 and: associate_closer_index - 1 ]) 
		withResult: LinkedList new 
		withStart: startIndex 
		withEnd: endIndex 
		withString: string
]

{ #category : #'global process' }
GHMInlineEmphasisProcess >> emphasisProcess [
	| correctSubstring |
	"1. search first opener. If not found, exit case."
	first_opener_index := stack findFirst: [ :delimiter | delimiter isOpener ].
	first_opener_index isZero 
		ifTrue: [ ^ self addBasicTextBlocks ].
	first_opener := stack at: first_opener_index.
	"2. search first closer with same type, just after. If not found, pair isn't complete so we skip it and keep going."	
	associate_closer_index := (stack allButFirst: first_opener_index) findFirst: [ :delimiter | delimiter isCloser and: delimiter type = first_opener type].
	associate_closer_index isZero 
		ifTrue: [ 
			stack := (stack withIndexSelect: [ :value :i | (i = first_opener_index) not ]).
			^ self emphasisProcess ].
	"3. translate index in delimiters stack"
	associate_closer_index := associate_closer_index + first_opener_index.
	associate_closer := stack at: associate_closer_index.	
	"4. set substring in global string concerned by found emphasis"
	startIndex := first_opener index + first_opener size.
	endIndex := associate_closer index - 1.
	correctSubstring := string collect: [ :c | c ] from: startIndex to: endIndex.
	"5. are we in a nested emphasis case?"
	self processNestedCase.
	"6. add in result_array"
	result add: 
		(self inlineBlockClass
			from: first_opener index
			to: associate_closer index + associate_closer size - 1
			withKind: first_opener type
			withSubstring: correctSubstring
			withChildren: children).
	"7. keep going"
	stack := (stack withIndexSelect: [:value :i | (i between: first_opener_index and: associate_closer_index) not ]).
	^ self emphasisProcess
	
		
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> end: anEndIndex [
	end := anEndIndex 
]

{ #category : #actions }
GHMInlineEmphasisProcess >> inlineBlockClass [
	^ GHMInlineBlock_v2
]

{ #category : #actions }
GHMInlineEmphasisProcess >> processNestedCase [
	(associate_closer_index = (first_opener_index + 1))
		ifTrue: [ children := Array empty ]
		ifFalse: [ children := self childrenInNestedCase ].
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> result: anArray [
	result := anArray
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> stack: aStack [
	stack := aStack
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> start: aStartIndex [
	start := aStartIndex
]

{ #category : #accessing }
GHMInlineEmphasisProcess >> string: aString [
	string := aString
]
