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

{ #category : #process }
GHMInlineSplitter >> addBasicTextBlocksWithResult: aResultArray withStart: startString withEnd: endString [
	| string_array |
	string_array := string asArray.
	string_array doWithIndex: [ :each :i | (i between: startString and: endString) ifFalse: [ string_array at: i put: nil ]  ].
	aResultArray do: [ :anInlineBlock | anInlineBlock start to: anInlineBlock end do: [ :k | string_array at: k put: nil ] ].
	string_array splitOn: nil indicesDo: [ :start :end | 
		| substring |
		substring := string collect: [ :c | c ] from: start to: end.
		(substring isEmpty) ifFalse: [ 
			aResultArray add: 
				(GHMInlineBlock_v2
					from: start
					to: end
					withKind: #basic
					withSubstring: substring
					withChildren: Array empty)
			 ]
	].
	^ (aResultArray sort: [ :block :block2 | block start < block2 start ]) asArray
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
	result_array := self emphasisProcessWithStack: delimiter_stack withResult: LinkedList new withStart: 1 withEnd: string size.
	^ result_array
]

{ #category : #process }
GHMInlineSplitter >> emphasisProcessWithStack: aStack withResult: aResultArray withStart: aStartSubstringIndex withEnd: anEndSubstringIndex [
	| first_opener first_opener_index associate_closer associate_closer_index correctSubstring children start end |
	"1. search first opener"
	first_opener_index := aStack findFirst: [ :delimiter | delimiter isOpener ].
	"1. a. opener not found = exit"
	first_opener_index isZero ifTrue: [ ^ self addBasicTextBlocksWithResult: aResultArray withStart: aStartSubstringIndex withEnd: anEndSubstringIndex].
	"1. b. opener found"
	first_opener := aStack at: first_opener_index.
	
	"2. search first closer with same type after opener found index"	
	associate_closer_index := (aStack allButFirst: first_opener_index) findFirst: [ :delimiter | delimiter isCloser and: delimiter type = first_opener type].
	"2. a. first closer with same type not found >> when a pair isn't complete"
	associate_closer_index isZero ifTrue: [ 
		^ self emphasisProcessWithStack: (aStack withIndexSelect: [ :value :i | (i = first_opener_index) not ]) withResult: aResultArray withStart: aStartSubstringIndex withEnd: anEndSubstringIndex.
	].
	"2. b. closer found"
	associate_closer_index := associate_closer_index + first_opener_index.
	associate_closer := aStack at: associate_closer_index.
	start := first_opener index + first_opener size.
	end := associate_closer index - 1.
	correctSubstring := string collect: [ :c | c ] from: start to: end.
	"case: nested"
	(associate_closer_index = (first_opener_index + 1))
		ifTrue: [ children := Array empty ]
		ifFalse: [ children := self emphasisProcessWithStack: (aStack withIndexSelect: [:value :i | i between: first_opener_index + 1 and: associate_closer_index - 1 ]) withResult: LinkedList new withStart: start withEnd: end ].
	"add in result_array"
	aResultArray add: 
		(GHMInlineBlock_v2
			from: first_opener index
			to: associate_closer index + associate_closer size - 1
			withKind: first_opener type
			withSubstring: correctSubstring
			withChildren: children).
	^ self emphasisProcessWithStack: (aStack withIndexSelect: [:value :i | (i between: first_opener_index and: associate_closer_index) not ]) withResult: aResultArray withStart: aStartSubstringIndex withEnd: anEndSubstringIndex
	
		
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
	index := 1.
	string := aString.
	^ self read: aString
]
