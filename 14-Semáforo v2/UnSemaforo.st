!classDefinition: #LucesDeSemaforo category: #Semaforo!
DenotativeObjectMorph subclass: #LucesDeSemaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LucesDeSemaforo class' category: #Semaforo!
LucesDeSemaforo class
	instanceVariableNames: ''!

!LucesDeSemaforo class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 14:53:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


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


!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:57:19'!
apagar
	self color: Color black.! !

!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 14:53:49'!
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

!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 14:53:49'!
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

!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 14:53:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 20:58:28'!
prender
	self color: Color green.! !


!classDefinition: #UnSemaforo category: #Semaforo!
DenotativeObjectMorph subclass: #UnSemaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnSemaforo class' category: #Semaforo!
UnSemaforo class
	instanceVariableNames: ''!

!UnSemaforo class methodsFor: 'morph' stamp: 'JR 3/25/2019 20:58:46'!
apagar
	LuzRoja apagar.
	LuzAmarilla apagar.
	LuzVerde apagar.! !

!UnSemaforo class methodsFor: 'morph' stamp: 'HAW 9/17/2018 15:31:40'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !

!UnSemaforo class methodsFor: 'morph' stamp: 'JR 3/25/2019 21:24:01'!
prender
	self avisarPrecaucionPorAviso.! !


!UnSemaforo class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 21:45:59'!
avisarPrecaucionPorAviso

	5 timesRepeat: [self titilarLuzAmarilla].! !

!UnSemaforo class methodsFor: 'as yet unclassified' stamp: 'JR 3/31/2019 14:53:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!UnSemaforo class methodsFor: 'as yet unclassified' stamp: 'JR 3/25/2019 21:44:21'!
titilarLuzAmarilla

	LuzAmarilla prender.
	(Delay for: 0.5*second) wait.
	LuzAmarilla apagar.
	(Delay for: 0.5*second) wait.! !

LucesDeSemaforo initializeAfterFileIn!
LuzAmarilla initializeAfterFileIn!
LuzRoja initializeAfterFileIn!
LuzVerde initializeAfterFileIn!
UnSemaforo initializeAfterFileIn!