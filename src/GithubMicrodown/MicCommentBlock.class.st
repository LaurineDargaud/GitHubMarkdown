Class {
	#name : #MicCommentBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#category : #GithubMicrodown
}

{ #category : #markups }
MicCommentBlock >> lineMarkup [

	^ parser commentedLineMarkup 
]
