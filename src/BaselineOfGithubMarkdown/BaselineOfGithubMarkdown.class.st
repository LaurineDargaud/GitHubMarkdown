Class {
	#name : #BaselineOfGithubMarkdown,
	#superclass : #BaselineOf,
	#category : #BaselineOfGithubMarkdown
}

{ #category : #baselines }
BaselineOfGithubMarkdown >> baseline: spec [
	<baseline>
	self flag: #fixme.
	"we should check because the dependency analyser is given strange results."
	"We will remove the dependency to pillar from markdown when we will move
	the part related to microdown. Then microdown will depend on pillar and such 
	dependency will have to be made explicit"
	spec for: #'common' do: [
		spec 
			package: #'GithubMarkdown';
			package: #'GithubMarkdown-Tests' with: [
				spec requires:  #('GithubMarkdown') ];
			package: #'GithubMicrodown' with: [
				spec requires:  #('GithubMarkdown') ];
			package: #'GithubMarkdown-RichTextComposer' with: [
				spec requires:  #('GithubMarkdown') ];
			
			package: #'GithubMarkdown-Pillar';
			package: #'GithubMarkdown-Pillar-Tests' with: [
				spec requires:  #(#'GithubMarkdown-Pillar') ];
			package: #'GithubMarkdown-Pillar-Tests';
			package: #'GithubMarkdown-Tests' with: [
				spec requires:  #('GithubMarkdown-Pillar-Tests' 'GithubMarkdown-Tests') ]]

]
