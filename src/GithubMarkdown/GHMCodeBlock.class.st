"
I am a code block. I look like this, starting and ending with three $`
my 'arguments' is just the text from the fourth character up to the end of line.

```arguments
line 1
line 2
line 3
``` 

"
Class {
	#name : #GHMCodeBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'code',
		'arguments',
		'isClosed'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #testing }
GHMCodeBlock >> addLineAndReturnNextNode: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	isClosed
		ifTrue: [ ^ self ].
	arguments
		ifNil: [ arguments := line copyFrom: self lineMarkup size + 1 to: line size ]
		ifNotNil: [ code := (code ifNil: [ line ] ifNotNil: [ code , String cr , line ]) ].
	^ self
]

{ #category : #accessing }
GHMCodeBlock >> arguments [
	^ arguments
]

{ #category : #accessing }
GHMCodeBlock >> arguments: aString [
	arguments := aString
]

{ #category : #testing }
GHMCodeBlock >> canCloseWith: line [
	self flag: #nosenders.
	"looks like unfinished but this is probably an important hook to add for example for our <? ?>"
	^ line beginsWith: self codeblockMarkup
]

{ #category : #testing }
GHMCodeBlock >> canConsumeLine: line [
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

{ #category : #accessing }
GHMCodeBlock >> code [
	^ code
]

{ #category : #accessing }
GHMCodeBlock >> code: aString [
	code := aString
]

{ #category : #public }
GHMCodeBlock >> contents [ 
	^super contents , '[ ', self code, ' ]'
]

{ #category : #testing }
GHMCodeBlock >> doesLineStartWithMarkup: line [
	"return if the line starts with a markup"

	^ line beginsWith: self lineMarkup
	
]

{ #category : #initialization }
GHMCodeBlock >> initialize [
	super initialize. 
	isClosed := false
]

{ #category : #utils }
GHMCodeBlock >> lineMarkup [
	"a code block is delimited by ``` "
	^ self parser codeblockMarkup 
]
