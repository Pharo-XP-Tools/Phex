"
I represent an experiment with a name, a description and a list of tasks (instances of PhexTask)
"
Class {
	#name : #PhexExperiment,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'tasks',
		'startingTaskAction',
		'finishTaskAction',
		'runningTasks'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexExperiment class >> currentExperiment [

	^ self subclassResponsibility
]

{ #category : #initialization }
PhexExperiment class >> resetAllExperiments [
	<script>
	self allSubclassesDo: [ :c| c resetExperiment ]
]

{ #category : #initialization }
PhexExperiment class >> resetExperiment [
	 self subclassResponsibility 
]

{ #category : #private }
PhexExperiment >> addRunningTask: aTask [
	self runningTasks addIfNotPresent: aTask
]

{ #category : #testing }
PhexExperiment >> canFinishTask: aTask [

	^ aTask isStarted
]

{ #category : #testing }
PhexExperiment >> canStartNewTask [

	^ (self sequentialTasks and: [ self hasRunningTasks ]) not
]

{ #category : #accessing }
PhexExperiment >> description [

	^ description
]

{ #category : #accessing }
PhexExperiment >> description: anObject [

	description := anObject
]

{ #category : #accessing }
PhexExperiment >> experienceId [
	^self subclassResponsibility 
]

{ #category : #actions }
PhexExperiment >> finishTask: aTask [

	aTask isFinished ifTrue: [ PhexTaskIsAlreadyFinished new signal ].
	aTask isStarted ifFalse: [ PhexTaskIsNotStarted new signal ].

	aTask finish.
	self removeRunningTask: aTask.
	self finishTaskAction cull: self cull: aTask
]

{ #category : #accessing }
PhexExperiment >> finishTaskAction [

	^ finishTaskAction ifNil: [ finishTaskAction := [ :xp :task |  ] ]
]

{ #category : #accessing }
PhexExperiment >> finishTaskAction: anObject [

	finishTaskAction := anObject
]

{ #category : #testing }
PhexExperiment >> hasRunningTasks [
	^self runningTasks notEmpty
]

{ #category : #'serialize/materialize' }
PhexExperiment >> materializeTasks [

	| dir |
	dir := self experienceId asFileReference.
	dir ensureCreateDirectory.
	tasks := dir allChildren collect: [ :fr | 
		         STON fromString: fr contents ]
]

{ #category : #accessing }
PhexExperiment >> name [

	^ name ifNil:['Unnamed experience']
]

{ #category : #accessing }
PhexExperiment >> name: anObject [

	name := anObject
]

{ #category : #printing }
PhexExperiment >> printOn: aStream [
	aStream << self name 
]

{ #category : #private }
PhexExperiment >> removeRunningTask: aTask [

	self runningTasks remove: aTask ifAbsent: [  ]
]

{ #category : #accessing }
PhexExperiment >> runningTasks [

	^ runningTasks ifNil: [ runningTasks := OrderedCollection new ]
]

{ #category : #testing }
PhexExperiment >> sequentialTasks [
	^false
]

{ #category : #'serialize/materialize' }
PhexExperiment >> serializeTasks [

	| dir |
	dir := self experienceId asFileReference.
	dir ensureCreateDirectory.
	tasks do: [ :t | 
		(dir / t uuid asString) asFileReference writeStreamDo: [ :str | 
			str nextPutAll: (STON toString: t) ] ]
]

{ #category : #actions }
PhexExperiment >> startTask: aTask [

	aTask isFinished ifTrue: [ PhexTaskIsAlreadyFinished new signal ].	
	(self runningTasks includes: aTask) ifTrue: [ 	PhexTaskIsAlreadyStarted new signal ].
	self canStartNewTask ifFalse: [ PhexAnotherTaskIsStarted new signal ].
	
	aTask start.
	self addRunningTask: aTask.
	self startingTaskAction cull: self cull: aTask
]

{ #category : #accessing }
PhexExperiment >> startingTaskAction [

	^ startingTaskAction ifNil: [ startingTaskAction := [ :xp :task |  ] ]
]

{ #category : #accessing }
PhexExperiment >> startingTaskAction: anObject [

	startingTaskAction := anObject
]

{ #category : #accessing }
PhexExperiment >> tasks [

	^ tasks
]

{ #category : #accessing }
PhexExperiment >> tasks: anObject [

	tasks := anObject
]
