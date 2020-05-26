"
I am the closer delimiter for URL.
"
Class {
	#name : #GHMURLCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #testing }
GHMURLCloserDelimiter class >> isActive [
	^ false
]

{ #category : #accessing }
GHMURLCloserDelimiter class >> markup [
	^ ')'
]

{ #category : #accessing }
GHMURLCloserDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMURLCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
GHMURLCloserDelimiter >> type [
	^ #url
]
