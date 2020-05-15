Class {
	#name : #MicMathBlock,
	#superclass : #GHMStartStopDelimitedBlock,
	#category : #'GithubMicrodown-Core'
}

{ #category : #markups }
MicMathBlock >> lineStartMarkup [

	^ parser mathOpeningBlockMarkup 
]
