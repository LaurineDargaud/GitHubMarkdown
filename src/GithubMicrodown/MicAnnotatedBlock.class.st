"
I'm an attempt to see how we can extend markdown parser.
I should not be a subclass of CodeBlock since I want to be able to include lists and others. 
"
Class {
	#name : #MicAnnotatedBlock,
	#superclass : #GHMCodeBlock,
	#instVars : [
		'label'
	],
	#category : #GithubMicrodown
}

{ #category : #testing }
MicAnnotatedBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form '@@label some text
	
	'
	"

	isClosed
		ifTrue: [ ^ self ].
	label 
		ifNil: [ 
			| indexOfFirstSpace |
			indexOfFirstSpace := line indexOf: Character space.
			label := line copyFrom: self lineMarkup size + 1 to: indexOfFirstSpace - 1.
			body := (line copyFrom: indexOfFirstSpace + 1 to: line size) trim ]
		ifNotNil: [ body := body , String cr , line ]
]

{ #category : #testing }
MicAnnotatedBlock >> canConsumeLine: line [
	"return if this block can consume line"

	"it can be dangerous but let us try"
	^ line isNotEmpty 
]

{ #category : #accessing }
MicAnnotatedBlock >> label [
	^ label
]

{ #category : #testing }
MicAnnotatedBlock >> lineMarkup [

	^ '@@'
]

{ #category : #accessing }
MicAnnotatedBlock >> text [ 

	^ self code
]
