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
	| source root |
	source := 'This is
a paragraph on two lines'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	self assert: root children first text equals: source
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
