"
I am the opener delimiter for link name.
"
Class {
	#name : #GHMLinkNameOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #testing }
GHMLinkNameOpenerDelimiter class >> isActive [
	^ false
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter class >> markup [
	^ '['
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> type [
	^ #linkName
]
