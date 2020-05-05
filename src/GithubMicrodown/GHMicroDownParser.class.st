Class {
	#name : #GHMicroDownParser,
	#superclass : #GHMParser,
	#category : #GithubMicrodown
}

{ #category : #'node creation' }
GHMicroDownParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	(line beginsWith: '@@')
		ifTrue: [ ^ MicAnnotatedBlock ].
		
	^ nil
]
