"
I should be raised when one attempts to start a task and:
- the experiment is configured to run tasks following their order
- the task the user tries to start is not the next one in the order
"
Class {
	#name : #PhexTaskStartedInWrongOrder,
	#superclass : #PhexTaskError,
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexTaskStartedInWrongOrder >> errorMessage [

	^ 'You must finish prior tasks before starting this task'
]
