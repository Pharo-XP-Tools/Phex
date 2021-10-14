Class {
	#name : #PhexFreeTextQuestion,
	#superclass : #PhexAbstractQuestion,
	#category : #'PharoExperienceBox-model'
}

{ #category : #'API - spec' }
PhexFreeTextQuestion >> buildOn: aSpecPresenter [
	aSpecPresenter buildFreeTextSurveyQuestion: self
]
