"
I configure PhexExperiments with surveys that must be ran at the end of the experiment.
"
Class {
	#name : 'PhexPostExperimentSurveyConfigurator',
	#superclass : 'PhexSurveyConfigurator',
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'initialization' }
PhexPostExperimentSurveyConfigurator >> configureForExperiment: aPhexExperiment [
	super configureForExperiment: aPhexExperiment.
	aPhexExperiment addPostSurvey: survey
]
