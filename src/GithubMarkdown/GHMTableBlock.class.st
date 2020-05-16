Class {
	#name : #GHMTableBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#instVars : [
		'rows'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #markups }
GHMTableBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form 'chararacters some text' e.g., '> some text'
	the prefix spaces after $> are removed"

	rows add: (self extractLine: line)
	
]

{ #category : #markups }
GHMTableBlock >> extractLine: line [
	"For now we have 
		| something | something | 
		or 
		| something | something "
		
		
		^ line splitOn: '|'
	
]

{ #category : #markups }
GHMTableBlock >> initialize [ 
	super initialize.
	rows := OrderedCollection new.
]

{ #category : #markups }
GHMTableBlock >> lineMarkup [

	^ parser tableCellMarkup
]
