Class {
	#name : 'PhexSurveyQuestion',
	#superclass : 'PhexAbstractQuestion',
	#instVars : [
		'choices'
	],
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'accessing' }
PhexSurveyQuestion >> choices [

	^ choices
]

{ #category : 'accessing' }
PhexSurveyQuestion >> choices: anObject [

	choices := anObject
]

{ #category : 'initialization' }
PhexSurveyQuestion >> initialize [
	super initialize.
	choices := OrderedCollection new
]
