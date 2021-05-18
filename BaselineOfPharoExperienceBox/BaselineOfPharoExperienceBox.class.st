Class {
	#name : #BaselineOfPharoExperienceBox,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoExperienceBox
}

{ #category : #baselines }
BaselineOfPharoExperienceBox >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec baseline: 'MicroEd' with: [ spec repository: 'github://pillar-markup/MicroEd' ].
		spec package: 'PharoExperienceBox' ]
]
