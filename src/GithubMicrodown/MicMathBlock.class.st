Class {
	#name : #MicMathBlock,
	#superclass : #GHMSameMarkupDelimitedBlock,
	#category : #'GithubMicrodown-Core'
}

{ #category : #markups }
MicMathBlock >> lineStartMarkup [

	^ parser mathOpeningBlockMarkup 
]
