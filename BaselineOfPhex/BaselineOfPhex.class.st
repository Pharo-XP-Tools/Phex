Class {
	#name : #BaselineOfPhex,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhex
}

{ #category : #baselines }
BaselineOfPhex >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'PharoExperienceBox' ]
]
