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
	| source root annotated |
	self skip.
	source := '@@important this is an important because:
- first
- second'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	annotated := root children first. 
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is an important because:'.
	self assert: annotated children size equals: 1

]

{ #category : #tests }
MicroDownParserTest >> testCheckingParsingOfItemListInAnnotatedBlock [

	| parser source root annotated list |
	
	source := '@@important this is an important because:
- first
- second' readStream.

 	parser := self parser. 
	
	"first the root block"
	root := parser parse: ''.
	self assert: parser current equals: root. 
	
	"second the annotated"
	annotated := parser handleLine: source nextLine.
	self assert: parser current equals: annotated.
	self assert: annotated parent equals: root.  
	
	self assert: annotated label equals: 'important'.
	self assert: annotated text equals: 'this is an important because:'.

	"ok now the list"	
	list := parser handleLine: source nextLine.
	self halt.

]
