Class {
	#name : #GHMParserTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMParserTest >> testAllBlockClasses [
	self 
		assert: self parserClass allBlockNodeClasses asArray size 
		equals:  #(GHMBlockTextBlock GHMCodeBlock GHMHeaderBlock GHMListBlock GHMListItemBlock GHMParagraphBlock GHMRootBlock GHMOrderedListBlock GHMUnorderedListBlock) size.
	self 
		assertCollection: GHMParser allBlockNodeClasses asArray 
		hasSameElements:  { GHMBlockTextBlock . GHMCodeBlock . GHMHeaderBlock . GHMListBlock . GHMListItemBlock . GHMParagraphBlock .  GHMRootBlock . GHMOrderedListBlock . GHMUnorderedListBlock} 
	
	
	
	
	
]

{ #category : #tests }
GHMParserTest >> testEmpty [
	| source root |
	source := ''.
	root := self parser parse: source.
	self assert: root children size equals: 0.

]

{ #category : #tests }
GHMParserTest >> testEmptyOnMultipleLines [
	| source root |
	source := '


'.
	root := self parser parse: source.
	self assert: root children size equals: 0

]

{ #category : #tests }
GHMParserTest >> testOnceParsedCurrentShouldBeTheRootblock [

	| source root parser |
	source := 'This is
a paragraph on two lines'.
	parser := self parser.
	root := parser parse: source.
	self assert: parser current == root
]
