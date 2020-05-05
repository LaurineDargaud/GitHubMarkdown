Extension { #name : #GHMBlockTextBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMBlockTextBlock >> asPillar [
	self flag: #fixMe. 
	"this is not an environment in Pillar but a preformatted"
	^ PREnvironment new
		name: 'textBlock';
		setChildren:  (self splitString: text);
		yourself
]
