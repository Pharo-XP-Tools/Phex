Extension { #name : #RubEditingArea }

{ #category : #'*PharoExperienceBox' }
RubEditingArea >> browsePhexSelection [

	| selection |
	selection := self selection asString.
	selection first = $# ifTrue: [ 
		selection := selection copyFrom: 2 to: selection size ].
	Smalltalk at: selection asSymbol ifPresent: [ :class | class browse ].
	self systemNavigation browseAllImplementorsOf: selection asSymbol
]
