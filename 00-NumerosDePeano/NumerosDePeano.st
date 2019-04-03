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

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:08:27'!
* unNumeroDePeano

	^ unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:08:44'!
+ unNumeroDePeano

	^unNumeroDePeano next.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:08:22'!
- unNumeroDePeano

	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:09:04'!
/ unNumeroDePeano

	unNumeroDePeano = self ifTrue: [^self].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:09:12'!
< unNumeroDePeano

	unNumeroDePeano = self ifTrue: [^false].
	^ true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:09:20'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir al I por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:09:24'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ 'Error numero negativo'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:09:32'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:17:35'!
* unNumeroDePeano

	| mutiplicando multiplicador |

	mutiplicando := self.
	multiplicador := unNumeroDePeano.

	[multiplicador ~= I] whileTrue: [
		mutiplicando := mutiplicando + self.
		multiplicador := unNumeroDePeano previous.
	].

	^ mutiplicando.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:06:03'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:06:48'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:10:07'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:06:38'!
< unNumeroDePeano

	| numeroAnterior |

	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:06:56'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir un numero por otro mayor'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:22'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:07:20'!
next

	next ifNil: [
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].

	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:09:50'!
previous

	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:07:33'!
previous: unNumeroDePeano

	previous := unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:07:50'!
removeAllNext

	next ifNotNil: [
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

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:01'!
* unNumeroDePeano

	| mutiplicando multiplicador |

	mutiplicando := self.
	multiplicador := unNumeroDePeano.

	[multiplicador ~= I] whileTrue: [
		mutiplicando := mutiplicando + self.
		multiplicador := unNumeroDePeano previous.
	].

	^ mutiplicando.
! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
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

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
< unNumeroDePeano

	| numeroAnterior |

	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir un numero por otro mayor'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
next

	next ifNil: [
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].

	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
previous

	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
previous: unNumeroDePeano

	previous := unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
removeAllNext

	next ifNotNil: [
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

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
* unNumeroDePeano

	| mutiplicando multiplicador |

	mutiplicando := self.
	multiplicador := unNumeroDePeano.

	[multiplicador ~= I] whileTrue: [
		mutiplicando := mutiplicando + self.
		multiplicador := unNumeroDePeano previous.
	].

	^ mutiplicando.
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
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

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
/ unNumeroDePeano

	self < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = unNumeroDePeano ifTrue: [^I].
	^ self - unNumeroDePeano / unNumeroDePeano + I.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
< unNumeroDePeano

	| numeroAnterior |

	unNumeroDePeano = I ifTrue: [^false].
	numeroAnterior _ unNumeroDePeano previous .
	self = numeroAnterior ifTrue: [^true].
	^self < numeroAnterior .! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'No se puede dividir un numero por otro mayor'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:02'!
next

	next ifNil: [
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].

	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:03'!
previous

	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:03'!
previous: unNumeroDePeano

	previous := unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AB 4/3/2019 13:18:03'!
removeAllNext

	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!