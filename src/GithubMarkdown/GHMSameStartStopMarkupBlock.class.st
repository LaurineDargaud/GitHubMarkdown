"
I'm abstract block for the logic of elements which are managed by a 

startMarkup
body 
endMarkup 

My subclass should define lineMarkup
"
Class {
	#name : #GHMSameStartStopMarkupBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'isClosed',
		'body',
		'firstLine'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #handle }
GHMSameStartStopMarkupBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	isClosed
		ifTrue: [ ^ self ].
	firstLine
		ifNil:
			[ firstLine := self extractFirstLineFrom: line ]
		ifNotNil: [ self bodyFromLine: line ].
	^ self
]

{ #category : #accessing }
GHMSameStartStopMarkupBlock >> body [
	^ body
]

{ #category : #accessing }
GHMSameStartStopMarkupBlock >> body: anObject [
	^ body := anObject
]

{ #category : #handle }
GHMSameStartStopMarkupBlock >> bodyFromLine: line [
	
	body := body ifNil: [ line ] ifNotNil: [ body , String cr , line ]
]

{ #category : #testing }
GHMSameStartStopMarkupBlock >> canConsumeLine: line [
	"As soon as a line closes a code block, it does not accept anymore any line.
	Indeed imagine 
	
	```
	a line 
	```
	The first line was accepted by its parent (a root block and the code block got created.
	then a line was accepting since done was false...
	then the closing line was reached and the code block got closed.)
	
	"

	isClosed
		ifTrue: [ ^ false ].
	isClosed := self doesLineStartWithMarkup: line.
	^ true
]

{ #category : #testing }
GHMSameStartStopMarkupBlock >> doesLineStartWithMarkup: line [
	"return if the line starts with a markup"

	^ line beginsWith: self lineStartMarkup
	
]

{ #category : #handle }
GHMSameStartStopMarkupBlock >> extractFirstLineFrom: line [
	^ line copyFrom: self lineStartMarkup size + 1 to: line size
]

{ #category : #accessing }
GHMSameStartStopMarkupBlock >> firstLine [
	^ firstLine
]

{ #category : #accessing }
GHMSameStartStopMarkupBlock >> firstLine: anObject [
	firstLine := anObject
]

{ #category : #initialization }
GHMSameStartStopMarkupBlock >> initialize [
	super initialize. 
	isClosed := false
]

{ #category : #testing }
GHMSameStartStopMarkupBlock >> isClosed [
	^ isClosed		
]

{ #category : #markups }
GHMSameStartStopMarkupBlock >> lineStartMarkup [

	^ self subclassResponsibility 
]
