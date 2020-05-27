"
I am the opener delimiter for link name.
"
Class {
	#name : #GHMLinkNameOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMLinkNameOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter class >> markup [
	^ '['
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMLinkNameOpenerDelimiter >> type [
	^ #linkName
]
