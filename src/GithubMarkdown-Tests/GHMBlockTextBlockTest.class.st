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
GHMBlockTextBlockTest >> testNotLazy [
	"the spec says that the last > could be omitted but we do not support it."
	| source root text  |
	source := '> text1
>   - text2
text3'.
	root := self parser parse: source.
	self assert: root children size equals: 2.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
- text2'
]

{ #category : #tests }
GHMBlockTextBlockTest >> testShowStructure [
	| source root |
	source := '> text1
>    text2'.
	root := self parser parse: source.
	self assert: (root children first showStructure: 0) equals: 'GHMQuoteBlock
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

{ #category : #tests }
GHMBlockTextBlockTest >> testSingleBlockTextBlockDoesNotInterpretOtherBlockMarkup [
	| source root text  |
	source := '> text1
>   - text2
> ```languague=pharo
> Yeah cool'.
	root := self parser parse: source.
	self assert: root children size equals: 1.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
- text2
```languague=pharo
Yeah cool'
]

{ #category : #tests }
GHMBlockTextBlockTest >> testSingleBlockTextBlockFollowedByList [
	| source root text list |
	source := '> text1
>    text2
1. first
2. second
3. third'.
	root := self parser parse: source.
	self assert: root children size equals: 2.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
text2'.
	list := root children second.
	self assert: list children size equals: 3
]
