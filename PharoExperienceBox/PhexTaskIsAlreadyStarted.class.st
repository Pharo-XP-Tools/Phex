"
I should be raised when one attempts to start a task that is already started.
"
Class {
	#name : #PhexTaskIsAlreadyStarted,
	#superclass : #PhexTaskError,
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexTaskIsAlreadyStarted >> errorMessage [

	^ 'You are already working on this task'
]
