"
I should be raised when one attempts to start task while another task is already running.
"
Class {
	#name : #PhexAnotherTaskIsRunning,
	#superclass : #PhexTaskError,
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexAnotherTaskIsRunning >> errorMessage [

	^ 'Another task is already running: finish that task before starting another one'
]
