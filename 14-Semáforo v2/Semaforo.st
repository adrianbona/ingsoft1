!classDefinition: #CajaDeSeñalesEnDireccionACorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #CajaDeSeñalesEnDireccionACorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CajaDeSeñalesEnDireccionACorrientes class' category: #Semaforo!
CajaDeSeñalesEnDireccionACorrientes class
	instanceVariableNames: 'SeñalDeAdvertencia'!

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:20:49'!
apagar
	self señalDeAdvertencia apagar.
	self señalDeAvance apagar.
	self señalDeDetencion apagar.! !

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

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 20:20:26'!
detenerTrafico
	self señalDeAvance apagar.
	self señalDeAdvertencia prender.
	(Delay for: 1*second) wait.
	self señalDeAdvertencia apagar.
	self señalDeDetencion prender.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 20:15:42'!
habilitarTrafico
	self señalDeDetencion apagar.
	self señalDeAvance prender.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	SeñalDeAdvertencia := nil.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:18:58'!
prender
	self apagar.
	self avisarPrecaucionPorAviso.! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:05:51'!
señalDeAdvertencia
	^ SeñalDeAdvertenciaEnDireccionACorrientes ! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:07:46'!
señalDeAvance
	^ SeñalDeAvanceEnDireccionACorrientes ! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:08:01'!
señalDeDetencion
	^ SeñalDeDetencionEnDireccionACorrientes ! !

!CajaDeSeñalesEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:13:44'!
titilarSeñalDeAdvertencia
	
	self señalDeAdvertencia prender.
	(Delay for: 0.5 * second) wait.
	self señalDeAdvertencia apagar.
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

!CajaDeSeñalesEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	SeñalDeAdvertencia := nil.! !

!CajaDeSeñalesEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:06:06'!
señalDeAdvertencia
	^ SeñalDeAdvertenciaEnDireccionAMedrano ! !

!CajaDeSeñalesEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:08:39'!
señalDeAvance
	^ SeñalDeAvanceEnDireccionAMedrano ! !

!CajaDeSeñalesEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:08:26'!
señalDeDetencion
	^ SeñalDeDetencionEnDireccionAMedrano ! !


!classDefinition: #SemaforoDeCorrientesYMedrano category: #Semaforo!
DenotativeObjectMorph subclass: #SemaforoDeCorrientesYMedrano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeCorrientesYMedrano class' category: #Semaforo!
SemaforoDeCorrientesYMedrano class
	instanceVariableNames: ''!

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/6/2019 19:42:19'!
apagar
	CajaDeSeñalesEnDireccionACorrientes apagar.
	CajaDeSeñalesEnDireccionAMedrano apagar.! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:41:32'!
prender

	CajaDeSeñalesEnDireccionACorrientes prender. 
	CajaDeSeñalesEnDireccionAMedrano prender.
	
	SeñalDeAvanceEnDireccionACorrientes prender.
	SeñalDeDetencionEnDireccionAMedrano prender.
	
	Temporizador interrumpimeEn: 2*second con: [ self señalDeAvanceEnDireccionAMedranoYSeñalDeDetencionEnDireccionACorrientes ].
	
	! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:43:27'!
señalDeAvanceEnDireccionACorrientesYSeñalDeDetencionEnDireccionAMedrano

	CajaDeSeñalesEnDireccionAMedrano detenerTrafico .
	CajaDeSeñalesEnDireccionACorrientes habilitarTrafico .
	Temporizador interrumpimeEn: 3*second con: [ self señalDeAvanceEnDireccionAMedranoYSeñalDeDetencionEnDireccionACorrientes].! !

!SemaforoDeCorrientesYMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:43:05'!
señalDeAvanceEnDireccionAMedranoYSeñalDeDetencionEnDireccionACorrientes

	CajaDeSeñalesEnDireccionACorrientes detenerTrafico .
	CajaDeSeñalesEnDireccionAMedrano habilitarTrafico .
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

!SeñalDeAdvertenciaEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
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

!SeñalDeAdvertenciaEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
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

!SeñalDeAvanceEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
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

!SeñalDeAvanceEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
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

!SeñalDeDetencionEnDireccionACorrientes class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
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

!SeñalDeDetencionEnDireccionAMedrano class methodsFor: 'as yet unclassified' stamp: 'AB 4/7/2019 21:46:06'!
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