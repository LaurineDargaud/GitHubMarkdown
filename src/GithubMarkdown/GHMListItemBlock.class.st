"
I represent one item in a list (ordered or non-ordered)
"
Class {
	#name : #GHMListItemBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #testing }
GHMListItemBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."
	
	
	| normalized |
	text
		ifNil: [ text := line trim.
			^ self ].
	normalized := line copyFrom: parent indent + 1 to: line size.	"drop indent"
	"SD: I thought that a list item was holding a paragraph but it holds directly text."
		
	(self isAList: normalized)
		ifTrue: [ ^ self newBlockFor: normalized parent: self ]
		ifFalse: [ text := text , String cr , normalized ]
]

{ #category : #testing }
GHMListItemBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ line beginsWith: (' ' repeat: parent indent)
]

{ #category : #public }
GHMListItemBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #testing }
GHMListItemBlock >> isAList: normalized [

	^ parser isAList: normalized
]

{ #category : #accessing }
GHMListItemBlock >> text [
	^ text
]
