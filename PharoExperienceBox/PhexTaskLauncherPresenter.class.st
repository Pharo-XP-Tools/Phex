"
I am a tool to run pharo empirical experiments.
"
Class {
	#name : 'PhexTaskLauncherPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'currentExperience',
		'taskTable',
		'taskDescription',
		'finishModalIsOpen',
		'toolbar'
	],
	#category : 'PharoExperienceBox-presenters',
	#package : 'PharoExperienceBox',
	#tag : 'presenters'
}

{ #category : 'accessing' }
PhexTaskLauncherPresenter class >> currentApplication [ 
	^PhexSurveyPresenter currentApplication 
]

{ #category : 'specs' }
PhexTaskLauncherPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #toolbar expand: false;
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 30 percent;
				   add: #taskTable;
				   add: #taskDescription;
				   yourself);
		  yourself
]

{ #category : 'world menu' }
PhexTaskLauncherPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Phex')
		parent: #Tools;
		action: [ self open ];
		order: 40;
		help: 'Pharo Experience Task Launcher';
		icon: (self iconNamed: #glamorousBrowseIcon).
	aBuilder withSeparatorAfter
]

{ #category : 'examples' }
PhexTaskLauncherPresenter class >> open [
	<example>
	^ self new openWithSpec; yourself
]

{ #category : 'accessing' }
PhexTaskLauncherPresenter >> currentExperience [
	 ^currentExperience ifNil:[currentExperience := PhexExperiment new]
]

{ #category : 'accessing' }
PhexTaskLauncherPresenter >> currentExperience: anObject [

	currentExperience := anObject
]

{ #category : 'accessing' }
PhexTaskLauncherPresenter >> finishModalIsOpen [ 
	^finishModalIsOpen ifNil:[finishModalIsOpen := false]
]

{ #category : 'actions' }
PhexTaskLauncherPresenter >> finishTask [

	| task modal taskAnswer |
	self finishModalIsOpen ifTrue: [ ^ self ].
	task := taskTable selectedItem.
	task ifNil: [ ^ self ].

	self runTaskBlock: [ 
		currentExperience ensureTaskCanBeFinished: task.
		finishModalIsOpen := true.
		modal := (PhexTaskAnwserPresenter on: task)
			         owner: self;
			         openBlockedDialogWithSpec.
		finishModalIsOpen := false.
		modal isOk ifFalse: [ ^ self ].
		taskAnswer := modal presenter buildTaskAnswer.
		task answer: taskAnswer.

		currentExperience finishTask: task.
		currentExperience runSurveyFor: task with: self.
				
		currentExperience isFinished ifTrue: [ 
			currentExperience runPostSurveysWith: self.
			currentExperience terminate ] ].


	self updateTaskDescription: task
]

{ #category : 'updating' }
PhexTaskLauncherPresenter >> finishedTaskDescriptionFor: aTask [

	| str title |
	aTask alwaysDisplayDescription ifTrue:[^ aTask contents ].
	str := WriteStream on: String new.
	title := aTask passed
		         ifTrue: [ 
		         '#You passed this task. This action is irreversible.' ]
		         ifFalse: [ '#You already finished this task.' ].
	str << title.
	str cr.
	str << 'Your answer was:'.
	str cr.
	str << aTask answer contents.
	^ str contents
]

{ #category : 'ui requests' }
PhexTaskLauncherPresenter >> info: aString [

	self popover: aString style: 'print'
]

{ #category : 'initialization' }
PhexTaskLauncherPresenter >> initializePresenters [

	self application: self class currentApplication.
	self initializeTaskTable.
	self initializeTaskDescription.
	self initializeToolbar
]

{ #category : 'initialization' }
PhexTaskLauncherPresenter >> initializeTaskDescription [

	taskDescription := MicrodownPresenter on: self.
	taskDescription text: (Microdown asRichText: '## select a task')
]

{ #category : 'initialization' }
PhexTaskLauncherPresenter >> initializeTaskTable [

	taskTable := self newTable.
	taskTable
		addColumn:
			((SpImageTableColumn
				  title: 'Status'
				  evaluated: [ :task | task icon ])
				 width: 12;
				 sortFunction: nil;
				 yourself);
		addColumn:
		(SpStringTableColumn title: 'Task' evaluated: [ :task | task title ]).
	taskTable transmitDo: [ :item| self updateTaskDescription: item].
	self updateCurrentExperience
]

{ #category : 'api' }
PhexTaskLauncherPresenter >> initializeToolbar [

	toolbar := self newToolbar.
	toolbar beBoth.
	toolbar add: (SpToolbarButtonPresenter new
			 icon: (self iconNamed: #smallPrintIt);
			 label: 'Start';
			 action: [ self startSelectedTask ];
			 yourself).

	toolbar add: (SpToolbarButtonPresenter new
			 icon: (self iconNamed: #smallOk);
			 label: 'Finish';
			 action: [ self finishTask ];
			 yourself)
]

{ #category : 'actions' }
PhexTaskLauncherPresenter >> loadExperience [

	| xpClass xpClassChoices |
	xpClassChoices := PhexExperiment allSubclasses select: [ :c | 
		                  c isRunnableExperience ].
	xpClass := UIManager default
		           chooseFrom: xpClassChoices
		           values: xpClassChoices
		           lines: #( 10 )
		           title: 'Choose an experiment to run...'.

	xpClass ifNil: [ ^ self ].
	currentExperience class = xpClass ifTrue: [ 
		self inform: 'The experiment is already loaded'.
		^ self ].
	self loadExperience: xpClass
]

{ #category : 'actions' }
PhexTaskLauncherPresenter >> loadExperience: xpClass [

	currentExperience := xpClass currentExperiment.
	currentExperience prepareSystemForExperiment.
	currentExperience materialize.
	self updateCurrentExperience.
	ExperimentLogging setLoggerFor: currentExperience.
	currentExperience logger experimentLoaded: currentExperience.
	Smalltalk image saveSession.
	currentExperience runAgreementSurveyWith: self.
	currentExperience runPreSurveysWith: self
]

{ #category : 'api' }
PhexTaskLauncherPresenter >> menu [
 
	^ toolbar ifNil: [ 
		  toolbar := self newMenuBar
			          addGroup: [ :group | 
				       "   group addItem: [ :item | 
						          item
							          name: 'Load experience';
							          description: 'Load an experience';
							          icon: (self iconNamed: #smallNew);
							          action: [ self loadExperience ] ]."
				          group addItem: [ :item | 
					          item
						          name: 'Start';
						          description: 'Start the selected task';
						          shortcut: $o meta;
						          icon: (self iconNamed: #smallPrintIt);
						          action: [ self startSelectedTask ] ].
				          group addItem: [ :item | 
					          item
						          name: 'Finish';
						          description: 'Finish the selected task';
						          shortcut: $s meta;
						          icon: (self iconNamed: #smallOk);
						          action: [ self finishTask ] ] ];
			          yourself ]
]

{ #category : 'actions' }
PhexTaskLauncherPresenter >> openModal: aPhexSurveyPresenter for: aPhexSurvey [

	| modal |
	self finishModalIsOpen ifTrue: [ ^ self ].
	finishModalIsOpen := true.
	modal := aPhexSurveyPresenter openBlockedDialogWithSpec.
	finishModalIsOpen := false.
	aPhexSurvey answers: modal presenter evaluateSurvey
]

{ #category : 'initialization' }
PhexTaskLauncherPresenter >> openWithSpec [ 
	super openWithSpec.
	self window window makeUnclosable 
	
]

{ #category : 'ui requests' }
PhexTaskLauncherPresenter >> popover: aString style: aStyle [

	self newPopover
		addStyle: aStyle;
		relativeTo: taskTable;
		position: SpPopoverPosition top;
		presenter: (SpPresenter new
				 layout: (SpBoxLayout newVertical
						  borderWidth: 2;
						  spacing: 0;
						  add: (self newLabel label: aString);
						  yourself);
				 yourself);
		popup
]

{ #category : 'private' }
PhexTaskLauncherPresenter >> requestWindowClose [
	 ^self currentExperience closeable
]

{ #category : 'actions' }
PhexTaskLauncherPresenter >> runAgreementSurvey: aPhexSurvey [

	self
		openModal: ((PhexAgreementPresenter on: aPhexSurvey)
				 owner: self;
				 yourself)
		for: aPhexSurvey
]

{ #category : 'actions' }
PhexTaskLauncherPresenter >> runSurvey: aPhexSurvey [

	self
		openModal: ((PhexSurveyPresenter on: aPhexSurvey)
				 owner: self;
				 yourself)
		for: aPhexSurvey
]

{ #category : 'api' }
PhexTaskLauncherPresenter >> runTaskBlock: aBlock [

	aBlock
		on: PhexTaskError
		do: [ :error | 
			self warning: error errorMessage.
			^ self ].
	self update.
	self info: 'Success. Image saved.'.
	Smalltalk image saveSession
]

{ #category : 'actions' }
PhexTaskLauncherPresenter >> startSelectedTask [

	| task |
	task := taskTable selectedItem.
	task ifNil: [ ^ self ].

	self runTaskBlock: [ currentExperience startTask: task ].
	self updateTaskDescription: task
]

{ #category : 'updating' }
PhexTaskLauncherPresenter >> taskDescriptionFor: aTask [

	aTask isStarted ifTrue: [ ^ aTask contents ].
	^ 'This task is not started yet. Click **Start**, or select another task and click **Start**.'
]

{ #category : 'accessing' }
PhexTaskLauncherPresenter >> title [

	^ 'Task launcher: ' , self currentExperience printString
]

{ #category : 'updating' }
PhexTaskLauncherPresenter >> updateCurrentExperience [

	currentExperience ifNil: [ 
		taskTable items: #(  ).
		^ self ].
	taskTable items: currentExperience tasks
]

{ #category : 'updating' }
PhexTaskLauncherPresenter >> updateTaskDescription: item [

	item ifNil: [ ^ self ].

	self updateTextInputWith: (item isFinished
			 ifTrue: [ self finishedTaskDescriptionFor: item ]
			 ifFalse: [ self taskDescriptionFor: item ])
]

{ #category : 'updating' }
PhexTaskLauncherPresenter >> updateTextInputWith: aString [

	taskDescription text: (Microdown asRichText: aString)
]

{ #category : 'api' }
PhexTaskLauncherPresenter >> updateTitle [
	self window title: self title
]

{ #category : 'ui requests' }
PhexTaskLauncherPresenter >> warning: aString [

	self popover: aString style: 'error'
]
