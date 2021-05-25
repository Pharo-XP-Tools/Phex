"
I should be raised when one attempts to finish a task that has not been started yet.
"
Class {
	#name : #PhexTaskIsNotStarted,
	#superclass : #PhexTaskError,
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexTaskIsNotStarted >> errorMessage [

	^ 'This task has not started yet'
]
