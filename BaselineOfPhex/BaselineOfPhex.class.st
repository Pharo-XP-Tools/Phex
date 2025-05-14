Class {
	#name : #BaselineOfPhex,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhex
}

{ #category : #baselines }
BaselineOfPhex >> baseline: spec [

	<baseline>
	spec for: #common do: [ 

		spec
			baseline: 'MicroEd'
			with: [ spec repository: 'github://Pharo-XP-Tools/MicroEd' ].
		spec package: 'PharoExperienceBox' ]
]
