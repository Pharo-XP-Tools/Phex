Class {
	#name : 'PhexAbstractQuestion',
	#superclass : 'PhexOrderedExperimentItem',
	#instVars : [
		'answer',
		'optionnal'
	],
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'accessing' }
PhexAbstractQuestion >> answer [

	^ answer
]

{ #category : 'accessing' }
PhexAbstractQuestion >> answer: anObject [

	answer := anObject
]

{ #category : 'API - spec' }
PhexAbstractQuestion >> buildOn: aSpecPresenter [
	self subclassResponsibility 
]

{ #category : 'API - DSSpy' }
PhexAbstractQuestion >> generateRecord [
	self subclassResponsibility 
]

{ #category : 'accessing' }
PhexAbstractQuestion >> optionnal [

	^ optionnal
]

{ #category : 'accessing' }
PhexAbstractQuestion >> optionnal: anObject [

	optionnal := anObject
]

{ #category : 'printing' }
PhexAbstractQuestion >> printAnswer: aPhexAnswer on: aStream [
	aStream << aPhexAnswer answer
]
