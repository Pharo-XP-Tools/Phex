Extension { #name : #MDMicroEdPresenter }

{ #category : #'*PharoExperienceBox' }
MDMicroEdPresenter class >> pharoExperienceSpec [

	^ SpBoxLayout newTopToBottom
		  add: #textOutput;
		  yourself
]
