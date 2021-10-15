Class {
	#name : #PhexMultipleChoicesQuestion,
	#superclass : #PhexSurveyQuestion,
	#category : #'PharoExperienceBox-model'
}

{ #category : #'API - spec' }
PhexMultipleChoicesQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildMultipleChoiceSurveyQuestion: self
]

{ #category : #evaluating }
PhexMultipleChoicesQuestion >> evaluateResultFrom: aPhexSurveyQuestionPresenter [ 
	aPhexSurveyQuestionPresenter evaluateMultipleChoiceAnswerFrom: self
]

{ #category : #printing }
PhexMultipleChoicesQuestion >> printAnswer: aPhexAnswer on: aStream [

	aPhexAnswer answer do: [ :a | 
		aStream << a.
		aStream << '.'.
		aStream space ]
]
