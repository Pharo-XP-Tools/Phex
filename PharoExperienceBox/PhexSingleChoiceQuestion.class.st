Class {
	#name : #PhexSingleChoiceQuestion,
	#superclass : #PhexSurveyQuestion,
	#category : #'PharoExperienceBox-model'
}

{ #category : #'API - spec' }
PhexSingleChoiceQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildSingleChoiceSurveyQuestion:  self
]

{ #category : #evaluating }
PhexSingleChoiceQuestion >> evaluateResultFrom: aPhexSurveyQuestionPresenter [ 
	aPhexSurveyQuestionPresenter evaluateSingleChoiceAnswerFrom: self
]

{ #category : #printing }
PhexSingleChoiceQuestion >> printOn: aStream [
	aStream << title
]
