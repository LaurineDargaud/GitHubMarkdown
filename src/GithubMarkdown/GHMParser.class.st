"
I am a parser for github markdown.

I am based on the specification in https://github.github.com/gfm, in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are ""open"". The deepest open in the tree is called ""current"". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
	- as part of this a child of current can be made which can consume the new line
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The root node is not closed until input is exhausted.
"
Class {
	#name : #GHMParser,
	#superclass : #Object,
	#instVars : [
		'current',
		'root'
	],
	#category : #'GithubMarkdown-Parser'
}

{ #category : #private }
GHMParser class >> allBlockNodeClasses [
	^ GHMAbstractBlock allSubclasses
	
]

{ #category : #markups }
GHMParser class >> codeblockMarkup [

	^ '```'
]

{ #category : #examples }
GHMParser class >> example [
	<example>
	(self fromUrl: 'https://raw.githubusercontent.com/kasperosterbye/PillarRichTextRender/master/README.md') inspectWithLabel: 'PillarRichTextRender/README.md'
]

{ #category : #'instance creation' }
GHMParser class >> fromUrl: aUrl [
	
	^self asText:   
		(ZnClient new 
			beOneShot;
			get: aUrl;
			entity) string.
]

{ #category : #markups }
GHMParser class >> headerMarkup [

	^ '#'
]

{ #category : #markups }
GHMParser class >> preformattedMarkup [

	^ '> '
]

{ #category : #markups }
GHMParser class >> unorderedListMarkups [

	^ #('- ' '* ' '+ ')
]

{ #category : #'node creation' }
GHMParser >> blockExtensionStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"
		
	^ nil
]

{ #category : #'node creation' }
GHMParser >> blockStarterClassFrom: line [
	"return the class of a block which can start with line, or nil if none"

	(line beginsWith: '#')
		ifTrue: [ ^ GHMHeaderBlock ].
	(line beginsWith: '```')
		ifTrue: [ ^ GHMCodeBlock ].
	(line beginsWith: '- ') | (line beginsWith: '* ')
		| (line beginsWith: '+ ')
		ifTrue: [ ^ GHMUnorderedListBlock ].
	(line prefixMatchesRegex: '\d+(\.|\))')
		ifTrue: [ ^ GHMOrderedListBlock ].	"number followed by . or )"
	(line beginsWith: '>') "or '> '??"
		ifTrue: [ ^ GHMBlockTextBlock ].
	
	"trying to provide an extension mechanism."
	(self blockExtensionStarterClassFrom: line)
		ifNotNil: [ :c | ^ c ]
		ifNil: [ line ifNotEmpty: [ ^ GHMParagraphBlock ].
					^ nil ]
]

{ #category : #markups }
GHMParser >> codeblockMarkup [ 
	^ self class codeblockMarkup 
]

{ #category : #accessing }
GHMParser >> current [ 

	^ current
]

{ #category : #parsing }
GHMParser >> handleErrorInLine: line [
	"This implementation is temporary.
	The right way to handle this is to insert an error node into the tree"
	
	self error: 'I was not able to handle this input'.
]

{ #category : #parsing }
GHMParser >> handleLine: line [
	| normalized |
	normalized := line copyReplaceAll: String tab with: String space.
	[(current canConsumeLine: normalized)
		ifTrue: [ ^ current := current addLine: normalized ]
		ifFalse: [ current closeMe ].
	current := current parent.
	self handleLine: normalized] on: Error do: [ self handleErrorInLine: line ]
]

{ #category : #markups }
GHMParser >> headerMarkup [ 
	^ self class headerMarkup 
]

{ #category : #parsing }
GHMParser >> parse: aStreamOrString [
	"returns the root node of aStreamOrText"

	| inStream line |
	current := root := GHMRootBlock new setParser: self; yourself.
	inStream := aStreamOrString readStream.
	[ line := inStream nextLine.
	line isNil ] whileFalse: [ self handleLine: line ].
	[ current = root ] whileFalse: [ current closeMe. current := current parent ].
	^ root
]

{ #category : #markups }
GHMParser >> preformattedMarkup [ 
	^ self class preformattedMarkup 
]
