Class {
	#name : 'PhexFreeTextQuestion',
	#superclass : 'PhexAbstractQuestion',
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'API - spec' }
PhexFreeTextQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildFreeTextSurveyQuestion: self
]

{ #category : 'evaluation' }
PhexFreeTextQuestion >> evaluateResultFrom: aPhexSurveyQuestionPresenter [ 
	aPhexSurveyQuestionPresenter evaluateFreeTextAnswerFrom: self
]

{ #category : 'testing' }
PhexFreeTextQuestion >> hasValidAnswer: aCollection [ 
	^answer answer notEmpty
]
