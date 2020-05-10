"
I represent block markup, indicated by '> ' at the beginning of a line. 
I'm like a preformatted in HTML or Pillar '= '.
In addition every single line should starts with '> '.

In githubmarkdown the definitions are just super complex and we do not follow them. 

	""A block quote marker consists of 0-3 spaces of initial indent, plus (a) the character > together with a following space, or (b) a single character > not followed by a space.""

"
Class {
	#name : #GHMQuoteBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #testing }
GHMQuoteBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form '> some text'
	the prefix spaces after $> are removed"

	| argText |
	argText := (line copyFrom: self lineMarkup size + 1 to: line size) trim.
	text := text
		ifNil: [ argText ]
		ifNotNil: [ text , String cr , argText ]
]

{ #category : #testing }
GHMQuoteBlock >> canConsumeLine: line [
	"return if this block can consume line i.e., it starts with > "

	^ self doesLineStartWithMarkup: line
]

{ #category : #public }
GHMQuoteBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #testing }
GHMQuoteBlock >> doesLineStartWithMarkup: line [
	"return if the line starts with a markup"

	^ line beginsWith: self lineMarkup
	
]

{ #category : #testing }
GHMQuoteBlock >> lineMarkup [

	^ self parser preformattedMarkup
]

{ #category : #accessing }
GHMQuoteBlock >> text [
	^ text
]
