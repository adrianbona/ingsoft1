!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:24:47'!
test01

	| board |
	board _ TerniLapilli new.
	board putXat: 2@2.

	self assert: (board at: 2@2) = #x! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:25:09'!
test02

	| board |
	board _ TerniLapilli new.
	board putXat: 2@1.
	board putYat: 2@2.

	self assert: (board at: 2@1) = #x.
	self assert: (board at: 2@2) = #y! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:52:35'!
test03

	| board |
	board _ TerniLapilli new.
	board putXat: 2@2.

	self
		should: [ board putYat: 2@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Already marked'.
			self assert: (board at: 2@2) = #x.
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:17:07'!
test04

	| board |
	board _ TerniLapilli new.
	self assert: (board at: 2@2) = 'empty'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:34:47'!
test05

	| board |
	board _ TerniLapilli new.

	self
		should: [ board putXat: 2@4 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:29:31'!
test06

	| board |
	board _ TerniLapilli new.
	
	self
		should: [ board putYat: 2@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Ys turn'.
			self assert: (board at: 2@2) = 'empty'.
		]! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board isXTurn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:17:29'!
at: aPosition

	^ board at: aPosition ifAbsent: 'empty'! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:58:30'!
at: aPosition put: aMark

	(aPosition x between: 1 and: 3) 
		ifTrue: [ (aPosition y between: 1 and: 3) 
			ifTrue: [ board at: aPosition 
				ifPresent: [ :anElement | ^ self error: 'Already marked']
				ifAbsent: [ 
					board at: aPosition put: aMark.
					isXTurn _ isXTurn not.
				]
			]
			ifFalse: [ ^ self error: 'Out of range']
		]
		ifFalse: [ ^ self error: 'Out of range']! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:20:57'!
initialize

	board _ Dictionary new.
	isXTurn _ true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:20:50'!
isBoardEmpty

	^ board size = 0! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:59:43'!
putXat: aPosition 

	(isXTurn) ifFalse: [ ^ self error: 'It is not Xs turn' ].
	self at: aPosition put: #x! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:59:40'!
putYat: aPosition 

	(isXTurn) ifTrue: [ ^ self error: 'It is not Ys turn' ].
	self at: aPosition put: #y! !
