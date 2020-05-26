"
I'm the delimiter for strikethrough format.
"
Class {
	#name : #GHMStrikeDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMStrikeDelimiter class >> markup [
	^ '~'
]

{ #category : #accessing }
GHMStrikeDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMStrikeDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMStrikeDelimiter >> type [
	^ #strike
]
