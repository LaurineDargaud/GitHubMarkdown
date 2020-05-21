Class {
	#name : #GHMFigureNameOpenerDelimiter,
	#superclass : #GHMAbstractDelimiter,
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> isCloser [
	^ false
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> isOpener [
	^ true
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> markup [
	^ '!['
]

{ #category : #accessing }
GHMFigureNameOpenerDelimiter >> type [
	^ #figure
]