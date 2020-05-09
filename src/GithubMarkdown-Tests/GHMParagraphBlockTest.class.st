"
A GHMParagraphBlockTest is a test class for testing the behavior of GHMParagraphBlock
"
Class {
	#name : #GHMParagraphBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMParagraphBlockTest >> testCanConsumeLine [

	| root listitem parser paragraph |
	self skip.
	parser := self parser. 
	root := parser parse: ''.
	listitem := parser handleLine: '- This is'.
	
	"self assert: (listitem canConsumeLine: 'a paragraph in a list item')."
	"strange I thought that we would get a paragraph in a list item"
	
	parser handleLine: 'a paragraph in a list item'.
	paragraph := parser current.
	self assert: paragraph parent equals: listitem. 
	

	self assert: listitem text equals: 'This is'.
	

]

{ #category : #tests }
GHMParagraphBlockTest >> testCanConsumeLineBasic [

	| root parser paragraph |
	parser := self parser. 
	root := parser parse: ''.
	self assert: root equals: parser current.
	
	root canConsumeLine: 'This is'.
	paragraph := parser handleLine: 'This is'.
	self assert: paragraph equals: parser current.
	
	self assert: paragraph text equals: 'This is'.
	self assert: (paragraph canConsumeLine: 'Another line').
	paragraph := parser handleLine: 'Another line'.
	self assert: paragraph text equals: 'This is
Another line'.
]

{ #category : #tests }
GHMParagraphBlockTest >> testCanConsumeLineOtherBlocks [

	| root parser paragraph |
	parser := self parser. 
	root := parser parse: ''.
	paragraph := parser handleLine: 'This is'.
	self assert: paragraph equals: parser current.	
	self assert: paragraph text equals: 'This is'.
	
	self deny: (paragraph canConsumeLine: '* Another line').
	self deny: (paragraph canConsumeLine: '```Another line').
	self deny: (paragraph canConsumeLine: '> Another line').
	self deny: (paragraph canConsumeLine: '').
	self deny: (paragraph canConsumeLine: '# Section1').
	self deny: (paragraph canConsumeLine: '- ').
	self deny: (paragraph canConsumeLine: '1.  ').
]

{ #category : #tests }
GHMParagraphBlockTest >> testHandlingSequenceOfBasicLinesProducesAParagraph [

	| root parser paragraph |
	parser := self parser. 
	root := parser parse: ''.
	paragraph := parser handleLine: 'This is'.
	paragraph := parser handleLine: 'Another line'.
	paragraph := parser handleLine: '  And that other line'.
	self assert: paragraph text equals: 'This is
Another line
And that other line'.
	self assert: root children size equals: 1
]

{ #category : #tests }
GHMParagraphBlockTest >> testSingleParagraph [
	| root |
	root := self parser parse: 'This is
a paragraph on two lines'.
	self 
		assert: root children first contents 
		equals: '[ This is
a paragraph on two lines ]'

]

{ #category : #tests }
GHMParagraphBlockTest >> testSingleParagraphWithIndentedText [
	| source root expected |
	source := 'This is
   a paragraph with spaces
	and one with tabs'.
	expected := 'This is
a paragraph with spaces
and one with tabs'.
	root := self parser parse: source.
	self assert: root children first text equals: expected
]
