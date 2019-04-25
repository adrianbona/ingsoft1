!classDefinition: #EmailRenderer category: #CodigoRepetido!
Object subclass: #EmailRenderer
	instanceVariableNames: 'contentTypes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido'!

!EmailRenderer methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 23:19:54'!
initialize

	contentTypes _ Dictionary new.
	contentTypes at: 'Content-Type: text/plain' put: [ :messageContent | messageContent  ].
	contentTypes at: 'Content-Type: text/html' put: [ :messageContent | messageContent asUnHtml ].
	contentTypes at: 'Content-Type: text/csv' put: [ :messageContent | messageContent replaceAll: $, with: $| ].! !

!EmailRenderer methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 23:28:13'!
render: anEmail
	contentTypes keysDo: [ :contentType | self renderEmail: anEmail contentType: contentType withBloque: (contentTypes at: contentType )]! !

!EmailRenderer methodsFor: 'as yet unclassified' stamp: 'JR 4/24/2019 23:20:21'!
renderEmail: anEmail contentType: contentType withBloque: aBloque
	| messageContent |

	(anEmail beginsWith: contentType)
		ifTrue: [ 
			messageContent  := anEmail withoutPrefix:  contentType.
			^ (aBloque value: messageContent)
			]! !
