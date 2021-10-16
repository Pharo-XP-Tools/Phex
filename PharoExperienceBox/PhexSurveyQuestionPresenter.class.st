Class {
	#name : #PhexSurveyQuestionPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'question',
		'checkboxes',
		'radios',
		'freeText',
		'result',
		'answer'
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
	newLayout add: freeText.
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildMultipleChoiceSurveyQuestion: aPhexMultipleChoicesQuestion [

	|newLayout boxLayout|
	newLayout := self class defaultLayout.
	newLayout add: aPhexMultipleChoicesQuestion title expand: false fill: false.	
	
	checkboxes := aPhexMultipleChoicesQuestion choices 
		collect:[:c| (self newCheckBox label: c; yourself)].
	
	newLayout add: (boxLayout := SpBoxLayout newTopToBottom) expand: false fill: false.
	checkboxes do:[:b| boxLayout add: b].
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildSingleChoiceSurveyQuestion: aPhexYesNoQuestion [

	|newLayout boxLayout|
	newLayout := self class defaultLayout.
	newLayout add: aPhexYesNoQuestion title expand: false fill: false.	
	
	radios := aPhexYesNoQuestion choices collect:[:c| (self newRadioButton label: c; yourself)].
	radios first associatedRadioButtons: radios allButFirst.
	
	newLayout add: (boxLayout := SpBoxLayout newTopToBottom) expand: false fill: false.
	radios do:[:b| boxLayout add: b].
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildYesNoSurveyQuestion: aPhexYesNoQuestion [

	|newLayout paneLayout|
	newLayout := self class defaultLayout.
	newLayout add: aPhexYesNoQuestion title expand: false fill: false.	
	
	radios := OrderedCollection new.
	radios add: (self newRadioButton label: 'Yes'; yourself).
	radios add: (self newRadioButton label: 'No'; yourself).
	radios first associatedRadioButtons: radios allButFirst.
	
	newLayout add: (paneLayout := SpPanedLayout newLeftToRight) expand: false fill: false.
	paneLayout add: radios first.
	paneLayout add: radios second.
	self layout: newLayout 
	
]

{ #category : #evaluating }
PhexSurveyQuestionPresenter >> evaluateFreeTextAnswerFrom: aPhexQuestion [
	self newAnswerForQuestion: aPhexQuestion.
	answer answer: freeText text
	
]

{ #category : #evaluating }
PhexSurveyQuestionPresenter >> evaluateMultipleChoiceAnswerFrom: aPhexMultipleChoicesQuestion [

	self newAnswerForQuestion: aPhexMultipleChoicesQuestion.
	answer answer:
		(checkboxes select: [ :c | c state ] thenCollect: [ :c | c label ])
]

{ #category : #evaluating }
PhexSurveyQuestionPresenter >> evaluateSingleChoiceAnswerFrom: aPhexSingleChoiceQuestion [

	self newAnswerForQuestion: aPhexSingleChoiceQuestion.
	answer answer: (radios
			 detect: [ :r | r state ]
			 ifFound: [ :r | r label ]
			 ifNone: [ 'No answer found' ])
]

{ #category : #evaluating }
PhexSurveyQuestionPresenter >> evaluateSurvey [
	question evaluateResultFrom: self
]

{ #category : #evaluating }
PhexSurveyQuestionPresenter >> evaluateYesNoAnswerFor: aPhexYesNoQuestion [

	self newAnswerForQuestion: aPhexYesNoQuestion.
	answer answer: (radios
			 detect: [ :r | r state ]
			 ifFound: [ :r | r label ]
			 ifNone: [ 'No answer found' ])
]

{ #category : #initialization }
PhexSurveyQuestionPresenter >> initializePresenters [
	checkboxes := OrderedCollection new. 	
	radios := OrderedCollection new.	
	freeText := self newText.
	self question buildOn: self
]

{ #category : #evaluating }
PhexSurveyQuestionPresenter >> newAnswerForQuestion: aPhexQuestion [

	answer := PhexSurveyAnswer new.
	aPhexQuestion answer: answer
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
