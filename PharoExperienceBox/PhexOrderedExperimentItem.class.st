"
I am an experiment unit with an order, an uuid and a title.
My subclasses should implement logic of something that is performed during an experiment, such as a survey or a task.
"
Class {
	#name : 'PhexOrderedExperimentItem',
	#superclass : 'Object',
	#instVars : [
		'order',
		'uuid',
		'title'
	],
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'accessing' }
PhexOrderedExperimentItem >> order [

	^ order ifNil:[order := 0]
]

{ #category : 'accessing' }
PhexOrderedExperimentItem >> order: anObject [

	order := anObject
]

{ #category : 'accessing' }
PhexOrderedExperimentItem >> title [

	^ title
]

{ #category : 'accessing' }
PhexOrderedExperimentItem >> title: anObject [

	title := anObject
]

{ #category : 'accessing' }
PhexOrderedExperimentItem >> uuid [

	^ uuid ifNil:[uuid := UUID new]
]

{ #category : 'accessing' }
PhexOrderedExperimentItem >> uuid: anObject [

	uuid := anObject
]
