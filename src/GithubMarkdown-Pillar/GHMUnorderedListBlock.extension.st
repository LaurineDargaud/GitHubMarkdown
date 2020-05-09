Extension { #name : #GHMUnorderedListBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMUnorderedListBlock >> asPillar [
	^ PRUnorderedList new
		setChildren: (self children collect:[:child| child asPillar]);
		yourself
]
