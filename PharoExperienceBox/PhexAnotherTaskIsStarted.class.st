"
I should be raised when one attempts to start a task while another one is running and that we cannot perform more than one task at once (`PhexExperiment>>sequentialTasks`).
"
Class {
	#name : #PhexAnotherTaskIsStarted,
	#superclass : #PhexTaskError,
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexAnotherTaskIsStarted >> errorMessage [

	^ 'You are already working on another task'
]
