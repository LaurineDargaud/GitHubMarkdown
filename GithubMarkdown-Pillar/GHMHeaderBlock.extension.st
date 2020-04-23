Extension { #name : #GHMHeaderBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMHeaderBlock >> asPillar [
	^ PRHeader new
		level: self level;
		setChildren: (self splitString: header);
		yourself
]
