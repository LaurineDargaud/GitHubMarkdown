"
A GHMCodeBlockTest is a test class for testing the behavior of GHMCodeBlock
"
Class {
	#name : #GHMCodeBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

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
	root := self parser parse: source.

	root := parser parse: source.
	self assert: root children size equals: 1.
	code := root children first.
	self
		assert: code code
		equals: textBody.
	self assert: code arguments equals: argument
]
