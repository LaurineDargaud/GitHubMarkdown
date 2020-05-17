"
Support table with a simple and more relax setup than github.
A table is not forced to have a header definition.

| aaab | jkhjh |
| --- |
| bar |

or 
|aaab|jkhjh|
|---|
|bar|

or 
| aaa | bbb |
|ccc |ddd |

or 
| aaa | bbb
| cc | ddd

Block-level elements cannot be inserted in a table.

When a table contains a header it is the first row and all rows should have that size else they are cut. 


Known limits: how to put a pipe in a table? 
No support for \|

"
Class {
	#name : #GHMTableBlock,
	#superclass : #GHMContinuousMarkedBlock,
	#instVars : [
		'rows',
		'hasHeader'
	],
	#category : #'GithubMarkdown-Model'
}

{ #category : #markups }
GHMTableBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form 'chararacters some text' e.g., '> some text'
	the prefix spaces after $> are removed"

	rows add: (self extractLine: line)
	
]

{ #category : #markups }
GHMTableBlock >> extractLine: line [
	"For now we have 
		| something | something | 
		or 
		| something | something"
		^ (line findBetweenSubstrings: #($|)) collect: [ :each | each trim ]
		
				
		
]

{ #category : #markups }
GHMTableBlock >> extractLineOld: line [
	"For now we have 
		| something | something | 
		or 
		| something | something"
		| acc rowElements cLine |
		acc := ''.
		rowElements := OrderedCollection new. 
		cLine := line allButFirst.
		cLine do: [ :each | 
				each = $|  
					ifTrue: [ rowElements add: acc trim. acc := ''  ]
					ifFalse: [ acc := acc, (String with: each) ]
						 ].
		(line last = $|)
			ifFalse: [ rowElements add: acc trim ].
		^ rowElements 			
					
		
				
		
]

{ #category : #markups }
GHMTableBlock >> initialize [ 
	super initialize.
	rows := OrderedCollection new.
]

{ #category : #markups }
GHMTableBlock >> lineMarkup [

	^ parser tableCellMarkup
]

{ #category : #accessing }
GHMTableBlock >> rows [
	^ rows
]
