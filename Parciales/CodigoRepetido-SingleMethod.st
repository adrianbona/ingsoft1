!classDefinition: #EmailRenderer category: #CodigoRepetido!
Object subclass: #EmailRenderer
	instanceVariableNames: 'contentTypes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido'!

!EmailRenderer methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 00:45:03'!
initialize

	| aDictionary |

	aDictionary _ Dictionary new.
	
	aDictionary at: 'Content-Type: text/plain' put: [ :messageContent | messageContent ].
	aDictionary at: 'Content-Type: text/html' put: [ :messageContent | messageContent asUnHtml ].
	aDictionary at: 'Content-Type: text/csv' put: [ :messageContent | messageContent replaceAll: $, with: $| ].
	
	contentTypes _ aDictionary! !

!EmailRenderer methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 10:23:28'!
render: anEmail

	| messageContent |

	contentTypes keysAndValuesDo: [ :contentType :aBlock | 
		(anEmail beginsWith: contentType) ifTrue: [
			messageContent  := anEmail withoutPrefix: contentType.
			^ aBlock value: messageContent
		].
	].
	
	^ messageContent! !
