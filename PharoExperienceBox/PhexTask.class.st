"
I represent an experimental task with status started/finished
"
Class {
	#name : #PhexTask,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'contents',
		'started',
		'finished'
	],
	#classInstVars : [
		'tasks'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexTask >> contents [

	^ contents
]

{ #category : #accessing }
PhexTask >> contents: anObject [

	contents := anObject
]

{ #category : #accessing }
PhexTask >> description [

	^ description
]

{ #category : #accessing }
PhexTask >> description: anObject [

	description := anObject
]

{ #category : #'start-stop' }
PhexTask >> finish [
	started ifFalse:[^self].
	started := false.
	finished := true
]

{ #category : #accessing }
PhexTask >> finished: anObject [

	finished := anObject
]

{ #category : #accessing }
PhexTask >> icon [
	self isFinished ifTrue:[^self iconNamed: #testGreen].
	self isStarted ifTrue:[^self iconNamed: #testYellow].
	^self iconNamed: #testNotRun
]

{ #category : #initialization }
PhexTask >> initialize [

	started := false.
	finished := false
]

{ #category : #testing }
PhexTask >> isFinished [
	^finished
]

{ #category : #testing }
PhexTask >> isStarted [
	^started
]

{ #category : #accessing }
PhexTask >> name [

	^ name
]

{ #category : #accessing }
PhexTask >> name: anObject [

	name := anObject
]

{ #category : #'start-stop' }
PhexTask >> start [
	finished ifTrue:[^self].
	started := true
]

{ #category : #accessing }
PhexTask >> started: anObject [

	started := anObject
]
