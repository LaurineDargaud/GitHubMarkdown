Class {
	#name : #GHMBlockTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #factory }
GHMBlockTest >> listBlockClass [
	^ GHMListBlock
]

{ #category : #factory }
GHMBlockTest >> orderedListBlockClass [
	^ GHMOrderedListBlock
]

{ #category : #factory }
GHMBlockTest >> parser [
	^ self parserClass new
]

{ #category : #factory }
GHMBlockTest >> parserClass [
	^ GHMParser
]

{ #category : #factory }
GHMBlockTest >> rootBlockClass [
	^ GHMRootBlock
]
