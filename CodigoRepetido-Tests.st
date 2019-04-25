!classDefinition: #EmailRendererTest category: #'CodigoRepetido-Tests'!
TestCase subclass: #EmailRendererTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Tests'!

!EmailRendererTest methodsFor: 'tests' stamp: 'HAW 10/8/2018 16:48:31'!
test01EmailDeTextoPlanoLoRenderizaComoTal

	| email |

	email := 'Content-Type: text/plain Hola mundo!!'.
	
	self assert: (EmailRenderer new render: email) equals: ' Hola mundo!!'! !

!EmailRendererTest methodsFor: 'tests' stamp: 'HAW 10/8/2018 16:49:33'!
test02EmailDeHTMLLoRenderizaSinLosTagsDeHtml

	| email |
	
	email := 'Content-Type: text/html <p>Chau mundo!!</p>'.
	
	self assert: (EmailRenderer new render: email) equals: ' Chau mundo!!' asUnHtml! !

!EmailRendererTest methodsFor: 'tests' stamp: 'HAW 10/8/2018 16:49:54'!
test03EmailDeCsvLoRenderizaCambiandoComaPorPipe

	| email |
	
	email := 'Content-Type: text/csv campo1,campo2'.
	
	self assert: (EmailRenderer new render: email) equals: ' campo1|campo2' ! !
