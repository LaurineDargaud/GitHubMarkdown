Class {
	#name : #MicroDownParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'GithubMicrodown-Test'
}

{ #category : #running }
MicroDownParserTest >> parser [ 

	^ MicroDownParser new
]

{ #category : #running }
MicroDownParserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	super setUp.
	parser := self parser
]

{ #category : #'tests-anchor' }
MicroDownParserTest >> testAnchorBlock [
	| source root annotated |
	source := parser anchorMarkup, 'label1'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'label1'.
	

]

{ #category : #'tests-anchor' }
MicroDownParserTest >> testAnchorBlockFollowingEachOther [
	| source root annotated |
	source := parser anchorMarkup, 'label1', String cr.
	source := source, parser anchorMarkup, 'label2'.
	root := parser parse: source.
	self assert: root children size equals: 2.
	annotated := root children first. 
	self assert: annotated label equals: 'label1'.
	
	annotated := root children second. 
	self assert: annotated label equals: 'label2'.
	

]

{ #category : #'tests-anchor' }
MicroDownParserTest >> testAnchorMarkupInsideLine [
	| source root paragraph |
	source := 'this is not an anchor', parser anchorMarkup, 'label1'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	paragraph := root children first. 
	self assert: (paragraph isKindOf: GHMParagraphBlock).
	self assert: paragraph text equals: 'this is not an anchor', parser anchorMarkup, 'label1'.
	

]

{ #category : #'tests-annotated-paragraph' }
MicroDownParserTest >> testAnnotatedBlock [
	| source root annotated |
	source := parser annotatedParagraphMarkup , 'important this is an important paragraph on one line.'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'important'.
	self assert: annotated code equals: 'this is an important paragraph on one line.'
	

]

{ #category : #'tests-annotated-paragraph' }
MicroDownParserTest >> testAnnotatedBlockOnMultipleLinesParserLogic [

	| source root annotated  line |
	source := (parser annotatedParagraphMarkup , 'important this is an 
important point because...!') readStream.
	
	"first the root block"
	root := parser parse: ''.
	self assert: parser current equals: root. 
	
	"second the annotated"
	annotated := parser handleLine: source nextLine.
	self assert: parser current equals: annotated.
	self assert: annotated parent equals: root.  
	
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is an'.
	
	"third the second line"
	line := source nextLine.
	self assert: (annotated canConsumeLine: line).
	annotated := parser handleLine: line.
	self assert: parser current equals: annotated.
	self assert: annotated text equals: 'this is an
important point because...!'.
	
]

{ #category : #'tests-annotated-paragraph' }
MicroDownParserTest >> testAnnotatedBlockOnTwoLines [
	| source root annotated |
	source := parser annotatedParagraphMarkup , 'important this is an important 
paragraph on two lines.'.
	root := parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is an important
paragraph on two lines.'

]

{ #category : #'tests-annotated-paragraph' }
MicroDownParserTest >> testAnnotatedBlockWithListParserLogic [
	"The test does not test what we want. We want a listblock inside the annotatedBlock"
	|  source root annotated  line |
	self flag: #fixme.
	source := (parser annotatedParagraphMarkup , 'important this is a point
- one
* two ' ) readStream.

 	parser := self parser. 
	
	"first the root block"
	root := parser parse: ''.
	self assert: parser current equals: root. 
	
	"second the annotated"
	annotated := parser handleLine: source nextLine.
	self assert: parser current equals: annotated.
	self assert: annotated parent equals: root.  
	
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is a point'.
	
	"third the second line"
	line := source nextLine.
	
	self assert: (annotated canConsumeLine: line).
	annotated := parser handleLine: line.
	self assert: parser current equals: annotated.
	self assert: annotated text equals: 'this is a point
- one'.


]

{ #category : #'tests-comments' }
MicroDownParserTest >> testCommentOnMultipleLines [

	| source root comment |
	source := parser commentedLineMarkup , 'a comment', String cr.
	source := source, parser commentedLineMarkup , 'a second comment'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	comment := root children first. 
	self assert: comment text equals: 'a comment
a second comment'
	
]

{ #category : #'tests-comments' }
MicroDownParserTest >> testCommentSimple [

	| source root comment |
	source := parser commentedLineMarkup , 'a comment'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	comment := root children first. 
	self assert: comment text equals: 'a comment'
	
]

{ #category : #'tests-comments' }
MicroDownParserTest >> testCommentedLineMarkupInsideLine [

	| source root paragraph |
	source := 'this is not the start', parser commentedLineMarkup , 'a comment'.
	root :=  parser parse: source.
	self assert: root children size equals: 1.
	paragraph := root children first. 
	self assert: (paragraph isKindOf: GHMParagraphBlock).
	self assert: paragraph text equals: 'this is not the start', parser commentedLineMarkup , 'a comment'
	
]

{ #category : #'tests-math' }
MicroDownParserTest >> testMathBlock [

	| source root math |
	source := parser mathOpeningBlockMarkup , String cr, 
	 '\mathcal{F} = \{ I \subseteq B | support(I) \geq minsup \}', String cr,
	parser mathClosingBlockMarkup, String cr.

	root :=  parser parse: source.
	self assert: root children size equals: 1.
	math := root children first. 
	self assert: (math isKindOf: MicMathBlock). 
	self assert: math body equals: '\mathcal{F} = \{ I \subseteq B | support(I) \geq minsup \}'
	
]

{ #category : #'tests-math' }
MicroDownParserTest >> testMathBlockOnMulitpleLines [

	| source root math |
	source := parser mathOpeningBlockMarkup , String cr, 
	 '\mathcal{F} = \{ I \subseteq B |', String cr, 'support(I) \geq minsup \}', String cr,
	parser mathClosingBlockMarkup, String cr.

	root :=  parser parse: source.
	self assert: root children size equals: 1.
	math := root children first. 
	self assert: (math isKindOf: MicMathBlock). 
	self assert: math body equals: '\mathcal{F} = \{ I \subseteq B |
support(I) \geq minsup \}'
	
]
