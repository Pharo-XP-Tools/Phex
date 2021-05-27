"
I am opened when a user asks to finish a `PhexTask` from a Phex task launcher:
- I warn the user that finishing a task is definitive
- I provide the user with a way of cancelling
- I provide, if required by the task in question, a way of providing an answer
"
Class {
	#name : #PhexTaskAnwserPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'currentExperience',
		'task',
		'taskAnswer'
	],
	#category : #'PharoExperienceBox-presenters'
}
