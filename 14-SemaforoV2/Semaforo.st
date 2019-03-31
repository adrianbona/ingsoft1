!classDefinition: #LuzAmarilla category: #Semaforo!
DenotativeObjectMorph subclass: #LuzAmarilla
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzAmarilla class' category: #Semaforo!
LuzAmarilla class
	instanceVariableNames: ''!

!LuzAmarilla class methodsFor: 'morph' stamp: 'HAW 9/17/2018 15:32:29'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !

!LuzAmarilla class methodsFor: 'morph' stamp: 'JR 3/25/2019 21:05:14'!
titilar: veces
	veces timesRepeat: 
	[self prender.
	(Delay for: 1*second) wait.
	self apagar.
	(Delay for: 1*second) wait.]
! !


!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:57:19'!
apagar
	self color: Color black.! !

!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 21:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:58:12'!
prender
	self color: Color yellow.! !


!classDefinition: #LuzRoja category: #Semaforo!
DenotativeObjectMorph subclass: #LuzRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzRoja class' category: #Semaforo!
LuzRoja class
	instanceVariableNames: ''!

!LuzRoja class methodsFor: 'morph' stamp: 'JR 3/25/2019 20:28:12'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:57:37'!
apagar
	self color: Color black.! !

!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 21:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:58:20'!
prender
	self color: Color red.! !


!classDefinition: #LuzVerde category: #Semaforo!
DenotativeObjectMorph subclass: #LuzVerde
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzVerde class' category: #Semaforo!
LuzVerde class
	instanceVariableNames: ''!

!LuzVerde class methodsFor: 'morph' stamp: 'JR 3/25/2019 20:28:25'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:57:49'!
apagar
	self color: Color black.! !

!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 21:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:58:28'!
prender
	self color: Color green.! !


!classDefinition: #Semaforo category: #Semaforo!
DenotativeObjectMorph subclass: #Semaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Semaforo class' category: #Semaforo!
Semaforo class
	instanceVariableNames: ''!

!Semaforo class methodsFor: 'morph' stamp: 'JR 3/25/2019 20:58:46'!
apagar
	LuzRoja apagar.
	LuzAmarilla apagar.
	LuzVerde apagar.! !

!Semaforo class methodsFor: 'morph' stamp: 'HAW 9/17/2018 15:31:40'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !

!Semaforo class methodsFor: 'morph' stamp: 'JR 3/25/2019 21:05:29'!
prender
	LuzAmarilla titilar: 5.! !


!Semaforo class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 21:06:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

LuzAmarilla initializeAfterFileIn!
LuzRoja initializeAfterFileIn!
LuzVerde initializeAfterFileIn!
Semaforo initializeAfterFileIn!