Class {
	#name : #MicArgumentList,
	#superclass : #Object,
	#instVars : [
		'tag',
		'parameters'
	],
	#category : #'GithubMicrodown-ArgumentList'
}

{ #category : #accessing }
MicArgumentList >> keys [
	^ parameters keys
]

{ #category : #accessing }
MicArgumentList >> parameters: aCollection [ 
	parameters := aCollection
]

{ #category : #accessing }
MicArgumentList >> tag [
	^ tag
]

{ #category : #accessing }
MicArgumentList >> tag: aString [ 
	tag := aString
]

{ #category : #accessing }
MicArgumentList >> values [
	^ parameters values
]
