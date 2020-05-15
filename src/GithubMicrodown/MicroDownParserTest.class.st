Class {
	#name : #MicroDownParserTest,
	#superclass : #TestCase,
	#category : #GithubMicrodown
}

{ #category : #tests }
MicroDownParserTest >> parser [ 

	^ MicroDownParser new
]

{ #category : #tests }
MicroDownParserTest >> testAnnotatedBlock [
	| source root annotated |
	source := '@@important this is an important paragraph on one line.'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'important'.
	self assert: annotated code equals: 'this is an important paragraph on one line.'
	

]

{ #category : #tests }
MicroDownParserTest >> testAnnotatedBlockOnMultipleLines [

	| parser source root annotated  line |
	
	source := '@@important this is an 
important point because...!' readStream.

 	parser := self parser. 
	
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

{ #category : #tests }
MicroDownParserTest >> testAnnotatedBlockOnTwoLines [
	| source root annotated |
	source := '@@important this is an important 
paragraph on two lines.'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is an important
paragraph on two lines.'

]

{ #category : #tests }
MicroDownParserTest >> testAnnotatedBlockWithList [
	"The test does not test what we want. We want a listblock inside the annotatedBlock"
	| parser source root annotated  line |
	self flag: #fixme.
	source := '@@important this is a point
- one
* two ' readStream.

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
