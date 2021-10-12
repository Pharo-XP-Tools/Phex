Class {
	#name : #BaselineOfPhex,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhex
}

{ #category : #baselines }
BaselineOfPhex >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec baseline: 'MicrodownDev' with: [ 
			spec
				repository: 'github://pillar-markup/Microdown:dev/src' ].
		spec
			baseline: 'MicroEd'
			with: [ spec repository: 'github://pillar-markup/MicroEd' ].
		spec package: 'PharoExperienceBox' ]
]
