"
A GHMOrderedListBlockTest is a test class for testing the behavior of GHMOrderedListBlock
"
Class {
	#name : #GHMOrderedListBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMOrderedListBlockTest >> testEmbeddedUnordered [
	| source root list |
	source := 
'1. item 1
   - sublevel item 1
   - sublevel item 2
1. item 2'.
	root := self parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second text equals: 'item 2'.
	self assert: list children first "item 1"
			children first "unordered list"
			children second "sub item"
			text equals: 'sublevel item 2'
]

{ #category : #tests }
GHMOrderedListBlockTest >> testSingleLevelList2 [
	| source root list |
	source := 
'19. item 1
    expanded
7.  item 2'.
	root := self parser parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children first text equals: 'item 1
expanded'.
	self assert: list  startIndex equals: 19
]

{ #category : #tests }
GHMOrderedListBlockTest >> testSingleLevelListWithNormalNumbering [
	| root list |
	root := self parser
		parse:
'1. first item
2. second item'.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list class equals: self orderedListBlockClass.
	self assert: list startIndex equals: 1. 
	self assert: list children second text equals: 'second item'.
	
	
	"self halt."
	self flag: #fixMe. 
	"I see that a listBlock has indent = 3 and I have no clue why
	and a startIndex which is ok."
]

{ #category : #tests }
GHMOrderedListBlockTest >> testSingleLevelListWithStrangelyNumberedItems [
	| root list |
	root := self parser
		parse:
			'11. item 1
2. item 2'.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list class equals: self orderedListBlockClass.
	self assert: list children second text equals: 'item 2'
]

{ #category : #tests }
GHMOrderedListBlockTest >> testTwoLevelList1 [
	| source root list |
	source := 
'1. item 1
   6) sublevel
1. item 2'.
	root := GHMParser new parse: source.
	list := root children first.
	self assert: list children size equals: 2.
	self assert: list children second text equals: 'item 2'.
	self assert: list children first "item 1"
			children first "ordered list"
			children first "sub item"
			text equals: 'sublevel'
]