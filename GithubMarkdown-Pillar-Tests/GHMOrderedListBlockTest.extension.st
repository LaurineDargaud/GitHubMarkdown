Extension { #name : #GHMOrderedListBlockTest }

{ #category : #'*GithubMarkdown-Pillar-Tests' }
GHMOrderedListBlockTest >> testSingleLevelList2asPillar [
	| source root list |
	source := '19. item 1
    expanded
7.  item 2'.
	root := GHMParser new parse: source.
	list := root children first asPillar.
	self assert: list class equals: PROrderedList .
	self assert: list children size equals: 2.
	self
		assert: list children first text
		equals:
			'item 1
expanded'.
	self assert: list counter equals: 19
]
