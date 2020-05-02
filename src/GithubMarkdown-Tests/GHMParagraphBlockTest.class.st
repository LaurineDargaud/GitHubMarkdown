"
A GHMParagraphBlockTest is a test class for testing the behavior of GHMParagraphBlock
"
Class {
	#name : #GHMParagraphBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

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
