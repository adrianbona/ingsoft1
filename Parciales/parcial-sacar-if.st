!classDefinition: #Fantasma category: #'parcial-sacar-if'!
Object subclass: #Fantasma
	instanceVariableNames: 'nombre estadoNatural ubicacion colorNormal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial-sacar-if'!

!Fantasma methodsFor: 'initialization' stamp: 'HAW 10/7/2018 19:42:35'!
initializeCian

	nombre:= 'Bashful'.
	colorNormal:= Color cyan.
	estadoNatural:= true.
	ubicacion:= self class laberinto.
	
	! !

!Fantasma methodsFor: 'initialization' stamp: 'HAW 10/7/2018 19:42:43'!
initializeOrange

	nombre:= 'Pokey'.
	colorNormal:= Color orange.
	estadoNatural:= true.
	ubicacion:= self class laberinto.
! !

!Fantasma methodsFor: 'initialization' stamp: 'HAW 10/7/2018 19:42:47'!
initializePink

	nombre:= 'Speedy'.
	colorNormal:= Color pink.
	estadoNatural:= true.
	ubicacion:= self class laberinto.
! !

!Fantasma methodsFor: 'initialization' stamp: 'HAW 10/7/2018 19:42:51'!
initializeRed

	nombre:= 'Shadow'.
	colorNormal:= Color red.
	estadoNatural:= true.
	ubicacion:= self class laberinto.
! !


!Fantasma methodsFor: 'accessing' stamp: 'HAW 10/7/2018 19:37:24'!
colorNormal

	^colorNormal ! !

!Fantasma methodsFor: 'accessing' stamp: 'HAW 10/7/2018 19:59:52'!
coloracion
	estadoNatural ifTrue: [^colorNormal] .
	ubicacion = self class casa ifTrue:[^Color black] ifFalse: [^Color blue].! !

!Fantasma methodsFor: 'accessing' stamp: 'JG 10/7/2018 10:49:58'!
nombre

	^nombre.! !

!Fantasma methodsFor: 'accessing' stamp: 'HAW 10/7/2018 19:38:22'!
ubicacion
	
	^ubicacion! !


!Fantasma methodsFor: 'acciones' stamp: 'JG 10/7/2018 14:22:55'!
alejarse
! !

!Fantasma methodsFor: 'acciones' stamp: 'JG 10/7/2018 14:28:26'!
finEfectoPildora

	estadoNatural:= true.
! !

!Fantasma methodsFor: 'acciones' stamp: 'JG 10/7/2018 11:17:15'!
fuisteComido

	estadoNatural:= false.
	^self volverACasa.! !

!Fantasma methodsFor: 'acciones' stamp: 'JG 10/7/2018 12:24:56'!
pildoraComida

	estadoNatural:= false.
	^self alejarse.! !

!Fantasma methodsFor: 'acciones' stamp: 'HAW 10/7/2018 19:42:55'!
regenerarse
	estadoNatural:= true.
	ubicacion:= self class laberinto.
! !

!Fantasma methodsFor: 'acciones' stamp: 'HAW 10/7/2018 19:43:59'!
volverACasa
	ubicacion:= self class casa! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fantasma class' category: #'parcial-sacar-if'!
Fantasma class
	instanceVariableNames: ''!

!Fantasma class methodsFor: 'creacion' stamp: 'JG 10/7/2018 10:58:23'!
newCian

	^self new initializeCian.! !

!Fantasma class methodsFor: 'creacion' stamp: 'JG 10/7/2018 10:58:13'!
newOrange

	^self new initializeOrange.! !

!Fantasma class methodsFor: 'creacion' stamp: 'JG 10/7/2018 10:57:59'!
newPink

	^self new initializePink.! !

!Fantasma class methodsFor: 'creacion' stamp: 'JG 10/7/2018 10:47:22'!
newRed

	^self new initializeRed.! !


!Fantasma class methodsFor: 'ubicaciones' stamp: 'HAW 10/7/2018 19:44:35'!
casa

	^'casa'! !

!Fantasma class methodsFor: 'ubicaciones' stamp: 'HAW 10/7/2018 19:44:30'!
laberinto

	^'laberinto'! !
