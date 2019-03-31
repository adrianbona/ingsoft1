!classDefinition: #BooleanosTest category: #Booleano!
DenotativeObject subclass: #BooleanosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooleanosTest class' category: #Booleano!
BooleanosTest class
	instanceVariableNames: ''!

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:33:47'!
test01NoVerdaderoEsFalso
	Assert that: Verdadero no isEqualTo: Falso.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:32:08'!
test01VerdaderoOunBooleanoIgualAVerdadero

	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:36:44'!
test02NoFalsoEsVerdadero
	Assert that: Falso no isEqualTo: Verdadero.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:40:58'!
test03FalsoYunBooleanoEsIgualAfalso

	Assert that: (Falso y: Verdadero) isEqualTo: Falso.
	Assert that: (Falso y: Verdadero) isEqualTo: Falso.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:41:45'!
test04VerdaderoYunBooleanoEsIgualAlBooleano

	Assert that: (Verdadero y: Falso) isEqualTo: Falso.
	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:49:02'!
test05VerdaderoOunBooleanoEsVerdadero

	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:48:45'!
test06FalsoOunBooleanoEsUnBooleano

	Assert that: (Falso o: Falso) isEqualTo: Falso.
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:07:37'!
test07VerdaderoSiVerdaderoEjecutaClosure

	| evaluacionDeBloque |
	
	evaluacionDeBloque _ #BloqueNoEvaluado.
	
	Verdadero siVerdadero: [evaluacionDeBloque _ #BloqueSiEvaluado].
	
	Assert that: evaluacionDeBloque isEqualTo: #BloqueSiEvaluado.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:11:55'!
test08FalsoSiVerdaderoNoEjecutaClosure

	| evaluacionDeBloque |
	
	evaluacionDeBloque _ #BloqueNoEvaluado.
	
	Falso siVerdadero: [evaluacionDeBloque _ #BloqueSiEvaluado].
	
	Assert that: evaluacionDeBloque isEqualTo: #BloqueNoEvaluado.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:15:46'!
test09FalsoSiFalsoEjecutaClosure

	| evaluacionDeBloque |
	
	evaluacionDeBloque _ #BloqueNoEvaluado.
	
	Falso siFalso: [evaluacionDeBloque _ #BloqueSiEvaluado].
	
	Assert that: evaluacionDeBloque isEqualTo: #BloqueSiEvaluado.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:17:23'!
test10VerdaderoSiFalsoNoEjecutaClosure

	| evaluacionDeBloque |
	
	evaluacionDeBloque _ #BloqueNoEvaluado.
	
	Verdadero siFalso: [evaluacionDeBloque _ #BloqueSiEvaluado].
	
	Assert that: evaluacionDeBloque isEqualTo: #BloqueSiEvaluado.! !


!classDefinition: #Falso category: #Booleano!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #Booleano!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:14:47'!
no
	^ Verdadero! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:20:45'!
o: unBooleano

	^ unBooleano.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:16:08'!
siFalso: aBlockClosure 
	aBlockClosure value.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:13:30'!
siVerdadero: aClosure! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:20:57'!
y: unBooleano
	
	^ self! !


!classDefinition: #Verdadero category: #Booleano!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #Booleano!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:14:33'!
no
	^ Falso! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:21:03'!
o: unBooleano

	^ self! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:18:21'!
siFalso: aClosure! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 21:09:49'!
siVerdadero: aClosure 
	aClosure value.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'JR 3/28/2019 20:20:31'!
y: unBooleano

	^ unBooleano.! !
