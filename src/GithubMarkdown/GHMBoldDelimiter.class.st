Class {
	#name : #GHMBoldDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMBoldDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMBoldDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMBoldDelimiter >> markup [
	^ '**'
]

{ #category : #accessing }
GHMBoldDelimiter >> type [
	^ #bold
]
