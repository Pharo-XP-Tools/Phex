"
I should be raised when one attempts to start a finished task.
"
Class {
	#name : 'PhexTaskIsAlreadyFinished',
	#superclass : 'PhexTaskError',
	#category : 'PharoExperienceBox-model',
	#package : 'PharoExperienceBox',
	#tag : 'model'
}

{ #category : 'accessing' }
PhexTaskIsAlreadyFinished >> errorMessage [

	^ 'You are already finished this task'
]
