Class {
	#name : #PhexAgreementQuestion,
	#superclass : #PhexSurveyQuestion,
	#category : #'PharoExperienceBox-model'
}

{ #category : #'API - spec' }
PhexAgreementQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildAgreementQuestion: self
]

{ #category : #testing }
PhexAgreementQuestion >> hasValidAnswer: aBoolean [ 
	^aBoolean notNil
]

{ #category : #'as yet unclassified' }
PhexAgreementQuestion >> validWithAnswers: aBoolean [ 
	^aBoolean notNil
]
