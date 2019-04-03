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

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 18:34:01'!
* unNumeroDePeano

	^ unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:51:46'!
+ unNumeroDePeano

	^unNumeroDePeano next

	! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 19:22:13'!
- unNumeroDePeano
	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 19:23:15'!
/ unNumeroDePeano

	unNumeroDePeano = self
		ifTrue: [^self].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:44:52'!
< unNumeroDePeano
	unNumeroDePeano = self ifTrue: [^false].
	^ true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 19:22:59'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir al I por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 19:21:21'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Error numero negativo'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:03:11'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/1/2019 18:18:01'!
* unNumeroDePeano

	| previo |
	previo := Dictionary new.
	previo at: I put: self.
	
	^ previo at: unNumeroDePeano ifAbsent: [self * unNumeroDePeano previous + self]! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 3/28/2019 17:54:12'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:00:04'!
- unNumeroDePeano

	| minuendo sustraendo |
	
	minuendo := self previous.
	sustraendo := unNumeroDePeano.
	
	[sustraendo ~= I] whileTrue: [
		minuendo := minuendo previous.
		sustraendo := unNumeroDePeano previous.
	].

	^ minuendo.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 19:22:39'!
/ unNumeroDePeano
	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I! !

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 18:44:39'!
< unNumeroDePeano
	| numeroAnterior |
	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!II class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 19:22:50'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir un numero por otro mayor'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:03:11'!
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

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
* unNumeroDePeano

	| previo |
	previo := Dictionary new.
	previo at: I put: self.
	
	^ previo at: unNumeroDePeano ifAbsent: [self * unNumeroDePeano previous + self]! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
- unNumeroDePeano

	| minuendo sustraendo |
	
	minuendo := self previous.
	sustraendo := unNumeroDePeano.
	
	[sustraendo ~= I] whileTrue: [
		minuendo := minuendo previous.
		sustraendo := unNumeroDePeano previous.
	].

	^ minuendo.
! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
/ unNumeroDePeano
	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
< unNumeroDePeano
	| numeroAnterior |
	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir un numero por otro mayor'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:03:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:04'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
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

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
* unNumeroDePeano

	| previo |
	previo := Dictionary new.
	previo at: I put: self.
	
	^ previo at: unNumeroDePeano ifAbsent: [self * unNumeroDePeano previous + self]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
- unNumeroDePeano

	| minuendo sustraendo |
	
	minuendo := self previous.
	sustraendo := unNumeroDePeano.
	
	[sustraendo ~= I] whileTrue: [
		minuendo := minuendo previous.
		sustraendo := unNumeroDePeano previous.
	].

	^ minuendo.
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
/ unNumeroDePeano
	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
< unNumeroDePeano
	| numeroAnterior |
	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir un numero por otro mayor'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:03:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:02:05'!
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