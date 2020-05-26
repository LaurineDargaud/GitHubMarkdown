"
I am the opener delimiter for figure name.
"
Class {
	#name : #GHMFigureNameOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMFigureNameOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter class >> markup [
	^ '!['
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> type [
	^ #figure
]
