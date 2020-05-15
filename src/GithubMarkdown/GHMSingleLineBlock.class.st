Class {
	#name : #GHMSingleLineBlock,
	#superclass : #GHMAbstractBlock,
	#category : #'GithubMarkdown-Model'
}

{ #category : #testing }
GHMSingleLineBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^false "Headers are always one line"
]
