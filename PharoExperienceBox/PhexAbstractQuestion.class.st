Class {
	#name : #PhexAbstractQuestion,
	#superclass : #Object,
	#instVars : [
		'title',
		'answer',
		'optionnal',
		'id'
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
PhexAbstractQuestion >> id [

	^ id ifNil:[UUID new asString]
]

{ #category : #accessing }
PhexAbstractQuestion >> id: anObject [

	id := anObject
]

{ #category : #accessing }
PhexAbstractQuestion >> optionnal [

	^ optionnal
]

{ #category : #accessing }
PhexAbstractQuestion >> optionnal: anObject [

	optionnal := anObject
]

{ #category : #printing }
PhexAbstractQuestion >> printAnswer: aPhexAnswer on: aStream [
	aStream << aPhexAnswer answer
]

{ #category : #accessing }
PhexAbstractQuestion >> title [

	^ title
]

{ #category : #accessing }
PhexAbstractQuestion >> title: anObject [

	title := anObject
]
