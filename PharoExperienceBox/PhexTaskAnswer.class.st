"
I am a timestamped text answer to a Phex experimental task.
"
Class {
	#name : #PhexTaskAnswer,
	#superclass : #Object,
	#instVars : [
		'dateTime',
		'contents'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexTaskAnswer >> contents [

	^ contents
]

{ #category : #accessing }
PhexTaskAnswer >> contents: anObject [

	contents := anObject
]

{ #category : #accessing }
PhexTaskAnswer >> dateTime [

	^ dateTime
]

{ #category : #accessing }
PhexTaskAnswer >> dateTime: anObject [

	dateTime := anObject
]
