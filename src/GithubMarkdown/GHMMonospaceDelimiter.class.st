"
I am the delimiter for monospace/inline code format.
"
Class {
	#name : #GHMMonospaceDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMMonospaceDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
GHMMonospaceDelimiter class >> markup [
	^ '`'
]

{ #category : #accessing }
GHMMonospaceDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMMonospaceDelimiter >> type [
	^ #monospace
]
