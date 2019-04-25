!classDefinition: #ContentType category: #CodigoRepetido!
Object subclass: #ContentType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ContentType class' category: #CodigoRepetido!
ContentType class
	instanceVariableNames: ''!

!ContentType class methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:08:17'!
itsBegOf: anEmail

	^ anEmail beginsWith: self beggining! !

!ContentType class methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 20:54:03'!
newWithMail: anEmail

	^ (self subclasses
		detect: [ :contentSubClass |
			contentSubClass itsBegOf: anEmail ]
		ifNone: [ ^ self error: 'invalid content type ' ]) new! !


!classDefinition: #CSV category: #CodigoRepetido!
ContentType subclass: #CSV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido'!

!CSV methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 20:55:36'!
beggining

	^ 'Content-Type: text/csv'! !

!CSV methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:03:52'!
messageContent: anEmail

	| messageContent |
	
	messageContent  := anEmail withoutPrefix:  self beggining.
	^ messageContent replaceAll: $, with: $| .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSV class' category: #CodigoRepetido!
CSV class
	instanceVariableNames: ''!

!CSV class methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:11:25'!
beggining

	^ 'Content-Type: text/csv'! !


!classDefinition: #HTML category: #CodigoRepetido!
ContentType subclass: #HTML
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido'!

!HTML methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 20:54:45'!
beggining

	^ 'Content-Type: text/html'! !

!HTML methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:04:12'!
messageContent: anEmail

	| messageContent |
	
	messageContent  := anEmail withoutPrefix:  self beggining.
	^ messageContent asUnHtml.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HTML class' category: #CodigoRepetido!
HTML class
	instanceVariableNames: ''!

!HTML class methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:11:39'!
beggining

	^ 'Content-Type: text/html'! !


!classDefinition: #PlainText category: #CodigoRepetido!
ContentType subclass: #PlainText
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido'!

!PlainText methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 20:55:12'!
beggining

	^ 'Content-Type: text/plain'! !

!PlainText methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:03:15'!
messageContent: anEmail

	| messageContent |
	
	messageContent  := anEmail withoutPrefix:  self beggining.
	^ messageContent ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlainText class' category: #CodigoRepetido!
PlainText class
	instanceVariableNames: ''!

!PlainText class methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:12:02'!
beggining

	^ 'Content-Type: text/plain'! !


!classDefinition: #EmailRenderer category: #CodigoRepetido!
Object subclass: #EmailRenderer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido'!

!EmailRenderer methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 21:13:22'!
render: anEmail

	| contentType |
	
	contentType _ ContentType newWithMail: anEmail.
	^ contentType messageContent: anEmail.! !
