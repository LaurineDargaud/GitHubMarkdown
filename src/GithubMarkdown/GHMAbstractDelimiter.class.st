Class {
	#name : #GHMAbstractDelimiter,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #accessing }
GHMAbstractDelimiter class >> index: anIndex [
	^ self new index: anIndex; yourself
]

{ #category : #accessing }
GHMAbstractDelimiter >> index [
	^ index
]

{ #category : #accessing }
GHMAbstractDelimiter >> index: anInteger [
	index := anInteger
]

{ #category : #testing }
GHMAbstractDelimiter >> isActive [
	^ true
]

{ #category : #accessing }
GHMAbstractDelimiter >> isCloser [
	^ self subclassResponsibility 
]

{ #category : #accessing }
GHMAbstractDelimiter >> isOpener [
	^ self subclassResponsibility 
]

{ #category : #accessing }
GHMAbstractDelimiter >> markup [
	^ self subclassResponsibility 
]

{ #category : #accessing }
GHMAbstractDelimiter >> size [
	^ self markup size
]

{ #category : #accessing }
GHMAbstractDelimiter >> type [
	^ self subclassResponsibility 
]
