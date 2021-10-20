Class {
	#name : #PhexSurveyPresenter,
	#superclass : #SpApplicationWithToolbar,
	#instVars : [
		'survey',
		'actionBar',
		'questionsPresenters'
	],
	#category : #'PharoExperienceBox-presenters'
}

{ #category : #accessing }
PhexSurveyPresenter class >> currentApplication [

	^ SpApplication new
		  styleSheet: self styleSheet;
		  yourself
]

{ #category : #specs }
PhexSurveyPresenter class >> defaultSpec [ 
	^SpBoxLayout newTopToBottom 
]

{ #category : #accessing }
PhexSurveyPresenter class >> styleSheet [

	^ SpStyleVariableSTONReader fromString: '
.application [
	Font { #name : EnvironmentFont(#default) },
	Geometry { #height: 25 },
	.box [ Geometry { #height: Reset, #vResizing: true, #hResizing: true } ],
	.label [
		Geometry { #hResizing: true },
		.headerBold [ Font { #bold: true }],
		.headerError [ Draw { #color:  #red } , Font { #bold: true }  ],
		.headerSuccess [ Draw { #color: #green } ],
		.header [ Draw { #color: Color{ #rgb: 622413393 } } ],
		.shortcut [ Draw { #color: Color{ #rgb: 622413393 } } ],
		.fixed [ Geometry { #hResizing: false, #width: 100 } ],
		.dim [ Draw { #color : Color{ #rgb: 708480675 } } ]
	],
	.link [ Geometry { #hResizing: true } ],
	.button [  
		Geometry { #width: 100, #height: 30 },
		.small [ Geometry { #width: 25, #height: 25 } ]
	],
	.checkBox [  
		Geometry { #hResizing: true },
		.compact [ Geometry { #hResizing: false, #width: 20 } ]
	],
	.radioButton [ Geometry { #hResizing: true } ],
	.dropList [ Geometry { #width: 150, #hResizing: true } ],
	.list [ Geometry { #width: 150, #minHeight: 125, #hResizing: true, #vResizing: true } ],
	.slider [ Geometry { #width: 150, #hResizing: true } ],
	.actionBar [  
		Container { #borderWidth: 0, #padding: 5 },
		Geometry { #width: 150, #height: 29, #hResizing: true, #vResizing: false }
	],
	.menuBar [ Geometry { #width: 150, #hResizing: true } ],
	.actionButton [  
		Geometry { #width: 70, #hResizing: false },
		.showIcon [ Geometry { #width: 25 } ]
	],
	.toolbar [ 
		Geometry { #height: Reset, #hResizing: true },
		.icons [ Geometry { #height: 30 } ],
		.iconsAndLabel [ Geometry { #height: 45 } ]
	],
	.text [ Geometry { #height: Reset }, Font { #size: 18 } ],
	.code [ Font { #name: EnvironmentFont(#code) } ],
	.codePopover [ 
		Draw { #color : #transparent },
		.button [ Geometry { #width : 25 } ]
	],
	.codePopoverError [ 
		Draw { #backgroundColor: #C20000 },
		Font { #color: #white } 
	],
	.scrollbarPopoverLarge [ Geometry { #height: 350 } ],
	.large [ Font { #size: 20 } ],
	.popover [
		.print [ Draw { #color: EnvironmentColor(#balloonBackground) } ],
		.error [ Draw { #color: #C20000 } ],
		.large [ Font { #size: 20 } ],
		.popoverButton [ Draw { #color: EnvironmentColor(#popoverButton) } ] ],
	.paginator [ Geometry { #height: 20 } ],
	.morph [ Geometry { #width: Reset, #height: Reset, #vResizing: true, #hResizing: true } ],
	.image [ Geometry { #width: Reset, #height: Reset, #vResizing: true, #hResizing: true } ] ]
'
]

{ #category : #evaluating }
PhexSurveyPresenter >> evaluateSurvey [

	^ questionsPresenters collect: [ :p | 
		  p
			  evaluateSurveyAnswer;
			  question ]
]

{ #category : #initialization }
PhexSurveyPresenter >> initializePresenters [
	|newLayout scrollablePresenter|
	
	super initializePresenters.
	questionsPresenters := survey questions collect: [ :q | 
		                       PhexSurveyQuestionPresenter on: q ].
	newLayout := SpBoxLayout newTopToBottom.
	questionsPresenters do:[:qp| newLayout add: qp].
	scrollablePresenter := SpPresenter new.
	scrollablePresenter layout: newLayout.
	self layout: (SpScrollableLayout with: scrollablePresenter)
]

{ #category : #initialization }
PhexSurveyPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: survey title
]

{ #category : #initialization }
PhexSurveyPresenter >> setModelBeforeInitialization: aPhexSurvey [
	survey := aPhexSurvey 
]
