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
		'finished',
		'answer',
		'requiresAnswer'
	],
	#classInstVars : [
		'tasks'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexTask >> answer [

	^ answer
]

{ #category : #accessing }
PhexTask >> answer: anObject [

	answer := anObject
]

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

{ #category : #accessing }
PhexTask >> requiresAnswer [

	^ requiresAnswer ifNil:[requiresAnswer := false]
]

{ #category : #accessing }
PhexTask >> requiresAnswer: anObject [

	requiresAnswer := anObject
]

{ #category : #'start-stop' }
PhexTask >> start [
	started := true
]

{ #category : #accessing }
PhexTask >> started: anObject [

	started := anObject
]
