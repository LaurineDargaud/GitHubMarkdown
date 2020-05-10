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
	
	"SD: I thought that a list item was holding a paragraph but it holds directly text."
	| normalized |
	text
		ifNil: [ text := line trim.
			^ self ].
	normalized := line copyFrom: parent indent + 1 to: line size.	"drop indent"
		
	"to clean: but for now if the block to be created is list... create one"	
	({GHMOrderedListBlock.
	GHMUnorderedListBlock} includes: (self blockStarterClassFrom: normalized))
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

{ #category : #accessing }
GHMListItemBlock >> text [
	^ text
]
