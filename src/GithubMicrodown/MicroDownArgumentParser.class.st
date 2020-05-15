Class {
	#name : #MicroDownArgumentParser,
	#superclass : #Object,
	#instVars : [
		'commaIndex',
		'parameters'
	],
	#category : #'GithubMicrodown-ArgumentList'
}

{ #category : #parsing }
MicroDownArgumentParser >> initialize [

	super initialize.
	parameters := Dictionary new.
]

{ #category : #accessing }
MicroDownArgumentParser >> parameters [
	^ parameters
]

{ #category : #parsing }
MicroDownArgumentParser >> parse: aString [ 
	
	| tag argList |
	commaIndex := (aString indexOf: $:).
	tag := aString copyFrom: 1 to: commaIndex - 1.
	self parseArguments: (aString copyFrom: commaIndex + 1 to: aString size). 
	argList := MicArgumentList new
		tag: tag;
		parameters: parameters. 
	^ argList
]

{ #category : #parsing }
MicroDownArgumentParser >> parseArguments: aString [ 

	(aString splitOn: '&')
		do: [ :each | 
					| kv | 
					kv := (each splitOn: '=').
					parameters at: kv first put: kv second ] 
								
	
		
]
