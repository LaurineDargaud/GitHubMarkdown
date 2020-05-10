"
I'm abstract block for the logic of elements which are managed by a 

startMarkup
body 
endMarkup 

My subclass should define lineMarkup
"
Class {
	#name : #GHMStartStopDelimitedBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'isClosed',
		'body'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #handle }
GHMStartStopDelimitedBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	isClosed
		ifTrue: [ ^ self ].
	self bodyFromLine: line.
	^ self
]

{ #category : #accessing }
GHMStartStopDelimitedBlock >> body [
	^ body
]

{ #category : #accessing }
GHMStartStopDelimitedBlock >> body: anObject [
	^ body := anObject
]

{ #category : #handle }
GHMStartStopDelimitedBlock >> bodyFromLine: line [
	body := body ifNil: [ line ] ifNotNil: [ body , String cr , line ]
]

{ #category : #testing }
GHMStartStopDelimitedBlock >> canConsumeLine: line [
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
GHMStartStopDelimitedBlock >> doesLineStartWithMarkup: line [
	"return if the line starts with a markup"

	^ line beginsWith: self lineStartMarkup
	
]

{ #category : #initialization }
GHMStartStopDelimitedBlock >> initialize [
	super initialize. 
	isClosed := false
]

{ #category : #testing }
GHMStartStopDelimitedBlock >> isClosed [
	^ isClosed		
]

{ #category : #markups }
GHMStartStopDelimitedBlock >> lineStartMarkup [

	^ self subclassResponsibility 
]
