"
I'm a math environment

&
\frac{3}
&

may be in the future we should have \[ \]
"
Class {
	#name : #MicMathBlock,
	#superclass : #GHMSameStartStopMarkupBlock,
	#category : #'GithubMicrodown-Core'
}

{ #category : #markups }
MicMathBlock >> lineStartMarkup [

	^ parser mathOpeningBlockMarkup 
]
