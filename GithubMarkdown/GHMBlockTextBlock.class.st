"
I represent block markup, indicated by '> ' at the beginning of a line. 
"
Class {
	#name : #GHMBlockTextBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMBlockTextBlock >> addLine: line [
	"line is assumed to be of the form '> some text'
	the prefix spaces after $> are removed"

	| argText |
	argText := (line copyFrom: 2 to: line size) trim.
	text := text
		ifNil: [ argText ]
		ifNotNil: [ text , String cr , argText ]
]

{ #category : #testing }
GHMBlockTextBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ line beginsWith: '>'
]

{ #category : #public }
GHMBlockTextBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #accessing }
GHMBlockTextBlock >> text [
	^ text
]