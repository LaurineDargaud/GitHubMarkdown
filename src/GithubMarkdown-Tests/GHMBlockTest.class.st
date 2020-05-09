Class {
	#name : #GHMBlockTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMBlockTest >> orderedListBlockClass [
	^ GHMOrderedListBlock
]

{ #category : #tests }
GHMBlockTest >> parser [
	^ self parserClass new
]

{ #category : #tests }
GHMBlockTest >> parserClass [
	^ GHMParser
]

{ #category : #tests }
GHMBlockTest >> rootBlockClass [
	^ GHMRootBlock
]
