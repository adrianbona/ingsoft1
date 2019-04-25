!classDefinition: #FantasmaTest category: #'parcial-sacar-if-tests'!
TestCase subclass: #FantasmaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'parcial-sacar-if-tests'!

!FantasmaTest methodsFor: 'tests' stamp: 'HAW 10/7/2018 19:43:08'!
test01BashfulSeCreaConElColorCorrectoEnElLaberinto

	| bashful |

	bashful:= Fantasma newCian.

	self assert: bashful coloracion equals: Color cyan.
	self assert: bashful ubicacion equals: Fantasma laberinto.	! !

!FantasmaTest methodsFor: 'tests' stamp: 'HAW 10/7/2018 19:43:12'!
test02PacmanComePildorayBashfulSePoneAzulYSigueEnElLaberinto

	| bashful |
	
	bashful:= Fantasma newCian.
	bashful pildoraComida .
	
	self assert: bashful coloracion equals: Color blue.
	self assert: bashful ubicacion equals: Fantasma laberinto.
	! !

!FantasmaTest methodsFor: 'tests' stamp: 'HAW 10/7/2018 19:44:06'!
test03BashfulEsComidoYSePoneNegroYSeVaACasa

	| bashful |
	
	bashful:= Fantasma newCian.
	bashful fuisteComido .
	
	self assert: bashful coloracion equals: Color black.
	self assert: bashful ubicacion equals: Fantasma casa
	! !

!FantasmaTest methodsFor: 'tests' stamp: 'HAW 10/7/2018 19:43:17'!
test04BashfulSeRegeneraYVuelveAEstarDeSuColorEnElLaberinto

	| bashful |

	bashful:= Fantasma newCian.
	bashful regenerarse .

	self assert: bashful coloracion equals: Color cyan.
	self assert: bashful ubicacion equals: Fantasma laberinto.
	! !
