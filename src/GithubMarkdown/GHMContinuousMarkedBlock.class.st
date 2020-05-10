"
I'm an abstract block for blocks requiring a systematic simple character or character sequences at the beginning of each line. 

For example 
> this is an example
> and another one

In addition my contents is not further treated. 


"
Class {
	#name : #GHMContinuousMarkedBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #testing }
GHMContinuousMarkedBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form 'chararacters some text' e.g., '> some text'
	the prefix spaces after $> are removed"

	| argText |
	argText := (line copyFrom: self lineMarkup size + 1 to: line size) trim.
	text := text
		ifNil: [ argText ]
		ifNotNil: [ text , String cr , argText ]
]

{ #category : #testing }
GHMContinuousMarkedBlock >> canConsumeLine: line [
	"return if this block can consume line i.e., it starts with sensible characters, e.g., > "

	^ self doesLineStartWithMarkup: line
]

{ #category : #public }
GHMContinuousMarkedBlock >> contents [ 
	^ super contents , '[ ', self text, ' ]'
]

{ #category : #testing }
GHMContinuousMarkedBlock >> doesLineStartWithMarkup: line [
	"return if the line starts with a markup"

	^ line beginsWith: self lineMarkup
	
]

{ #category : #markups }
GHMContinuousMarkedBlock >> lineMarkup [

	^ self subclassResponsibility 
]

{ #category : #accessing }
GHMContinuousMarkedBlock >> text [
	^ text
]
