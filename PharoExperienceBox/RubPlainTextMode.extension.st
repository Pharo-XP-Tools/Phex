Extension { #name : #RubPlainTextMode }

{ #category : #'*PharoExperienceBox' }
RubPlainTextMode class >> phexMenuOn: aBuilder [
	"Specify the menu used when writing text. Try it with:
	(PragmaMenuBuilder 
		pragmaKeyword: 'RubPlainTextMenu'
		model: RubEditingArea new) menu popUpInWorld" 

	<contextMenu>
	<RubPlainTextMenu>
	
	(aBuilder item: #'Browse selection' translated)
		keyText: 'b';
		selector: #browsePhexSelection;
		iconName: #smallFindIcon.

]
