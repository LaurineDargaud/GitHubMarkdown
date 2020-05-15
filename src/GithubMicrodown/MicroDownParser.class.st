Class {
	#name : #MicroDownParser,
	#superclass : #GHMParser,
	#category : #GithubMicrodown
}

{ #category : #markups }
MicroDownParser class >> anchorMarkup [
	^ '@@'
]

{ #category : #markups }
MicroDownParser class >> annotatedParagraphMarkup [
	^ '!!'
]

{ #category : #markups }
MicroDownParser class >> commentedLineMarkup [

	^ '%'
]

{ #category : #markups }
MicroDownParser class >> mathClosingBlockMarkup [
	self flag: #fixMe. 
	"should implement block logic for different opening and closing this way we could have 
	a different markup."
	
	^ '&'
]

{ #category : #markups }
MicroDownParser class >> mathOpeningBlockMarkup [

	^ '&'
]

{ #category : #markups }
MicroDownParser >> anchorMarkup [
	^ self class anchorMarkup
]

{ #category : #markups }
MicroDownParser >> annotatedParagraphMarkup [
	^ self class annotatedParagraphMarkup
]

{ #category : #'node creation' }
MicroDownParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	(line beginsWith: self annotatedParagraphMarkup)
		ifTrue: [ ^ MicAnnotatedBlock ].
	(line beginsWith: self anchorMarkup )
		ifTrue: [ ^ MicAnchorBlock ].
	(line beginsWith: self commentedLineMarkup )
		ifTrue: [ ^ MicCommentBlock ].
	(line beginsWith: self mathOpeningBlockMarkup)
		ifTrue: [ ^ MicMathBlock ].
	^ nil
]

{ #category : #markups }
MicroDownParser >> commentedLineMarkup [

	^ self class commentedLineMarkup
]

{ #category : #markups }
MicroDownParser >> mathClosingBlockMarkup [
	^ self class mathClosingBlockMarkup
]

{ #category : #markups }
MicroDownParser >> mathOpeningBlockMarkup [
	^ self class mathOpeningBlockMarkup
]
