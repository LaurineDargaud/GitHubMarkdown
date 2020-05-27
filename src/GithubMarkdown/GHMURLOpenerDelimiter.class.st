"
I'm the opener delimiter for URL.
"
Class {
	#name : #GHMURLOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #testing }
GHMURLOpenerDelimiter class >> isActive [
	^ false
]

{ #category : #accessing }
GHMURLOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
GHMURLOpenerDelimiter class >> markup [
	^ '('
]

{ #category : #accessing }
GHMURLOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMURLOpenerDelimiter >> type [
	^ #url
]
