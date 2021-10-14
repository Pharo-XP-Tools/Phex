Class {
	#name : #PhexMultipleChoicesQuestion,
	#superclass : #PhexSurveyQuestion,
	#category : #'PharoExperienceBox-model'
}

{ #category : #'API - spec' }
PhexMultipleChoicesQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildMultipleChoiceSurveyQuestion: self
]
