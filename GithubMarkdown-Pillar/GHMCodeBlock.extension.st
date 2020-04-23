Extension { #name : #GHMCodeBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMCodeBlock >> asPillar [
	^ PRCodeblock new
		language: self arguments;
		text: self code;
		yourself
]
