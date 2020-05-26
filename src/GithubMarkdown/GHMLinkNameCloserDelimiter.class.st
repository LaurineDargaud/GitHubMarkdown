"
I am the closer delimiter for link name.
"
Class {
	#name : #GHMLinkNameCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMLinkNameCloserDelimiter class >> markup [
	^ ']'
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
GHMLinkNameCloserDelimiter >> type [
	^ #linkName
]
