"
I am the closer delimiter for raw.
"
Class {
	#name : #GHMRawCloserDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMRawCloserDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
GHMRawCloserDelimiter class >> markup [
	^ '}}'
]

{ #category : #accessing }
GHMRawCloserDelimiter >> isOpener [
	^ false
]

{ #category : #accessing }
GHMRawCloserDelimiter >> type [
	^ #raw
]
