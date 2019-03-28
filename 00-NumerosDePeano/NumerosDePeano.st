!classDefinition: #I category: #NumerosDePeano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #NumerosDePeano!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:51:46'!
+ unNumeroDePeano

	^unNumeroDePeano next

	! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:40:14'!
next

	^next! !


!classDefinition: #II category: #NumerosDePeano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #NumerosDePeano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:54:12'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 18:16:26'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [ ^self previous].
	^self previous - unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
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


!classDefinition: #III category: #NumerosDePeano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #NumerosDePeano!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [ ^self previous].
	^self previous - unNumeroDePeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!classDefinition: #IIII category: #NumerosDePeano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #NumerosDePeano!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [ ^self previous].
	^self previous - unNumeroDePeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 3/28/2019 18:45:23'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!