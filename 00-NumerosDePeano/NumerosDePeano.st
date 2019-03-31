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

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 17:58:37'!
- unNumeroDePeano
	^ self error: 'No se puede restar al I'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:34:07'!
/ unNumeroDePeano

	unNumeroDePeano = self
		ifTrue: [^self].
	self error: 'No se puede dividir por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:44:52'!
< unNumeroDePeano
	unNumeroDePeano = self ifTrue: [^false].
	^ true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:49:01'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:18:46'!
/ unNumeroDePeano
	self < unNumeroDePeano ifTrue: [self error: 'No se puede dividir por un numero mayor'].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I! !

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:44:39'!
< unNumeroDePeano
	| numeroAnterior |
	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:49:01'!
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


!classDefinition: #III category: #'Numeros De Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros De Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
* unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self].
	^ self * unNumeroDePeano previous + self! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [ ^self previous].
	^self previous - unNumeroDePeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
/ unNumeroDePeano
	self < unNumeroDePeano ifTrue: [self error: 'No se puede dividir por un numero mayor'].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
< unNumeroDePeano
	| numeroAnterior |
	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:49:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!classDefinition: #IIII category: #'Numeros De Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros De Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
* unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self].
	^ self * unNumeroDePeano previous + self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [ ^self previous].
	^self previous - unNumeroDePeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
/ unNumeroDePeano
	self < unNumeroDePeano ifTrue: [self error: 'No se puede dividir por un numero mayor'].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
< unNumeroDePeano
	| numeroAnterior |
	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:49:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:46:42'!
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