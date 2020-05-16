Class {
	#name : #GHMTableBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#instVars : [
		'rows'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #markups }
GHMTableBlock >> lineMarkup [

	^ parser tableCellMarkup
]
