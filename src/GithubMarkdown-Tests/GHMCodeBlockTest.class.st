"
A GHMCodeBlockTest is a test class for testing the behavior of GHMCodeBlock
"
Class {
	#name : #GHMCodeBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMCodeBlockTest >> testCanConsumeLine [ 
	| source root parser textBody argument |
	parser := self parser.
	textBody := 'my fancy code
is really cool'.
	argument := 'ArgumentGoesHere'.
	source := parser codeblockMarkup, argument, String cr, textBody, String cr, parser codeblockMarkup. 
	root := parser parse: source.
	
	"An already created blockNode cannot consume a new code block since no nesting is allowed."
	self deny: (root children first canConsumeLine: '```language=zork').
	
	"An already close blockNode cannot consume even plain text"
	self deny: (root children first canConsumeLine: 'plain text')
]

{ #category : #tests }
GHMCodeBlockTest >> testContents [
	| source root parser textBody argument |
	parser := self parser.
	textBody := 'my fancy code
is really cool'.
	argument := 'ArgumentGoesHere'.
	source := parser codeblockMarkup, argument, String cr, textBody, String cr, parser codeblockMarkup. 
	root := parser parse: source.
	self assert: root children first contents equals: '[ my fancy code
is really cool ]'
]

{ #category : #tests }
GHMCodeBlockTest >> testSingleCodeBlock [
	| source root code parser textBody argument |
	parser := self parser.
	textBody := 'my fancy code'.
	argument := 'Argument'.
	source := parser codeblockMarkup, argument, String cr, textBody, String cr, parser codeblockMarkup. 
	root := self parser parse: source.
	self assert: root children size equals: 1.
	code := root children first.
	self assert: code code equals: textBody.
	self assert: code arguments equals: argument.
]

{ #category : #tests }
GHMCodeBlockTest >> testSingleCodeBlockTwoLines [
	| source root code parser textBody argument |
	parser := self parser.
	textBody := 'my fancy code
is really cool'.
	argument := 'ArgumentGoesHere'.
	source := parser codeblockMarkup, argument, String cr, textBody, String cr, parser codeblockMarkup. 
	root := parser parse: source.
	self 
		assert: root children size 
		equals: 1.
	code := root children first.
	self
		assert: code code
		equals: textBody.
	self 
		assert: code arguments 
		equals: argument
]
