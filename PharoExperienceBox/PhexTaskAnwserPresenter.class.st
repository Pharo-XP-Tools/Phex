"
I am opened when a user asks to finish a `PhexTask` from a Phex task launcher:
- I warn the user that finishing a task is definitive
- I provide the user with a way of cancelling
- I provide, if required by the task in question, a way of providing an answer
"
Class {
	#name : #PhexTaskAnwserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'titleLabel',
		'buttonCancel',
		'buttonAccept',
		'text',
		'task',
		'taskDescription',
		'questionLabel',
		'answerLabel'
	],
	#category : #'PharoExperienceBox-presenters'
}

{ #category : #specs }
PhexTaskAnwserPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #titleLabel
		  expand: false
		  fill: false
		  padding: 5;
		add: #questionLabel
		  expand: false
		  fill: false
		  padding: 5;
		  add: #taskDescription;
		add: #answerLabel
		  expand: false
		  fill: false
		  padding: 5;
		  add: #text
		  expand: true
		  fill: true
		  padding: 5;
		  add: (SpGridLayout new
				   beColumnNotHomogeneous;
				   borderWidth: 0;
				   " row: 1 withConstraints: [ :c | c beExpand ];"add:
					   #buttonCancel
				   at: 1 @ 1;
				   add: #buttonAccept at: 2 @ 1)
		  withConstraints: [ :c | c height: 40 ];
		  yourself
]

{ #category : #initialization }
PhexTaskAnwserPresenter >> initializePresenters [

	titleLabel := self newLabel.
	titleLabel label:
		'Warning: finishing a task is a definitive action and it cannot be undone.'.
	questionLabel := self newLabel.
	questionLabel label:
		'To complete this task, you must provide the following information:'.
	titleLabel addStyle: 'error'.
	taskDescription := self newText.
	answerLabel := self newLabel.
	answerLabel label:
		'Write your answer below'.
	text := self newText.

	task ifNotNil: [ 
		taskDescription text: task requiredAnswer.
		taskDescription beNotEditable.
		task requiresAnswer
			ifFalse: [ text beNotEditable ] ].
	buttonCancel := self newButton
		                label: 'Cancel';
		                icon:
			                ((self iconNamed: #smallCancel) scaledToSize:
					                 16 @ 16);
		                yourself.
	buttonAccept := self newButton
		                label: 'Finish task';
		                icon:
			                ((self iconNamed: #smallOk) scaledToSize: 16 @ 16);
		                yourself
]

{ #category : #initialization }
PhexTaskAnwserPresenter >> setModelBeforeInitialization: aPhexTask [
	task := aPhexTask
]