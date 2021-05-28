"
I am a tool to run pharo empirical experiments.
"
Class {
	#name : #PhexTaskLauncherPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'currentExperience',
		'taskTable',
		'taskDescription'
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
	 ^currentExperience ifNil:[currentExperience := 'Undefined experience']
]

{ #category : #accessing }
PhexTaskLauncherPresenter >> currentExperience: anObject [

	currentExperience := anObject
]

{ #category : #actions }
PhexTaskLauncherPresenter >> finishTask [

	| task modal taskAnswer |
	task := taskTable selectedItem.
	task ifNil: [ ^ self ].

	modal := (PhexTaskAnwserPresenter on: task) openModalWithSpec.
	modal isOk ifFalse: [ ^ self ].
	
	taskAnswer := modal presenter buildTaskAnswer.
	task answer: taskAnswer.
	
	self runTaskBlock: [ currentExperience finishTask: task ].
	self updateTaskDescription: task.
	
	self update
]

{ #category : #updating }
PhexTaskLauncherPresenter >> finishedTaskDescriptionFor: aTask [

	^ 'You already finished this task'
]

{ #category : #'ui requests' }
PhexTaskLauncherPresenter >> info: aString [

	self popover: aString style: 'print'
]

{ #category : #initialization }
PhexTaskLauncherPresenter >> initializePresenters [
	self initializeTaskTable.
	self initializeTaskDescription.
	self menu applyTo: self.
]

{ #category : #initialization }
PhexTaskLauncherPresenter >> initializeTaskDescription [
	taskDescription := MDMicroEdPresenter on: self.
	taskDescription layout: MDMicroEdPresenter pharoExperienceSpec
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
		(SpStringTableColumn title: 'Task' evaluated: [ :task | task name ]).
	taskTable transmitDo: [ :item| self updateTaskDescription: item].
	self updateCurrentExperience
]

{ #category : #actions }
PhexTaskLauncherPresenter >> loadExperience [

	| xpClass |
	xpClass := UIManager default
		           chooseFrom: PhexExperiment allSubclasses
		           values: PhexExperiment allSubclasses
		           lines: #( 10 )
		           title: 'Choose an experiment to run...'.

	xpClass ifNil: [ ^ self ].

	currentExperience := xpClass currentExperiment.
	self updateCurrentExperience
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
	^ aTask description
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
	taskDescription renderAction
	

]

{ #category : #api }
PhexTaskLauncherPresenter >> updateTitle [
	self window title: self title
]

{ #category : #'ui requests' }
PhexTaskLauncherPresenter >> warning: aString [

	self popover: aString style: 'error'
]
