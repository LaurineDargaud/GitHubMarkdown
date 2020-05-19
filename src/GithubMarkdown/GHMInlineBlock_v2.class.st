Class {
	#name : #'GHMInlineBlock_v2',
	#superclass : #Object,
	#instVars : [
		'substring',
		'start',
		'end',
		'kind'
	],
	#category : #'GithubMarkdown-Model - inline'
}

{ #category : #'instance creation' }
GHMInlineBlock_v2 class >> from: aStartInteger to: anEndInteger withKind: aKind withString: aString [
	| correctSubstring |
	correctSubstring := aString collect: [ :c | c ] from: aStartInteger to: anEndInteger.
	^ self new start: aStartInteger; end: anEndInteger; kind: aKind; substring: correctSubstring; yourself.
	
]

{ #category : #accessing }
GHMInlineBlock_v2 >> end [
	^ end
]

{ #category : #accessing }
GHMInlineBlock_v2 >> end: anInteger [
	end := anInteger
]

{ #category : #accessing }
GHMInlineBlock_v2 >> kind [
	^ kind
]

{ #category : #accessing }
GHMInlineBlock_v2 >> kind: aKind [
	kind := aKind
]

{ #category : #printing }
GHMInlineBlock_v2 >> printOn: aStream [
	aStream 
		nextPut: $[;
		nextPutAll: self substring;
		nextPut: $];
		nextPut: $(;
		nextPutAll: self kind;
		nextPut: $)
]

{ #category : #accessing }
GHMInlineBlock_v2 >> start [ 	
	^ start
]

{ #category : #accessing }
GHMInlineBlock_v2 >> start: anInteger [
	start := anInteger 
]

{ #category : #accessing }
GHMInlineBlock_v2 >> substring [
	^ substring
]

{ #category : #accessing }
GHMInlineBlock_v2 >> substring: aSubString [
	substring := aSubString
]
