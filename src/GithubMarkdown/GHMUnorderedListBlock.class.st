"
I represent an unordered list of list items
"
Class {
	#name : #GHMUnorderedListBlock,
	#superclass : #GHMListBlock,
	#category : #'GithubMarkdown-Model'
}

{ #category : #converting }
GHMUnorderedListBlock >> asPillar [
	^ PRUnorderedList new
		setChildren: (self children collect:[:child| child asPillar]);
		yourself
]

{ #category : #testing }
GHMUnorderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"
	^ (super canConsumeLine: line) and: [line trim matchesRegex: '(^\* |^- | ^\+).*']
]
