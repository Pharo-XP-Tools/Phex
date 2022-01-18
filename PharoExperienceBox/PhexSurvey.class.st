Class {
	#name : #PhexSurvey,
	#superclass : #Object,
	#instVars : [
		'title',
		'id',
		'questions',
		'validationBlock',
		'answers'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #questions }
PhexSurvey >> addQuestion: aQuestion [
	questions add: aQuestion
]

{ #category : #accessing }
PhexSurvey >> answers [

	^ answers
]

{ #category : #accessing }
PhexSurvey >> answers: anObject [

	answers := anObject
]

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

{ #category : #questions }
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
