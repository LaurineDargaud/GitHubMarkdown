"
A GHMListBlockTest is a test class for testing the behavior of GHMListBlock
"
Class {
	#name : #GHMListBlockTest,
	#superclass : #GHMBlockTest,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMListBlockTest >> listBlockClass [
	^ GHMListBlock
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLineDashForm [
	"indent from line return the position of the last character before the text."

	| root listBlock |
	root := self rootBlockClass new.
	listBlock := self listBlockClass new parent: root.
	self
		assert:
			(listBlock
				indentFromLine: '- joe';
				indent)
		equals: 2.
	
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLineNumberedForm [
	"indent from line return the position of the last character before the text."

	| root listBlock |
	root := self rootBlockClass new.
	listBlock := self listBlockClass new parent: root.
	self
		assert:
			(listBlock
				indentFromLine: '10. joe';
				indent)
		equals: 4
]

{ #category : #tests }
GHMListBlockTest >> testIndentFromLineStarForm [
	"indent from line return the position of the last character before the text."

	| root listBlock |
	root := self rootBlockClass new.
	listBlock := self listBlockClass new parent: root.
	self
		assert:
			(listBlock
				indentFromLine: '*  joe';
				indent)
		equals: 3.
	
]
