"
A GHMListBlockTest is a test class for testing the behavior of GHMListBlock
"
Class {
	#name : #GHMListBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMListBlockTest >> rootBlockClass [
	^ GHMRootBlock
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLine [
	"indent from line return the position of the last character before the text."
	| root listBlock |
	root := self rootBlockClass new.
	listBlock := GHMListBlock new parent: root.
	self
		assert:
			(listBlock
				indentFromLine: '- joe';
				indent)
		equals: 2.
	listBlock := GHMListBlock new parent: root.
	self
		assert:
			(listBlock
				indentFromLine: '*  joe';
				indent)
		equals: 3.
	listBlock := GHMListBlock new parent: root.
	self
		assert:
			(listBlock
				indentFromLine: '10. joe';
				indent)
		equals: 4
]
