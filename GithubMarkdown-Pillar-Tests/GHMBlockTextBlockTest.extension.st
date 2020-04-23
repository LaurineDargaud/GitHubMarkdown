Extension { #name : #GHMBlockTextBlockTest }

{ #category : #'*GithubMarkdown-Pillar-Tests' }
GHMBlockTextBlockTest >> testBlockTextAsPilar [
	| source root pillarNode |
	source := '> text1
>    text2'.
	root := GHMParser new parse: source.
	self assert: root children size equals: 1.
	pillarNode := root children first asPillar.
	self assert: pillarNode class equals: PREnvironment .
	self assert: pillarNode name equals: 'textBlock'.
	self
		assert: pillarNode text
		equals:
			'text1
text2'
]
