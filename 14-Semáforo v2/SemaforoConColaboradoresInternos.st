!classDefinition: #CajaDeSeñalesEnDireccionACorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #CajaDeSeñalesEnDireccionACorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CajaDeSeñalesEnDireccionACorrientes class' category: #Semaforo!
CajaDeSeñalesEnDireccionACorrientes class
	instanceVariableNames: 'señalDeDetencion señalDeAdvertencia señalDeAvance'!

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:15:57'!
apagar
	señalDeAdvertencia apagar.
	señalDeAvance apagar.
	señalDeDetencion apagar.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:15:30'!
avisarPrecaucionPorAviso
	5 timesRepeat:
	[
		self titilarSeñalDeAdvertencia.
	].! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:16:32'!
createMorph
	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself ! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:16:11'!
detenerTrafico
	señalDeAvance apagar.
	señalDeAdvertencia prender.
	(Delay for: 1*second) wait.
	señalDeAdvertencia apagar.
	señalDeDetencion prender.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:16:19'!
habilitarTrafico
	señalDeDetencion apagar.
	señalDeAvance prender.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	señalDeDetencion := SeñalDeDetencionEnDireccionACorrientes.
	señalDeAdvertencia := SeñalDeAdvertenciaEnDireccionACorrientes.
	señalDeAvance := SeñalDeAvanceEnDireccionACorrientes.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:18:58'!
prender
	self apagar.
	self avisarPrecaucionPorAviso.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:16:33'!
titilarSeñalDeAdvertencia
	
	señalDeAdvertencia prender.
	(Delay for: 0.5 * second) wait.
	señalDeAdvertencia apagar.
	(Delay for: 0.5 * second) wait.! !


!classDefinition: #CajaDeSeñalesEnDireccionAMedrano category: #Semaforo!
CajaDeSeñalesEnDireccionACorrientes subclass: #CajaDeSeñalesEnDireccionAMedrano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CajaDeSeñalesEnDireccionAMedrano class' category: #Semaforo!
CajaDeSeñalesEnDireccionAMedrano class
	instanceVariableNames: ''!

!CajaDeSeñalesEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	señalDeDetencion := SeñalDeDetencionEnDireccionAMedrano.
	señalDeAdvertencia := SeñalDeAdvertenciaEnDireccionAMedrano.
	señalDeAvance := SeñalDeAvanceEnDireccionAMedrano.! !


!classDefinition: #SemaforoDeCorrientesYMedrano category: #Semaforo!
DenotativeObjectMorph subclass: #SemaforoDeCorrientesYMedrano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeCorrientesYMedrano class' category: #Semaforo!
SemaforoDeCorrientesYMedrano class
	instanceVariableNames: 'cajaDeSeñalesEnDireccionACorrientes cajaDeSeñalesEnDireccionAMedrano'!

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:10:57'!
apagar
	cajaDeSeñalesEnDireccionACorrientes apagar.
	cajaDeSeñalesEnDireccionAMedrano apagar.! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	cajaDeSeñalesEnDireccionACorrientes := CajaDeSeñalesEnDireccionACorrientes.
	cajaDeSeñalesEnDireccionAMedrano := CajaDeSeñalesEnDireccionAMedrano.! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:18:59'!
prender

	cajaDeSeñalesEnDireccionACorrientes prender. 
	cajaDeSeñalesEnDireccionAMedrano prender.
	
	SeñalDeAvanceEnDireccionACorrientes prender.
	SeñalDeDetencionEnDireccionAMedrano prender.
	
	Temporizador interrumpimeEn: 2*second con: [ self señalDeAvanceEnDireccionAMedranoYSeñalDeDetencionEnDireccionACorrientes ].
	
	! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:10:35'!
señalDeAvanceEnDireccionACorrientesYSeñalDeDetencionEnDireccionAMedrano

	cajaDeSeñalesEnDireccionAMedrano detenerTrafico .
	cajaDeSeñalesEnDireccionACorrientes habilitarTrafico .
	Temporizador interrumpimeEn: 3*second con: [ self señalDeAvanceEnDireccionAMedranoYSeñalDeDetencionEnDireccionACorrientes].! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:10:41'!
señalDeAvanceEnDireccionAMedranoYSeñalDeDetencionEnDireccionACorrientes

	cajaDeSeñalesEnDireccionACorrientes detenerTrafico .
	cajaDeSeñalesEnDireccionAMedrano habilitarTrafico .
	Temporizador interrumpimeEn: 3*second con: [ self señalDeAvanceEnDireccionACorrientesYSeñalDeDetencionEnDireccionAMedrano ].! !


!classDefinition: #SeñalDeAdvertenciaEnDireccionACorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeAdvertenciaEnDireccionACorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAdvertenciaEnDireccionACorrientes class' category: #Semaforo!
SeñalDeAdvertenciaEnDireccionACorrientes class
	instanceVariableNames: ''!

!SeñalDeAdvertenciaEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:53:20'!
apagar
	self color: Color black.! !

!SeñalDeAdvertenciaEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:13:47'!
createMorph

	^ EllipseMorph new
		color: Color black;
		yourself! !

!SeñalDeAdvertenciaEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!SeñalDeAdvertenciaEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:54:30'!
prender
	self color: Color yellow.! !


!classDefinition: #SeñalDeAdvertenciaEnDireccionAMedrano category: #Semaforo!
SeñalDeAdvertenciaEnDireccionACorrientes subclass: #SeñalDeAdvertenciaEnDireccionAMedrano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAdvertenciaEnDireccionAMedrano class' category: #Semaforo!
SeñalDeAdvertenciaEnDireccionAMedrano class
	instanceVariableNames: ''!

!SeñalDeAdvertenciaEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeAvanceEnDireccionACorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeAvanceEnDireccionACorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceEnDireccionACorrientes class' category: #Semaforo!
SeñalDeAvanceEnDireccionACorrientes class
	instanceVariableNames: ''!

!SeñalDeAvanceEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:53:39'!
apagar
	self color: Color black.! !

!SeñalDeAvanceEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:14:15'!
createMorph

	^ EllipseMorph new
		color: Color black;
		yourself! !

!SeñalDeAvanceEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!SeñalDeAvanceEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:54:20'!
prender
	self color: Color green.! !


!classDefinition: #SeñalDeAvanceEnDireccionAMedrano category: #Semaforo!
SeñalDeAvanceEnDireccionACorrientes subclass: #SeñalDeAvanceEnDireccionAMedrano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeAvanceEnDireccionAMedrano class' category: #Semaforo!
SeñalDeAvanceEnDireccionAMedrano class
	instanceVariableNames: ''!

!SeñalDeAvanceEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionEnDireccionACorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeDetencionEnDireccionACorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionEnDireccionACorrientes class' category: #Semaforo!
SeñalDeDetencionEnDireccionACorrientes class
	instanceVariableNames: ''!

!SeñalDeDetencionEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:53:44'!
apagar
	self color: Color black.! !

!SeñalDeDetencionEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:14:22'!
createMorph

	^ EllipseMorph new
		color: Color black;
		yourself! !

!SeñalDeDetencionEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!SeñalDeDetencionEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 18:54:05'!
prender
	self color: Color red.! !


!classDefinition: #SeñalDeDetencionEnDireccionAMedrano category: #Semaforo!
SeñalDeDetencionEnDireccionACorrientes subclass: #SeñalDeDetencionEnDireccionAMedrano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionEnDireccionAMedrano class' category: #Semaforo!
SeñalDeDetencionEnDireccionAMedrano class
	instanceVariableNames: ''!

!SeñalDeDetencionEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'JR 4/7/2019 22:20:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #Temporizador category: #Semaforo!
DenotativeObject subclass: #Temporizador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Temporizador class' category: #Semaforo!
Temporizador class
	instanceVariableNames: ''!

!Temporizador class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:28:03'!
interrumpimeEn: unaCantidadDeTiempo con: unMensaje

	(Delay for: unaCantidadDeTiempo) wait.
	unMensaje value.! !

CajaDeSeñalesEnDireccionACorrientes initializeAfterFileIn!
CajaDeSeñalesEnDireccionAMedrano initializeAfterFileIn!
SemaforoDeCorrientesYMedrano initializeAfterFileIn!
SeñalDeAdvertenciaEnDireccionACorrientes initializeAfterFileIn!
SeñalDeAdvertenciaEnDireccionAMedrano initializeAfterFileIn!
SeñalDeAvanceEnDireccionACorrientes initializeAfterFileIn!
SeñalDeAvanceEnDireccionAMedrano initializeAfterFileIn!
SeñalDeDetencionEnDireccionACorrientes initializeAfterFileIn!
SeñalDeDetencionEnDireccionAMedrano initializeAfterFileIn!