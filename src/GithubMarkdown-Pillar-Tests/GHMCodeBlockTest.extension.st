Extension { #name : #GHMCodeBlockTest }

{ #category : #'*GithubMarkdown-Pillar-Tests' }
GHMCodeBlockTest >> testSingleCodeBlockTwoLinesAsPillar [
	| source root code |
	source := '```MyLanguage
my fancy code
is really cool
````'.
	root := GHMParser new parse: source.
	code := root children first asPillar.
	self
		assert: code text
		equals:
			'my fancy code
is really cool'.
	self assert: code language originalName equals: 'MyLanguage'
]
