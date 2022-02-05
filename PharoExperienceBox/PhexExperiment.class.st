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
		'runningTasks',
		'isFinished',
		'postSurveys',
		'preSurveys',
		'surveys',
		'finishExperimentAction'
	],
	#classInstVars : [
		'current'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #accessing }
PhexExperiment class >> currentExperiment [

	^current ifNil:[current := self new]
]

{ #category : #'as yet unclassified' }
PhexExperiment class >> ensureTasksDefinitionFolder [

	"ensures that the tasks folder of the experiment exists. Returns the FileReference"

	^ self currentExperiment ensureTasksDefinitionFolder
]

{ #category : #'building - API' }
PhexExperiment class >> freeTextQuestion: text [

	^ PhexFreeTextQuestion new
		  title: text;
		  yourself
]

{ #category : #testing }
PhexExperiment class >> isRunnableExperience [
	^true
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

{ #category : #'building - API' }
PhexExperiment class >> singleChoiceQuestion: text options: choices [

	^ PhexSingleChoiceQuestion new
		  title: text;
		  choices: choices;
		  yourself
]

{ #category : #'building - API' }
PhexExperiment class >> yesNoQuestion: text [

	^ PhexYesNoQuestion new
		  title: text;
		  yourself
]

{ #category : #surveys }
PhexExperiment >> addPostSurvey: aSurvey [

	self postSurveys add: aSurvey uuid
]

{ #category : #surveys }
PhexExperiment >> addPreSurvey: aSurvey [

	self preSurveys add: aSurvey uuid
]

{ #category : #private }
PhexExperiment >> addRunningTask: aTask [
	self runningTasks addIfNotPresent: aTask
]

{ #category : #surveys }
PhexExperiment >> addSurvey: aSurvey [
	self surveys at: aSurvey uuid put: aSurvey
]

{ #category : #testing }
PhexExperiment >> canFinishTask: aTask [

	^ aTask isStarted
]

{ #category : #testing }
PhexExperiment >> canStartNewTask [

	^ (self sequentialTasks and: [ self hasRunningTasks ]) not
]

{ #category : #api }
PhexExperiment >> closeable [
	^true
]

{ #category : #accessing }
PhexExperiment >> description [

	^ 'No description' "self subclassResponsibility"
]

{ #category : #'serialize/materialize' }
PhexExperiment >> ensureSurveysDefinitionFolder [

	| dir |
	dir := self experienceId asFileReference / 'surveys'.
	dir ensureCreateDirectory.
	^ dir
]

{ #category : #actions }
PhexExperiment >> ensureTaskCanBeFinished: aTask [

	aTask isFinished ifTrue: [ PhexTaskIsAlreadyFinished new signal ].
	aTask isStarted ifFalse: [ PhexTaskIsNotStarted new signal ]
]

{ #category : #'serialize/materialize' }
PhexExperiment >> ensureTasksAnswersFolder [

	| dir |
	dir := self experienceId asFileReference.
	dir ensureCreateDirectory.
	^ dir
]

{ #category : #'serialize/materialize' }
PhexExperiment >> ensureTasksDefinitionFolder [

	| dir |
	dir := self experienceId asFileReference / 'taskList'.
	dir ensureCreateDirectory.
	^ dir
]

{ #category : #accessing }
PhexExperiment >> experienceId [
	^self subclassResponsibility 
]

{ #category : #accessing }
PhexExperiment >> finishExperimentAction [

	^ finishExperimentAction ifNil: [ finishExperimentAction := [ :xp |  ] ]
]

{ #category : #actions }
PhexExperiment >> finishTask: aTask [
	
	aTask finish.
	self removeRunningTask: aTask.
	self finishTaskAction cull: self cull: aTask.	
	self serializeTasks.
	self updateStatus
]

{ #category : #accessing }
PhexExperiment >> finishTaskAction [

	^ finishTaskAction ifNil: [ finishTaskAction := [ :xp :task |  ] ]
]

{ #category : #surveys }
PhexExperiment >> hasPostSurvey [
	^self postSurveys notEmpty
]

{ #category : #surveys }
PhexExperiment >> hasPreSurvey [
	^self preSurveys notEmpty
]

{ #category : #testing }
PhexExperiment >> hasRunningTasks [
	^self runningTasks notEmpty
]

{ #category : #initialization }
PhexExperiment >> initialize [

	name := self name.
	description := self description.
	isFinished := false
]

{ #category : #testing }
PhexExperiment >> isFinished [

	^ isFinished ifNil:[isFinished := false]
]

{ #category : #initialization }
PhexExperiment >> logger [

	"Returns the logger object"

	^ self subclassResponsibility
]

{ #category : #'serialize/materialize' }
PhexExperiment >> materialize [

	self materializeSurveys.
	self materializeTasks.
	self setUpExperiment
]

{ #category : #'serialize/materialize' }
PhexExperiment >> materializeSurveys [

	| dir |
	dir := self ensureSurveysDefinitionFolder.
	surveys := nil.
	((dir allChildren select: [ :fr | 
		  fr extension = self surveyExtension ]) collect: [ :fr | 
		 STON fromString: fr readStream upToEnd ]) do: [ :s | 
		s configureForExperiment: self ]
]

{ #category : #'serialize/materialize' }
PhexExperiment >> materializeTasks [

	| dir |
	dir := self ensureTasksDefinitionFolder.
	tasks := nil.
	self tasks addAll:
		(((dir allChildren select: [ :fr | 
			   fr extension = self taskExtension ]) collect: [ :fr | 
			  STON fromString: fr readStream upToEnd ]) select:
			 self tasksMaterializationFilter).
	runningTasks := nil.
	(self tasks select: [ :t | t isStarted ]) do: [ :t | 
		self addRunningTask: t ].
	self updateStatus
]

{ #category : #accessing }
PhexExperiment >> name [

	^ 'Unnamed experience' "self subclassResponsibility"
]

{ #category : #private }
PhexExperiment >> newOrderedItemCollection [

	^ SortedCollection sortBlock: [ :a :b | a order < b order ]
]

{ #category : #accessing }
PhexExperiment >> postSurveys [

	^ postSurveys ifNil: [ postSurveys := self newOrderedItemCollection ]
]

{ #category : #accessing }
PhexExperiment >> preSurveys [

	^ preSurveys ifNil: [ preSurveys := self newOrderedItemCollection ]
]

{ #category : #initialization }
PhexExperiment >> prepareSystemForExperiment [

	^ self subclassResponsibility
]

{ #category : #printing }
PhexExperiment >> printOn: aStream [
	aStream << self name 
]

{ #category : #private }
PhexExperiment >> removeRunningTask: aTask [

	self runningTasks remove: aTask ifAbsent: [  ]
]

{ #category : #surveys }
PhexExperiment >> runPostSurveysWith: aPresenter [

	self hasPostSurvey ifFalse: [ ^ self ].
	(self postSurveys
		 collect: [ :uuid | self surveyFromUUID: uuid ]
		 thenSelect: [ :s | s isOpen ]) do: [ :s | aPresenter runSurvey: s ]
]

{ #category : #surveys }
PhexExperiment >> runPreSurveysWith: aPresenter [

	self hasPreSurvey ifFalse: [ ^ self ].
	(self preSurveys
		 collect: [ :uuid | self surveyFromUUID: uuid ]
		 thenSelect: [ :s | s isOpen ]) do: [ :s | aPresenter runSurvey: s ]
]

{ #category : #surveys }
PhexExperiment >> runSurveyFor: task with: aPresenter [

	task hasSurvey ifFalse: [ ^ self ].	
	aPresenter runSurvey: (surveys at: task survey)
]

{ #category : #accessing }
PhexExperiment >> runningTasks [

	^ runningTasks ifNil: [ runningTasks := OrderedCollection new ]
]

{ #category : #accessing }
PhexExperiment >> runningTasks: anObject [

	runningTasks := anObject
]

{ #category : #testing }
PhexExperiment >> sequentialTasks [
	^false
]

{ #category : #'serialize/materialize' }
PhexExperiment >> serializeSurveys [

	| dir |
	dir := self ensureSurveysDefinitionFolder.
	self surveys valuesDo: [ :s | 
		(dir / (self surveyFilenameFor: s)) asFileReference writeStreamDo: [ 
			:ws | ws nextPutAll: (STON toString: s) ] ]
]

{ #category : #'serialize/materialize' }
PhexExperiment >> serializeTasks [

	| dir |
	dir := self ensureTasksDefinitionFolder.
	self tasks do: [ :t | 
		(dir / (self taskFilenameFor: t)) asFileReference writeStreamDo: [ 
			:ws | ws nextPutAll: (STON toString: t) ] ]
]

{ #category : #initialization }
PhexExperiment >> setUpExperiment [

	"Experiments designers must implement dedicated experiment setup code in this method, that should be immediately called after materializing the experiment (default, see PhexExperiment>>#materialize
	Such setup code can be configuring pre/post tasks actions, survey validation actions, etc.
	The default behavior (here) is intented to be called every time."
	
	self updateStatus
]

{ #category : #actions }
PhexExperiment >> startTask: aTask [
	aTask isFinished ifTrue: [ PhexTaskIsAlreadyFinished new signal ].	
	(self runningTasks includes: aTask) ifTrue: [ 	PhexTaskIsAlreadyStarted new signal ].
	self canStartNewTask ifFalse: [ PhexAnotherTaskIsStarted new signal ].
	
	aTask start.
	self addRunningTask: aTask.
	self startingTaskAction cull: self cull: aTask.
	self serializeTasks
]

{ #category : #accessing }
PhexExperiment >> startingTaskAction [

	^ startingTaskAction ifNil: [ startingTaskAction := [ :xp :task |  ] ]
]

{ #category : #accessing }
PhexExperiment >> surveyExtension [

	^ 'psx'
]

{ #category : #'serialize/materialize' }
PhexExperiment >> surveyFilenameFor: s [

	^ (String new writeStreamDo: [ :ws | 
		   ws << s uuid asString.
		   ws << '.'.
		   ws << self surveyExtension ]) contents
]

{ #category : #surveys }
PhexExperiment >> surveyFromUUID: aSurveyUUID [
	^self surveys at: aSurveyUUID
]

{ #category : #accessing }
PhexExperiment >> surveys [

	^ surveys ifNil: [ surveys := Dictionary new ]
]

{ #category : #accessing }
PhexExperiment >> surveys: anObject [

	surveys := anObject
]

{ #category : #accessing }
PhexExperiment >> taskExtension [

	^ 'ptx'
]

{ #category : #'serialize/materialize' }
PhexExperiment >> taskFilenameFor: t [

	^ (String new writeStreamDo: [ :ws | 
		   ws << t uuid asString.
		   ws << '.'.
		   ws << self taskExtension ]) contents
]

{ #category : #accessing }
PhexExperiment >> tasks [

	^ tasks ifNil: [ tasks := self newOrderedItemCollection ]
]

{ #category : #accessing }
PhexExperiment >> tasks: anObject [

	tasks := self newOrderedItemCollection
		         addAll: anObject;
		         yourself
]

{ #category : #'serialize/materialize' }
PhexExperiment >> tasksMaterializationFilter [

	"returns a filter that is applied when materializing tasks"

	"Override this to make each user have a different set of tasks"

	^ [ :task | true "no filter" ]
]

{ #category : #actions }
PhexExperiment >> terminate [
	self finishExperimentAction cull: self
]

{ #category : #updating }
PhexExperiment >> updateStatus [

	(self tasks allSatisfy: [ :t | t isFinished ]) ifTrue: [ 
		isFinished := true ]
]

{ #category : #events }
PhexExperiment >> whenFinishedDo: aBlock [

	finishExperimentAction := aBlock
]

{ #category : #events }
PhexExperiment >> whenSurveyClosedDo: aBlock [

	surveys valuesDo: [ :s | s validationBlock: aBlock ]
]

{ #category : #events }
PhexExperiment >> whenTaskFinishedDo: aBlock [

	finishTaskAction := aBlock
]

{ #category : #events }
PhexExperiment >> whenTaskStartedDo: aBlock [

	startingTaskAction := aBlock
]
