"
I represent a delimiter used in grammar. I'm abstract.
I'm useful for inline split parsing process.

Methods to overide:
- isCloser, isOpener: answer true or false whether am I a closing markup or an opening markup (I can be both for a format for instance, when markup is the same for both uses)
- type: my type name, as a symbol
- markup (a string)

isActive is true when I must be part of searched delimiters during normal inline split process.
(false for instance for delimiters relative to link or figure since they are analyzed in special procedure)

My index refers to the index character in global string which is parsed.

Always instantiate me with my constructor ""index:"" to precise it.
"
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

{ #category : #testing }
GHMAbstractDelimiter class >> isActive [
	^ true
]

{ #category : #accessing }
GHMAbstractDelimiter class >> isCloser [
	^ self subclassResponsibility 
]

{ #category : #accessing }
GHMAbstractDelimiter class >> markup [
	^ self subclassResponsibility 
]

{ #category : #accessing }
GHMAbstractDelimiter class >> size [
	^ self markup size
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
	^ self class isActive
]

{ #category : #testing }
GHMAbstractDelimiter >> isCloser [
	^ self class isCloser
]

{ #category : #accessing }
GHMAbstractDelimiter >> isOpener [
	^ self subclassResponsibility 
]

{ #category : #testing }
GHMAbstractDelimiter >> markup [
	^ self class markup
]

{ #category : #accessing }
GHMAbstractDelimiter >> size [
	^ self class size
]

{ #category : #accessing }
GHMAbstractDelimiter >> type [
	^ self subclassResponsibility 
]
