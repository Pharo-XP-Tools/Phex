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
		'requiresAnswer',
		'requiredAnswer',
		'endTime',
		'startTime',
		'uuid',
		'passed'
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

{ #category : #accessing }
PhexTask >> endTime [

	^ endTime
]

{ #category : #accessing }
PhexTask >> endTime: anObject [

	endTime := anObject
]

{ #category : #'start-stop' }
PhexTask >> finish [
	endTime := DateAndTime now.
	started := false.
	finished := true
]

{ #category : #accessing }
PhexTask >> finished: anObject [

	finished := anObject
]

{ #category : #accessing }
PhexTask >> icon [
	self passed ifTrue:[^self iconNamed: #glamorousClose].
	self isFinished ifTrue:[^self iconNamed: #smallOk].
	self isStarted ifTrue:[^self iconNamed: #warning].
	^self iconNamed: #scriptManager
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
PhexTask >> pass [
	self finish.
	passed := true
]

{ #category : #accessing }
PhexTask >> passed [

	^ passed ifNil: [ passed := false ]
]

{ #category : #accessing }
PhexTask >> passed: anObject [

	passed := anObject
]

{ #category : #accessing }
PhexTask >> requiredAnswer [
	^requiredAnswer ifNil:[requiredAnswer := 
'This task does not require you to provide an anwser.
You can finish the task immediately']
]

{ #category : #accessing }
PhexTask >> requiredAnswer: anObject [

	requiredAnswer := anObject
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
	startTime := DateAndTime now.
	started := true
]

{ #category : #accessing }
PhexTask >> startTime [

	^ startTime
]

{ #category : #accessing }
PhexTask >> startTime: anObject [

	startTime := anObject
]

{ #category : #accessing }
PhexTask >> started: anObject [

	started := anObject
]

{ #category : #accessing }
PhexTask >> uuid [

	^ uuid ifNil:[uuid := UUID new]
]

{ #category : #accessing }
PhexTask >> uuid: anObject [

	uuid := anObject
]
