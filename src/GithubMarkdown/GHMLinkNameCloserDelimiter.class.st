Class {
	#name : #GHMLinkNameCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> markup [
	^ ']'
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> type [
	^ #linkName
]
