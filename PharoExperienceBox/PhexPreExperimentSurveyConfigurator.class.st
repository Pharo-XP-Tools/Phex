"
I configure PhexExperiments with surveys that must be ran before the start of the experiment.
"
Class {
	#name : 'PhexPreExperimentSurveyConfigurator',
	#superclass : 'PhexSurveyConfigurator',
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'initialization' }
PhexPreExperimentSurveyConfigurator >> configureForExperiment: aPhexExperiment [
	super configureForExperiment: aPhexExperiment.
	aPhexExperiment addPreSurvey: survey
]
