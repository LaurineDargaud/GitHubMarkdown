"
I represent block markup, indicated by '> ' at the beginning of a line. 
I'm like a preformatted in HTML or Pillar '= '.
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
GHMBlockTextBlock >> addLineAndReturnNextNode: line [
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

	^ self doesLineStartWithMarkup: line
]

{ #category : #public }
GHMBlockTextBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #testing }
GHMBlockTextBlock >> doesLineStartWithMarkup: line [
	"return if the line starts with a markup"

	^ line beginsWith: self lineMarkup
	
]

{ #category : #testing }
GHMBlockTextBlock >> lineMarkup [

	^ self parser preformattedMarkup
]

{ #category : #accessing }
GHMBlockTextBlock >> text [
	^ text
]
