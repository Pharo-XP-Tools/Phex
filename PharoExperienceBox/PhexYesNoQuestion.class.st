Class {
	#name : 'PhexYesNoQuestion',
	#superclass : 'PhexSurveyQuestion',
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'API - spec' }
PhexYesNoQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildYesNoSurveyQuestion: self
]

{ #category : 'evaluating' }
PhexYesNoQuestion >> evaluateResultFrom: aPhexSurveyQuestionPresenter [ 
	aPhexSurveyQuestionPresenter evaluateYesNoAnswerFor: self
]

{ #category : 'testing' }
PhexYesNoQuestion >> hasValidAnswer: aCollection [ 
	^#('Yes' 'No') includes: answer answer
]
