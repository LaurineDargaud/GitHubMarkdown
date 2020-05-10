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
	#superclass : #GHMStartStopDelimitedBlock,
	#instVars : [
		'arguments'
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
		ifNil: [ arguments := line copyFrom: self lineStartMarkup size + 1 to: line size ]
		ifNotNil:
			[ self bodyFromLine: line ].
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

{ #category : #accessing }
GHMCodeBlock >> code [
	^ self body
]

{ #category : #public }
GHMCodeBlock >> contents [ 
	^super contents , '[ ', self code, ' ]'
]

{ #category : #utils }
GHMCodeBlock >> lineStartMarkup [
	"a code block is delimited by ``` "
	
	^ self parser codeblockMarkup 
]
