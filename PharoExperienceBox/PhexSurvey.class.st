"
I model a survey.

I hold a set of questions, instances of subclasses of `PhexAbstractQuestion`.

I hold a validation block that does nothing by default, but which can be configured to perform custom actions while validating a survey.
The `validate` method is automatically called when a new answer is provided.

I am open by default while my `answers` instance variable remains nil.
I am considered closed once my `answers` instance variable is no longer nil.

"
Class {
	#name : #PhexSurvey,
	#superclass : #Object,
	#instVars : [
		'title',
		'id',
		'questions',
		'validationBlock',
		'answers',
		'uuid',
		'configurator',
		'isSingleCriticalYesNoQuestion'
	],
	#category : #'PharoExperienceBox-model'
}

{ #category : #'instance creation' }
PhexSurvey class >> postExperimentSurvey [
	|configurator survey|
	survey := self new.
	configurator := PhexPostExperimentSurveyConfigurator on: survey.
	^survey
	
]

{ #category : #'instance creation' }
PhexSurvey class >> preExperimentSurvey [
	|configurator survey|
	survey := self new.
	configurator := PhexPreExperimentSurveyConfigurator on: survey.
	^survey
	
]

{ #category : #'ston-core' }
PhexSurvey class >> stonAllInstVarNames [

	"Override to encode my instances using a custom set of instance variables or to define their order."

	^ super stonAllInstVarNames
		  reject: [ :e | e = #validationBlock ]
]

{ #category : #questions }
PhexSurvey >> addQuestion: aQuestion [
	self questions add: aQuestion
]

{ #category : #accessing }
PhexSurvey >> answers [

	^ answers
]

{ #category : #accessing }
PhexSurvey >> answers: anObject [
	self flag: 'Accessor should not do more than accessing. Rename this method.'.
	answers := anObject.
	self validate
]

{ #category : #accessing }
PhexSurvey >> configurator [

	^ configurator ifNil: [ configurator := PhexSurveyConfigurator on: self ]
]

{ #category : #accessing }
PhexSurvey >> configurator: anObject [

	configurator := anObject
]

{ #category : #initialization }
PhexSurvey >> configureForExperiment: anExperiment [
	self configurator configureForExperiment:  anExperiment
]

{ #category : #accessing }
PhexSurvey >> id [

	^ id
]

{ #category : #accessing }
PhexSurvey >> id: anObject [

	id := anObject
]

{ #category : #initialization }
PhexSurvey >> initialize [ 
	uuid := UUID new
]

{ #category : #testing }
PhexSurvey >> isClosed [
	^answers notNil
]

{ #category : #testing }
PhexSurvey >> isOpen [
	^self isClosed not
]

{ #category : #accessing }
PhexSurvey >> questions [

	^ questions ifNil:[questions := OrderedCollection new]
]

{ #category : #accessing }
PhexSurvey >> questions: anObject [

	questions := anObject
]

{ #category : #accessing }
PhexSurvey >> title [

	^ title
]

{ #category : #accessing }
PhexSurvey >> title: anObject [

	title := anObject
]

{ #category : #accessing }
PhexSurvey >> uuid [

	^ uuid
]

{ #category : #questions }
PhexSurvey >> validate [
	self validationBlock cull: self
]

{ #category : #accessing }
PhexSurvey >> validationBlock [

	^ validationBlock ifNil: [ validationBlock := [ :survey| ] ]
]

{ #category : #accessing }
PhexSurvey >> validationBlock: anObject [

	validationBlock := anObject
]
