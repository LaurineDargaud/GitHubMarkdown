Extension { #name : #GHMAbstractBlock }

{ #category : #'*GithubMarkdown-Pillar' }
GHMAbstractBlock >> splitString: aString [
	"convenience method"
	^GHMIntraBlockSplitter new pillarFrom: aString.
]
