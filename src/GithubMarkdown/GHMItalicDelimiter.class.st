"
I am the delimiter for italic/emphasis format.
"
Class {
	#name : #GHMItalicDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMItalicDelimiter class >> markup [
	^ '_'
]

{ #category : #accessing }
GHMItalicDelimiter >> isCloser [
	^ true
]

{ #category : #accessing }
GHMItalicDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMItalicDelimiter >> type [
	^ #italic
]
