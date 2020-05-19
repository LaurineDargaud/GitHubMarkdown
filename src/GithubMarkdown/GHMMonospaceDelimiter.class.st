Class {
	#name : #GHMMonospaceDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMMonospaceDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMMonospaceDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMMonospaceDelimiter >> markup [
	^ '`'
]

{ #category : #accessing }
GHMMonospaceDelimiter >> type [
	^ #monospace
]
