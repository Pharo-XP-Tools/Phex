"
I am a tool to run pharo empirical experiments.
"
Class {
	#name : #PhexTaskLauncherPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'currentExperience',
		'taskTable',
		'taskDescription',
		'finishModalIsOpen'
	],
	#category : #'PharoExperienceBox-presenters'
}

{ #category : #specs }
PhexTaskLauncherPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #menu expand: false;
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 30 percent;
				   add: #taskTable;
				   add: #taskDescription;
				   yourself);
		  yourself
]

{ #category : #'world menu' }
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

{ #category : #examples }
PhexTaskLauncherPresenter class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #accessing }
PhexTaskLauncherPresenter >> currentExperience [
	 ^currentExperience ifNil:[currentExperience := PhexExperiment new]
]

{ #category : #accessing }
PhexTaskLauncherPresenter >> currentExperience: anObject [

	currentExperience := anObject
]

{ #category : #accessing }
PhexTaskLauncherPresenter >> finishModalIsOpen [ 
	^finishModalIsOpen ifNil:[finishModalIsOpen := false]
]

{ #category : #actions }
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

		currentExperience runSurveyFor: task with: self.
		currentExperience finishTask: task.
		currentExperience isFinished ifTrue: [ 
			currentExperience runPostSurveysWith: self.
			currentExperience terminate ] ].


	self updateTaskDescription: task.
	self update
]

{ #category : #updating }
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

{ #category : #'ui requests' }
PhexTaskLauncherPresenter >> info: aString [

	self popover: aString style: 'print'
]

{ #category : #initialization }
PhexTaskLauncherPresenter >> initializePresenters [
	self initializeTaskTable.
	self initializeTaskDescription.
	self menu
]

{ #category : #initialization }
PhexTaskLauncherPresenter >> initializeTaskDescription [
	taskDescription := MDEditorPresenter on: self.
	taskDescription layout: MDEditorPresenter pharoExperienceSpec
]

{ #category : #initialization }
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

{ #category : #actions }
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

{ #category : #api }
PhexTaskLauncherPresenter >> menu [

	^ menu ifNil: [ 
		  menu := self newMenuBar
			          addGroup: [ :group | 
				          group addItem: [ :item | 
						          item
							          name: 'Load experience';
							          description: 'Load an experience';
							          icon: (self iconNamed: #smallNew);
							          action: [ self loadExperience ] ].
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

{ #category : #actions }
PhexTaskLauncherPresenter >> openModal: aPhexSurveyPresenter for: aPhexSurvey [

	| modal |
	self finishModalIsOpen ifTrue: [ ^ self ].
	finishModalIsOpen := true.
	modal := aPhexSurveyPresenter openBlockedDialogWithSpec.
	finishModalIsOpen := false.
	aPhexSurvey answers: modal presenter evaluateSurvey
]

{ #category : #'ui requests' }
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

{ #category : #private }
PhexTaskLauncherPresenter >> requestWindowClose [
	 ^self currentExperience closeable
]

{ #category : #actions }
PhexTaskLauncherPresenter >> runAgreementSurvey: aPhexSurvey [

	self
		openModal: ((PhexAgreementPresenter on: aPhexSurvey)
				 owner: self;
				 yourself)
		for: aPhexSurvey
]

{ #category : #actions }
PhexTaskLauncherPresenter >> runSurvey: aPhexSurvey [

	self
		openModal: ((PhexSurveyPresenter on: aPhexSurvey)
				 owner: self;
				 yourself)
		for: aPhexSurvey
]

{ #category : #api }
PhexTaskLauncherPresenter >> runTaskBlock: aBlock [

	aBlock
		on: PhexTaskError
		do: [ :error | 
			self warning: error errorMessage.
			^ self ].
	self info: 'Success. Image saved.'.
	Smalltalk image saveSession
]

{ #category : #actions }
PhexTaskLauncherPresenter >> startSelectedTask [

	| task |
	task := taskTable selectedItem.
	task ifNil: [ ^ self ].

	self runTaskBlock: [ currentExperience startTask: task ].
	self updateTaskDescription: task.

	self update
]

{ #category : #updating }
PhexTaskLauncherPresenter >> taskDescriptionFor: aTask [

	aTask isStarted ifTrue: [ ^ aTask contents ].
	^ 'This task is not started yet. Click **Start**, or select another task and click **Start**.'
]

{ #category : #accessing }
PhexTaskLauncherPresenter >> title [

	^ 'Task launcher: ' , self currentExperience printString
]

{ #category : #updating }
PhexTaskLauncherPresenter >> updateCurrentExperience [

	currentExperience ifNil: [ 
		taskTable items: #(  ).
		^ self ].
	taskTable items: currentExperience tasks.
	self updateTitle
]

{ #category : #updating }
PhexTaskLauncherPresenter >> updateTaskDescription: item [

	item ifNil: [ ^ self ].

	self updateTextInputWith: (item isFinished
			 ifTrue: [ self finishedTaskDescriptionFor: item ]
			 ifFalse: [ self taskDescriptionFor: item ])
]

{ #category : #updating }
PhexTaskLauncherPresenter >> updateTextInputWith: aString [
	
	taskDescription textInputText: aString.
	taskDescription renderDocument
	

]

{ #category : #api }
PhexTaskLauncherPresenter >> updateTitle [
	self window title: self title
]

{ #category : #'ui requests' }
PhexTaskLauncherPresenter >> warning: aString [

	self popover: aString style: 'error'
]
