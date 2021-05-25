"
Instances of my subclasses should be raised when an error happen manipulating `PhexTask` instances.
"
Class {
	#name : #PhexTaskError,
	#superclass : #Error,
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexTaskError >> errorMessage [
	^self subclassResponsibility 
]
