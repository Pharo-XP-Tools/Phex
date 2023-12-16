Class {
	#name : #PhexQuestionRequestPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'buttons',
		'choices',
		'selectedChoice',
		'question'
	],
	#category : #'PharoExperienceBox-presenters'
}

{ #category : #layout }
PhexQuestionRequestPresenter >> buttons [
	^buttons ifNil:[buttons := OrderedCollection new]
]

{ #category : #layout }
PhexQuestionRequestPresenter >> content [
	^ 'I am a modal demo with custom actions buttons.  I set closeOnBackdropClick to false so that the user cannot click on the backdrop to close the modal.'
]

{ #category : #layout }
PhexQuestionRequestPresenter >> defaultLayout [

	layout := SpBoxLayout newTopToBottom.
	layout add: self textPresenter height: 80.
	self buttons do: [ :b | layout add: b expand: false fill: false ].
	^ layout
]

{ #category : #initialize }
PhexQuestionRequestPresenter >> initializeDialogWindow: aDialog [

	aDialog closeOnBackdropClick: false.
	aDialog cancelAction: [  ].
	aDialog title: 'Question'
]

{ #category : #initialize }
PhexQuestionRequestPresenter >> initializePresenters [

	super initializePresenters.

	buttons := choices collect: [ :c |
		           self newButton
			           action: [ self selectedChoice: c ];
			           label: c;
			           yourself ]
]

{ #category : #'accessing - model' }
PhexQuestionRequestPresenter >> questionText: text [
	question := text
]

{ #category : #accessing }
PhexQuestionRequestPresenter >> selectedChoice [

	^ selectedChoice
]

{ #category : #'accessing - model' }
PhexQuestionRequestPresenter >> selectedChoice: aString [

	selectedChoice := aString.
	self window
		beOk;
		triggerOkAction;
		close
]

{ #category : #'accessing - model' }
PhexQuestionRequestPresenter >> setModelBeforeInitialization: model [

	choices := model.
	selectedChoice := nil
]

{ #category : #initialize }
PhexQuestionRequestPresenter >> textPresenter [

	^ self newText
		  text: (question ifNil: [ '' ]);
		  beNotEditable;
		  yourself
]
