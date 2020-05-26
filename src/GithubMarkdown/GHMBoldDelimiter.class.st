"
I am the delimiter for bold/strong format.
"
Class {
	#name : #GHMBoldDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMBoldDelimiter class >> isCloser [
	^ true
]

{ #category : #accessing }
GHMBoldDelimiter class >> markup [
	^ '**'
]

{ #category : #accessing }
GHMBoldDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMBoldDelimiter >> type [
	^ #bold
]
