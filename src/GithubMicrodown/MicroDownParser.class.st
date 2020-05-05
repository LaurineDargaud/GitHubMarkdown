Class {
	#name : #MicroDownParser,
	#superclass : #GHMParser,
	#category : #GithubMicrodown
}

{ #category : #'node creation' }
MicroDownParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	(line beginsWith: '@@')
		ifTrue: [ ^ MicAnnotatedBlock ].
		
	^ nil
]
