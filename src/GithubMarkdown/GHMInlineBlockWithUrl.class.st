"
I am used to represent links and images which has a url.
"
Class {
	#name : #GHMInlineBlockWithUrl,
	#superclass : #GHMInlineBlock,
	#instVars : [
		'url'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #accessing }
GHMInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
GHMInlineBlockWithUrl >> url: anObject [
	url := anObject
]
