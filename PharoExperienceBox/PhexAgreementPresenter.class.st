"
I present a specific kind of survey: an agreement survey.
I only show the text of the agreement (that is modeled as a PhexQuestion) and a yes and no button.
Clicking `no` just quit Pharo. 
Clicking `yes` records the agreement.
"
Class {
	#name : 'PhexAgreementPresenter',
	#superclass : 'PhexSurveyPresenter',
	#category : 'PharoExperienceBox-presenters',
	#package : 'PharoExperienceBox',
	#tag : 'presenters'
}

{ #category : 'evaluating' }
PhexAgreementPresenter >> evaluateSurvey [
	"By default, if the survey is evaluated it means the user clicked on accept. 
	We just return true as there is nothing more to check."
	^ true
]

{ #category : 'initialization' }
PhexAgreementPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter addButton: 'Submit' do: [ :presenter | 
		questionsPresenters first singleChoiceState = 'No' ifTrue: [ 
			Smalltalk exitFailure ].
		presenter triggerOkAction.
		presenter close ]
]
