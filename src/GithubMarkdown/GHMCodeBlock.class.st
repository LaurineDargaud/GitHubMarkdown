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
		'done'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #'as yet unclassified' }
GHMCodeBlock class >> opensBy: aLine [
	^ aLine beginsWith: '> '
]

{ #category : #testing }
GHMCodeBlock >> addLine: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	done
		ifTrue: [ ^ self ].
	arguments
		ifNil: [ arguments := line copyFrom: 4 to: line size ]
		ifNotNil: [ code := (code ifNil: [ line ] ifNotNil: [ code , String cr , line ])  ]
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
	^ line beginsWith: self codeblockMarkup
]

{ #category : #testing }
GHMCodeBlock >> canConsumeLine: line [
	"return if this block can consume line"

	done
		ifTrue: [ ^ false ].
	done := line beginsWith: self codeblockMarkup.
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

{ #category : #testing }
GHMCodeBlock >> codeblockMarkup [
	^ '```'
]

{ #category : #public }
GHMCodeBlock >> contents [ 
	^super contents , '[ ', self code, ' ]'
]

{ #category : #initialization }
GHMCodeBlock >> initialize [
	super initialize. 
	done := false
]