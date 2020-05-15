Class {
	#name : #MicMathBlock,
	#superclass : #GHMStartStopDelimitedBlock,
	#category : #GithubMicrodown
}

{ #category : #markups }
MicMathBlock >> lineStartMarkup [

	^ parser mathOpeningBlockMarkup 
]
