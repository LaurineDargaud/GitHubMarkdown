Class {
	#name : #GHMTableBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMTableBlockTest >> testSimpleTable [

	| source root |
	source := '| col1 row1 | col2 row1 |
| col1 row1 | col2 row1 |'.
	root := parser parse: source.
	self assert: (root children first isKindOf: GHMTableBlock)

]
