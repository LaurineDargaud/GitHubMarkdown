"
I represent block markup, indicated by '> ' at the beginning of a line. 
"
Class {
	#name : #GHMBlockTextBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #testing }
GHMBlockTextBlock >> addLine: line [
	"line is assumed to be of the form '> some text'
	the prefix spaces after $> are removed"

	| argText |
	argText := (line copyFrom: self lineMarkup size + 1 to: line size) trim.
	text := text
		ifNil: [ argText ]
		ifNotNil: [ text , String cr , argText ]
]

{ #category : #testing }
GHMBlockTextBlock >> canConsumeLine: line [
	"return if this block can consume line i.e., it starts with > "

	^ line beginsWith: self lineMarkup
]

{ #category : #public }
GHMBlockTextBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #testing }
GHMBlockTextBlock >> lineMarkup [

	^ '>'
]

{ #category : #accessing }
GHMBlockTextBlock >> text [
	^ text
]
