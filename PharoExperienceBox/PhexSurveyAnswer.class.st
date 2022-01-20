"
I'm an answer to a survey question.
I hold the answer (a literal value) and the question to which I am the answer.
"
Class {
	#name : #PhexSurveyAnswer,
	#superclass : #Object,
	#instVars : [
		'question',
		'answer'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexSurveyAnswer >> answer [

	^ answer
]

{ #category : #accessing }
PhexSurveyAnswer >> answer: anObject [

	answer := anObject
]

{ #category : #printing }
PhexSurveyAnswer >> printOn: aStream [
	self question printAnswer: self on: aStream
]

{ #category : #accessing }
PhexSurveyAnswer >> question [

	^ question
]

{ #category : #accessing }
PhexSurveyAnswer >> question: anObject [

	question := anObject
]
