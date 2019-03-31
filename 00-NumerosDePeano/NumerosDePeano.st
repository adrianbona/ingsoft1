!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 18:34:01'!
* unNumeroDePeano

	^ unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:51:46'!
+ unNumeroDePeano

	^unNumeroDePeano next

	! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 18:43:32'!
/ unNumeroDePeano

	unNumeroDePeano = self
		ifTrue: [^self].
	self error: 'ERROR EEEEEEEEEEEEEEEEEEEEH'! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 14:53:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:40:14'!
next

	^next! !


!classDefinition: #II category: #'Numeros De Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 18:35:40'!
* unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self].
	^ self * unNumeroDePeano previous + self! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:54:12'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 18:16:26'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [ ^self previous].
	^self previous - unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 18:54:52'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I! !

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 14:53:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 18:07:16'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 18:01:40'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 18:17:27'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 18:06:24'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

I initializeAfterFileIn!
II initializeAfterFileIn!