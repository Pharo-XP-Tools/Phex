Class {
	#name : #PhexSurveyQuestionPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'question'
	],
	#category : #'PharoExperienceBox-presenters'
}

{ #category : #spec }
PhexSurveyQuestionPresenter class >> defaultLayout [
	^SpBoxLayout newTopToBottom
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildFreeTextSurveyQuestion: aPhexFreeTextQuestion [

	|newLayout|
	newLayout := self class defaultLayout.
	newLayout add: aPhexFreeTextQuestion title expand: false fill: false.
	newLayout add: self newText.
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildMultipleChoiceSurveyQuestion: aPhexMultipleChoicesQuestion [

	|newLayout boxLayout buttons|
	newLayout := self class defaultLayout.
	newLayout add: aPhexMultipleChoicesQuestion title expand: false fill: false.	
	
	buttons := aPhexMultipleChoicesQuestion choices 
		collect:[:c| (self newCheckBox label: c; yourself)].
	
	newLayout add: (boxLayout := SpBoxLayout newTopToBottom) expand: false fill: false.
	buttons do:[:b| boxLayout add: b].
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildSingleChoiceSurveyQuestion: aPhexYesNoQuestion [

	|newLayout boxLayout buttons|
	newLayout := self class defaultLayout.
	newLayout add: aPhexYesNoQuestion title expand: false fill: false.	
	
	buttons := aPhexYesNoQuestion choices collect:[:c| (self newRadioButton label: c; yourself)].
	buttons first associatedRadioButtons: buttons allButFirst.
	
	newLayout add: (boxLayout := SpBoxLayout newTopToBottom) expand: false fill: false.
	buttons do:[:b| boxLayout add: b].
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildYesNoSurveyQuestion: aPhexYesNoQuestion [

	|newLayout paneLayout buttons|
	newLayout := self class defaultLayout.
	newLayout add: aPhexYesNoQuestion title expand: false fill: false.	
	
	buttons := OrderedCollection new.
	buttons add: (self newRadioButton label: 'Yes'; yourself).
	buttons add: (self newRadioButton label: 'No'; yourself).
	buttons first associatedRadioButtons: buttons allButFirst.
	
	newLayout add: (paneLayout := SpPanedLayout newLeftToRight) expand: false fill: false.
	paneLayout add: buttons first.
	paneLayout add: buttons second.
	self layout: newLayout 
	
]

{ #category : #initialization }
PhexSurveyQuestionPresenter >> initializePresenters [ 
	self question buildOn: self
]

{ #category : #accessing }
PhexSurveyQuestionPresenter >> question [

	^ question
]

{ #category : #accessing }
PhexSurveyQuestionPresenter >> question: anObject [

	question := anObject
]

{ #category : #initialization }
PhexSurveyQuestionPresenter >> setModelBeforeInitialization: aPhexQuestion [
	question := aPhexQuestion 
]
