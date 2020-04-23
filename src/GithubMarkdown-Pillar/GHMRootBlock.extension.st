Extension { #name : #GHMRootBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMRootBlock >> asPillar [
	^ PRDocument new
		setChildren: (self children collect: [ :child | child asPillar ]);
		yourself
]
