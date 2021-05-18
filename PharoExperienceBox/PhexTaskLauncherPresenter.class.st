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

{ #category : #'as yet unclassified' }
PhexTaskLauncherPresenter class >> pharoExperienceSpec [

	^ SpBoxLayout newTopToBottom
		  add: #textOutput;
		  yourself
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

	| xpName xpClass |
	xpName := UIManager default
		          request: 'Experience name?'
		          initialAnswer: ''.
	(#( nil '' ) includes: xpName) ifTrue: [ ^ self ].
	xpClass := Smalltalk at: xpName capitalized asSymbol ifAbsent: [ 
		           self inform: 'Experience not found'.
		           ^ self ].
	currentExperience := xpClass new.
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

{ #category : #actions }
PhexTaskLauncherPresenter >> startSelectedTask [
	 self halt
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
	item ifNil:[^self].
	
	taskDescription textInputText: item contents.
	taskDescription renderAction
	

]

{ #category : #api }
PhexTaskLauncherPresenter >> updateTitle [
	self window title: self title
]
