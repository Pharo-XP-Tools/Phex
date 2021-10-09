Extension { #name : #MDEditorPresenter }

{ #category : #'*PharoExperienceBox' }
MDEditorPresenter class >> pharoExperienceSpec [
	^ SpBoxLayout newTopToBottom
		  add: #textOutput;
		  yourself
]
