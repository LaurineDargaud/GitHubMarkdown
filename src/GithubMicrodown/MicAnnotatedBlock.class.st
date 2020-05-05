Class {
	#name : #MicAnnotatedBlock,
	#superclass : #GHMBlockTextBlock,
	#category : #GithubMicrodown
}

{ #category : #testing }
MicAnnotatedBlock >> canConsumeLine: line [
	"return if this block can consume line"

	"it can be dangerous"
	^ line isNotEmpty 
]
