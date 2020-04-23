Extension { #name : #GHMHeaderBlockTest }

{ #category : #'*GithubMarkdown-Pillar-Tests' }
GHMHeaderBlockTest >> testHeaderLevel4AsPillar [
	| source root pillar |
	source := '####    Level four'.
	root := GHMParser new parse: source.
	pillar := root children first asPillar.
	self assert: pillar class equals: PRHeader.
	self assert: pillar children first class equals: PRText.
	self assert: pillar children first text equals: 'Level four'
]