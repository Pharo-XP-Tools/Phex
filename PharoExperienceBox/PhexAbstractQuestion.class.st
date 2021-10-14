Class {
	#name : #PhexAbstractQuestion,
	#superclass : #Object,
	#instVars : [
		'title',
		'answer',
		'optionnal'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexAbstractQuestion >> answer [

	^ answer
]

{ #category : #accessing }
PhexAbstractQuestion >> answer: anObject [

	answer := anObject
]

{ #category : #'API - spec' }
PhexAbstractQuestion >> buildOn: aSpecPresenter [
	self subclassResponsibility 
]

{ #category : #'API - DSSpy' }
PhexAbstractQuestion >> generateRecord [
	self subclassResponsibility 
]

{ #category : #accessing }
PhexAbstractQuestion >> optionnal [

	^ optionnal
]

{ #category : #accessing }
PhexAbstractQuestion >> optionnal: anObject [

	optionnal := anObject
]

{ #category : #accessing }
PhexAbstractQuestion >> title [

	^ title
]

{ #category : #accessing }
PhexAbstractQuestion >> title: anObject [

	title := anObject
]
