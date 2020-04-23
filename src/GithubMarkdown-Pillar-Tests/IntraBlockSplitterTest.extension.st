Extension { #name : #IntraBlockSplitterTest }

{ #category : #'*GithubMarkdown-Pillar-Tests' }
IntraBlockSplitterTest >> testAsPillarPlain [
	| res |
	res := GHMIntraBlockSplitter new pillarFrom: 'abc'.
	self assert: res first text equals: 'abc'.
	self assert: res first class equals: PRText.
	res := GHMIntraBlockSplitter new pillarFrom: 'abc*xyz*cba'.
	self assert: res second children first text equals: 'xyz'.
	self assert: res second class equals: PRItalicFormat.
	res := GHMIntraBlockSplitter new pillarFrom: 'abc[alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second class equals: PRExternalLink.
	res := GHMIntraBlockSplitter new pillarFrom: 'abc![alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second reference equals: 'link'.
	self assert: res second class equals: PRFigure 
]
