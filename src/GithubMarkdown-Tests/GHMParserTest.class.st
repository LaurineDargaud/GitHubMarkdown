Class {
	#name : #GHMParserTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMParserTest >> testEmpty [
	| source root |
	source := ''.
	root := self parser parse: source.
	self assert: root children size equals: 0.

]

{ #category : #tests }
GHMParserTest >> testEmptyOnMultipleLines [
	| source root |
	source := '


'.
	root := self parser parse: source.
	self assert: root children size equals: 0

]

{ #category : #tests }
GHMParserTest >> testOnceParsedCurrentShouldBeTheRootblock [

	| source root parser |
	source := 'This is
a paragraph on two lines'.
	parser := self parser.
	root := parser parse: source.
	self assert: parser current == root
]
