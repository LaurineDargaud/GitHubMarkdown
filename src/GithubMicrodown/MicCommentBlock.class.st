Class {
	#name : #MicCommentBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#category : #'GithubMicrodown-Core'
}

{ #category : #markups }
MicCommentBlock >> lineMarkup [

	^ parser commentedLineMarkup 
]
