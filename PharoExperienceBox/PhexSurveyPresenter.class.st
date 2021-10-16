Class {
	#name : #PhexSurveyPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'survey',
		'actionBar',
		'questionsPresenters'
	],
	#category : #'PharoExperienceBox-presenters'
}

{ #category : #specs }
PhexSurveyPresenter class >> defaultSpec [ 
	^SpBoxLayout newTopToBottom 
]

{ #category : #initialization }
PhexSurveyPresenter >> initializePresenters [
	|newLayout|
	super initializePresenters.
	questionsPresenters := survey questions collect: [ :q | 
		                       PhexSurveyQuestionPresenter on: q ].
	newLayout := SpBoxLayout newTopToBottom.
	questionsPresenters do:[:qp| newLayout add: qp].
	newLayout beNotHomogeneous.
	self layout: newLayout
]

{ #category : #initialization }
PhexSurveyPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: survey title
]

{ #category : #initialization }
PhexSurveyPresenter >> setModelBeforeInitialization: aPhexSurvey [
	survey := aPhexSurvey 
]
