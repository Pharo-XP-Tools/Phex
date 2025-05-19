"
I am opened when a user asks to finish a `PhexTask` from a Phex task launcher:
- I warn the user that finishing a task is definitive
- I provide the user with a way of cancelling
- I provide, if required by the task in question, a way of providing an answer
"
Class {
	#name : 'PhexTaskAnwserPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'titleLabel',
		'text',
		'task',
		'taskDescription',
		'questionLabel',
		'answerLabel',
		'subtitleLabel'
	],
	#category : 'PharoExperienceBox-presenters',
	#package : 'PharoExperienceBox',
	#tag : 'presenters'
}

{ #category : 'api' }
PhexTaskAnwserPresenter >> buildTaskAnswer [

	^ PhexTaskAnswer new contents: text text
]

{ #category : 'specs' }
PhexTaskAnwserPresenter >> defaultLayout [

	^ task requiresAnswer 
		ifTrue: [ self layoutWithAnswer ]
		ifFalse: [ self layoutWithoutAnswer ]. 
]

{ #category : 'initialization' }
PhexTaskAnwserPresenter >> initializePresenters [

	titleLabel := self newLabel.
	titleLabel label: 'This action is definitive action and cannot be undone.'.
	titleLabel addStyle: 'headerError'.
	
	subtitleLabel := self newLabel.
	subtitleLabel label:'You can pass this task just by clicking ok.'.
	subtitleLabel addStyle: 'headerError'.
	
	questionLabel := self newLabel.
	questionLabel addStyle: 'dim'.
	questionLabel label: 'To complete this task, you must provide the following information:'.
	
	taskDescription := self newText.
	
	answerLabel := self newLabel.
	answerLabel addStyle: 'dim'.
	answerLabel label: 'Write your answer below'.
	
	text := self newText.

	task ifNotNil: [ 
		taskDescription text: task requiredAnswer.
		taskDescription beNotEditable.
		task requiresAnswer ifFalse: [ text beNotEditable ] 
	]
]

{ #category : 'initialization' }
PhexTaskAnwserPresenter >> initializeWindow: aWindowPresenter [ 

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: ('Finish task' , (task ifNil: [ String empty ] ifNotNil: [ task title ]));
		initialExtent: 500 @ 500
]

{ #category : 'specs' }
PhexTaskAnwserPresenter >> layoutWithAnswer [

	^ SpBoxLayout newTopToBottom
		 add: titleLabel expand: false fill: false padding: 5;
		 add: subtitleLabel expand: false fill: false padding: 5;
		 add: questionLabel expand: false fill: false padding: 5;
		 add: taskDescription;
		 add: answerLabel expand: false fill: false padding: 5;
		 add: text expand: true fill: true padding: 5;
		 yourself
]

{ #category : 'specs' }
PhexTaskAnwserPresenter >> layoutWithoutAnswer [

	^ SpBoxLayout newTopToBottom
		 add: titleLabel expand: false fill: false padding: 5;
		 add: subtitleLabel expand: false fill: false padding: 5;
		 add: questionLabel expand: false fill: false padding: 5;
		 add: taskDescription;
		 yourself
]

{ #category : 'initialization' }
PhexTaskAnwserPresenter >> setModelBeforeInitialization: aPhexTask [

	task := aPhexTask
]
