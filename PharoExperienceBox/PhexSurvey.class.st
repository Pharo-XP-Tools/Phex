Class {
	#name : #PhexSurvey,
	#superclass : #Object,
	#instVars : [
		'title',
		'id',
		'questions',
		'validationBlock'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #spec }
PhexSurvey >> buildOn: aSpecPresenter [
	aSpecPresenter buildPhexSurvey
]

{ #category : #accessing }
PhexSurvey >> id [

	^ id
]

{ #category : #accessing }
PhexSurvey >> id: anObject [

	id := anObject
]

{ #category : #accessing }
PhexSurvey >> questions [

	^ questions
]

{ #category : #accessing }
PhexSurvey >> questions: anObject [

	questions := anObject
]

{ #category : #accessing }
PhexSurvey >> title [

	^ title
]

{ #category : #accessing }
PhexSurvey >> title: anObject [

	title := anObject
]

{ #category : #validating }
PhexSurvey >> validate [
	self validationBlock cull: self
]

{ #category : #accessing }
PhexSurvey >> validationBlock [

	^ validationBlock ifNil: [ validationBlock := [ :survey| ] ]
]

{ #category : #accessing }
PhexSurvey >> validationBlock: anObject [

	validationBlock := anObject
]
