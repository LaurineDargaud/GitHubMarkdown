"
A GHMBlockTextBlockTest is a test class for testing the behavior of GHMBlockTextBlock
"
Class {
	#name : #GHMBlockTextBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMBlockTextBlockTest >> testContents [
	| source root |
	source := '> text1
>    text2'.
	root := self parser parse: source.
	self assert: root children first contents equals: '[ text1
text2 ]'
]

{ #category : #tests }
GHMBlockTextBlockTest >> testShowStructure [
	| source root |
	source := '> text1
>    text2'.
	root := self parser parse: source.
	self assert: (root children first showStructure: 0) equals: 'GHMBlockTextBlock
'
]

{ #category : #tests }
GHMBlockTextBlockTest >> testSingleBlockTextBlock [
	| source root text  |
	source := '> text1
>    text2'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
text2'
]
