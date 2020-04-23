Extension { #name : #GHMBlockTextBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMBlockTextBlock >> asPillar [
	^ PREnvironment new
		name: 'textBlock';
		setChildren:  (self splitString: text);
		yourself
]
