"
I present a PhexSurveyQuestion: the text of the question and the possible choices of the question.
By default, the choice is nil (i.e., no choice).
"
Class {
	#name : #PhexSurveyQuestionPresenter,
	#superclass : #SpPresenter,
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

{ #category : #accessing }
PhexSurveyQuestionPresenter class >> currentApplication [ 
	^PhexSurveyPresenter currentApplication 
]

{ #category : #spec }
PhexSurveyQuestionPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  borderWidth: 1;
		  yourself
]

{ #category : #building }
PhexSurveyQuestionPresenter >> addQuestionTextPresenterFor: title toLayout: newLayout [

	newLayout
		add: (self buildQuestionText: title)
		withConstraints: [ :c | 
			c height: (title size > 200
					 ifTrue: [ 250 ]
					 ifFalse: [ 60 ]).
			c expand: false.
			c padding: 0 ]
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildAgreementQuestion: aPhexAgreementQuestion [

	| newLayout |
	newLayout := self class defaultLayout.
	
	self
		addQuestionTextPresenterFor: aPhexAgreementQuestion title
		toLayout: newLayout.
		
	radios := OrderedCollection new.
	radios add: (self newRadioButton
			 label: 'Yes';
			 yourself).
	radios add: (self newRadioButton
			 label: 'No';
			 yourself).
	radios first associatedRadioButtons: radios allButFirst.
	radios second state: true.

	newLayout add: (self buildHorizontalRadioBox: radios) expand: false.

	self layout: newLayout
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildFreeTextSurveyQuestion: aPhexFreeTextQuestion [

	|newLayout|
	newLayout := self class defaultLayout.
	self addQuestionTextPresenterFor: aPhexFreeTextQuestion title toLayout: newLayout.	
	newLayout add: freeText withConstraints:[:c| c height: 80].
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildHorizontalRadioBox: rs [

	| box |
	box := SpBoxLayout newLeftToRight.
	self buildRadios: rs inBox: box.
	^ box
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildMultipleChoiceSurveyQuestion: aPhexMultipleChoicesQuestion [

	|newLayout boxLayout|
	newLayout := self class defaultLayout.
	self addQuestionTextPresenterFor: aPhexMultipleChoicesQuestion title toLayout: newLayout.	
		
	checkboxes := aPhexMultipleChoicesQuestion choices 
		collect:[:c| (self newCheckBox label: c; yourself)].
	
	newLayout add: (boxLayout := SpBoxLayout newTopToBottom) expand: false fill: false.
	checkboxes do:[:b| boxLayout add: b].
	self layout: newLayout 
	
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildQuestionText: questionText [

	| textPresenter |
	textPresenter := self newText.
	textPresenter text: questionText.
	textPresenter addStyle: 'bgOpaque'.
	textPresenter beNotEditable.
	textPresenter beWrapWord.
	textPresenter withScrollBars.
	^ textPresenter
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildRadios: rs inBox: box [

	rs do: [ :r | box add: r expand: false ]
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildSingleChoiceSurveyQuestion: aPhexYesNoQuestion [

	| newLayout |
	newLayout := self class defaultLayout.
	self
		addQuestionTextPresenterFor: aPhexYesNoQuestion title
		toLayout: newLayout.

	radios :=( aPhexYesNoQuestion choices collect: [ :c | 
		          self newRadioButton
			          label: c;
							state: false;
			          yourself ]) asOrderedCollection .
	
	radios add: (self newRadioButton label: 'No choice'; yourself).
	radios first associatedRadioButtons: radios allButFirst.
	radios last state: true.
	
	newLayout add: (self buildVerticalRadioBox: radios allButLast) expand: false.

	self layout: newLayout
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildVerticalRadioBox: rs [

	| box |
	box := SpBoxLayout newTopToBottom.
	self buildRadios: rs inBox: box.
	^ box
]

{ #category : #building }
PhexSurveyQuestionPresenter >> buildYesNoSurveyQuestion: aPhexYesNoQuestion [

	| newLayout |
	newLayout := self class defaultLayout.
	
	self
		addQuestionTextPresenterFor: aPhexYesNoQuestion title
		toLayout: newLayout.

	radios := OrderedCollection new.
	radios add: (self newRadioButton
			 label: 'Yes';
			 yourself).
	radios add: (self newRadioButton
			 label: 'No';
			 yourself).
	radios first associatedRadioButtons: radios allButFirst.
	radios second state: true.

	newLayout add: (self buildHorizontalRadioBox: radios) expand: false.
				
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
PhexSurveyQuestionPresenter >> evaluateSurveyAnswer [
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

{ #category : #accessing }
PhexSurveyQuestionPresenter >> singleChoiceState [

	^ (radios detect: [ :r | r state ] ifNone: [ nil ]) ifNotNil: [ :r | 
		  r label ]
]
