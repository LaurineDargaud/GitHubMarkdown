Class {
	#name : #GHMTableBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMTableBlockTest >> testExtractLine [

	| table |
	table := GHMTableBlock new.
	self assert: (table extractLine: '| x y | z k |') asArray equals: #( 'x y' 'z k').
	self assert: (table extractLine: '| x y | z k') asArray equals: #( 'x y' 'z k').
	self assert: (table extractLine: '| x y | z k | |') asArray equals: #( 'x y' 'z k' '').
	self assert: (table extractLine: '|     | z k | oui |') asArray equals: #( '' 'z k' 'oui').
]

{ #category : #tests }
GHMTableBlockTest >> testSimpleTable [

	| source root table |
	source := '| col1 row1 | col2 row1 |
| col1 row2 | col2 row2 |'.
	root := parser parse: source.
	table := root children first.
	self assert: (table isKindOf: GHMTableBlock).
	self assert: table rows first asArray equals: #('col1 row1'  'col2 row1').
	self assert: table rows second asArray equals: #('col1 row2'  'col2 row2').
]
