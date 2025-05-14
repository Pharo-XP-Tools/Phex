Class {
	#name : 'PhexAgreementSurveyConfigurator',
	#superclass : 'PhexSurveyConfigurator',
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'initialization' }
PhexAgreementSurveyConfigurator >> configureForExperiment: aPhexExperiment [
	super configureForExperiment: aPhexExperiment.
	aPhexExperiment addAgreementSurvey: survey
]

{ #category : 'as yet unclassified' }
PhexAgreementSurveyConfigurator >> runSurveyOn: aPresenter [
	aPresenter runAgreementSurvey: survey
]
