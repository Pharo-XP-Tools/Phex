Class {
	#name : #PhexAgreementQuestion,
	#superclass : #PhexSurveyQuestion,
	#category : #'PharoExperienceBox-model'
}

{ #category : #'API - spec' }
PhexAgreementQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildAgreementQuestion: self
]
