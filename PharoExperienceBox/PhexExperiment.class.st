"
I represent an experiment with a name, a description and a list of tasks (instances of PhexTask)
"
Class {
	#name : #PhexExperiment,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'tasks'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexExperiment >> description [

	^ description
]

{ #category : #accessing }
PhexExperiment >> description: anObject [

	description := anObject
]

{ #category : #accessing }
PhexExperiment >> name [

	^ name ifNil:['Unnamed experience']
]

{ #category : #accessing }
PhexExperiment >> name: anObject [

	name := anObject
]

{ #category : #printing }
PhexExperiment >> printOn: aStream [
	aStream << self name 
]

{ #category : #accessing }
PhexExperiment >> tasks [

	^ tasks
]

{ #category : #accessing }
PhexExperiment >> tasks: anObject [

	tasks := anObject
]
