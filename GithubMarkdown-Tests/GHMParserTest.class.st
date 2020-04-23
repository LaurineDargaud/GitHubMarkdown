Class {
	#name : #GHMParserTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMParserTest >> testAllBlockClasses [
	self assert: GHMParser allBlockNodeClasses asArray size equals:  #(GHMBlockTextBlock GHMCodeBlock GHMHeaderBlock GHMListBlock GHMListItemBlock GHMParagraphBlock GHMRootBlock GHMOrderedListBlock GHMUnorderedListBlock) size.
	self assertCollection: GHMParser allBlockNodeClasses asArray hasSameElements:  { GHMBlockTextBlock . GHMCodeBlock . GHMHeaderBlock . GHMListBlock . GHMListItemBlock . GHMParagraphBlock .  GHMRootBlock . GHMOrderedListBlock . GHMUnorderedListBlock} 
	
	
	
	
	
]

{ #category : #tests }
GHMParserTest >> testEmpty [
	| source root |
	source := ''.
	root := GHMParser new parse: source.
	self assert: root children size equals: 0.
	source := '


'.
	root := GHMParser new parse: source.
	self assert: root children size equals: 0
]
