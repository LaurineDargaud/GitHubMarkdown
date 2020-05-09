Class {
	#name : #MicroDownParser,
	#superclass : #GHMParser,
	#category : #GithubMicrodown
}

{ #category : #markups }
MicroDownParser class >> annotatedBlockMarkup [
	^ '@@'
]

{ #category : #markups }
MicroDownParser >> annotatedBlockMarkup [
	^ self class annotatedBlockMarkup
]

{ #category : #'node creation' }
MicroDownParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	(line beginsWith: self annotatedBlockMarkup)
		ifTrue: [ ^ MicAnnotatedBlock ].
	^ nil
]
