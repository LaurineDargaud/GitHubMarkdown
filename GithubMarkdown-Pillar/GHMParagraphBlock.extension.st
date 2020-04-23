Extension { #name : #GHMParagraphBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMParagraphBlock >> asPillar [
	^ PRParagraph  new
		setChildren: (self splitString: text);
		yourself
]
