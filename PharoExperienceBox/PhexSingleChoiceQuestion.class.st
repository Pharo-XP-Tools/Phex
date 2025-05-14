Class {
	#name : 'PhexSingleChoiceQuestion',
	#superclass : 'PhexSurveyQuestion',
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'API - spec' }
PhexSingleChoiceQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildSingleChoiceSurveyQuestion:  self
]

{ #category : 'evaluating' }
PhexSingleChoiceQuestion >> evaluateResultFrom: aPhexSurveyQuestionPresenter [ 
	aPhexSurveyQuestionPresenter evaluateSingleChoiceAnswerFrom: self
]

{ #category : 'testing' }
PhexSingleChoiceQuestion >> hasValidAnswer: aCollection [ 
	^choices includes: answer answer
]

{ #category : 'printing' }
PhexSingleChoiceQuestion >> printOn: aStream [
	aStream << title
]
