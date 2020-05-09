Extension { #name : #GHMParser }

{ #category : #'*GithubMarkdown-RichTextComposer' }
GHMParser class >> asRichText: aString [
	^PRRichTextComposer new start: (GHMParser new parse: aString) asPillar
]

{ #category : #'*GithubMarkdown-RichTextComposer' }
GHMParser class >> asText: aString [
	^PRRichTextComposer new start: (GHMParser new parse: aString) asPillar
]
