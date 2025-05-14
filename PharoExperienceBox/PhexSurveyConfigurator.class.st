"
My subclasses are responsible to configure surveys for an experiment. 
"
Class {
	#name : 'PhexSurveyConfigurator',
	#superclass : 'Object',
	#instVars : [
		'survey'
	],
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'instance creation' }
PhexSurveyConfigurator class >> on: aPhexSurvey [

	^ self new forSurvey: aPhexSurvey
]

{ #category : 'initialization' }
PhexSurveyConfigurator >> configureForExperiment: aPhexExperiment [
	aPhexExperiment addSurvey: survey 
]

{ #category : 'accessing' }
PhexSurveyConfigurator >> forSurvey: aPhexSurvey [

	survey := aPhexSurvey.
	aPhexSurvey configurator: self
]

{ #category : 'as yet unclassified' }
PhexSurveyConfigurator >> runSurveyOn: aPresenter [
	aPresenter runSurvey: survey
]
