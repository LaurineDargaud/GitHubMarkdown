Class {
	#name : #MicroDownArgumentParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'GithubMicrodown-ArgumentList'
}

{ #category : #running }
MicroDownArgumentParserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	parser := MicroDownArgumentParser new
]

{ #category : #tests }
MicroDownArgumentParserTest >> testKeyVals [

	| source |
	source := 'key=value&key1=value2'.
	parser parseArguments: source. 	
	self assert: parser parameters keys asArray equals: #('key' 'key1').

]

{ #category : #tests }
MicroDownArgumentParserTest >> testTagKeyVal [

	| source args |
	source := 'tag:key=value'.
	args := parser parse: source. 
	self assert: args tag equals: 'tag'.
	self assert: args keys asArray equals: #('key').
	self assert: args values asArray equals: #('value').
]
