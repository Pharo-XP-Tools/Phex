Class {
	#name : #PhexYesNoQuestion,
	#superclass : #PhexSurveyQuestion,
	#category : #'PharoExperienceBox-model'
}

{ #category : #'API - spec' }
PhexYesNoQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildYesNoSurveyQuestion: self
]

{ #category : #evaluating }
PhexYesNoQuestion >> evaluateResultFrom: aPhexSurveyQuestionPresenter [ 
	aPhexSurveyQuestionPresenter evaluateYesNoAnswerFor: self
]
