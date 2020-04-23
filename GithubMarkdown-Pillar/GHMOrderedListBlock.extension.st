Extension { #name : #GHMOrderedListBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMOrderedListBlock >> asPillar [
	^ PROrderedList new
		setChildren: (self children collect: [ :child | child asPillar ]);
		counter: self startIndex;
		yourself
]
