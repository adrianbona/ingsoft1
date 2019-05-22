!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:51:33'!
boardWithSixMarks

	"     |     | x 
	   y |     | y
	   x | y  | x
	"

	| board |
	
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putYat: 2@1.
	board putXat: 3@1.
	board putYat: 1@2.
	board putXat: 3@3.
	board putYat: 3@2.
	
	^ board.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 21:05:28'!
test01PutAnXAndCheckItsPosition

	| board |
	board _ TerniLapilli new.
	board putXat: 2@2.

	self assert: (board at: 2@2) = #x! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 21:06:48'!
test02PutXAndPutYInDifferentPositionsAndCheckCorrectness

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 19:55:01'!
test07

	| board |
	board _ TerniLapilli new.
	board putXat: 2@2.
	
	self
		should: [ board putXat: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Xs turn'.
			self assert: (board at: 2@2) = #x.
			self assert: (board at: 2@3) = 'empty'.
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 19:56:49'!
test08

	| board |
	board _ TerniLapilli new.
	board putXat: 2@2.
	board putYat: 2@3.
	
	self
		should: [ board putYat: 2@1 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Ys turn'.
			self assert: (board at: 2@2) = #x.
			self assert: (board at: 2@3) = #y.
			self assert: (board at: 2@1) = 'empty'.
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 19:57:45'!
test09

	| board |
	board _ TerniLapilli new.

	self
		should: [ board putXat: 4@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:02:44'!
test10

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putYat: 2@1.
	
	board putXat: 1@2.
	board putYat: 2@2.
	
	board putXat: 1@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:15:33'!
test11

	| board |
	board _ TerniLapilli new.
	board putXat: 2@1.
	board putYat: 1@1.
	
	board putXat: 2@2.
	board putYat: 1@2.
	
	board putXat: 2@3.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 3@1.
	board putYat: 1@1.
	
	board putXat: 3@2.
	board putYat: 1@2.
	
	board putXat: 3@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:20:39'!
test12

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putYat: 1@2.
	
	board putXat: 2@1.
	board putYat: 2@2.
	
	board putXat: 3@1.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 1@2.
	board putYat: 1@1.
	
	board putXat: 2@2.
	board putYat: 2@1.
	
	board putXat: 3@2.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 1@3.
	board putYat: 1@1.
	
	board putXat: 2@3.
	board putYat: 2@1.
	
	board putXat: 3@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:25:14'!
test13

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putYat: 1@2.
	board putXat: 2@2.
	board putYat: 1@3.
	board putXat: 3@3.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 3@1.
	board putYat: 1@2.
	board putXat: 2@2.
	board putYat: 3@2.
	board putXat: 1@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:28:06'!
test14

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putYat: 3@1.
	
	board putXat: 1@2.
	board putYat: 3@2.
	
	board putXat: 2@2.
	board putYat: 3@3.

	self assert: board yIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:29:33'!
test15

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putYat: 2@1.
	
	board putXat: 1@2.
	board putYat: 2@2.
	
	board putXat: 1@3.
	
	self
		should: [ board putYat: 3@2. ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Game has finished'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:50:46'!
test16

	| board |
	board _ self boardWithSixMarks.
	
	self
		should: [ board putXat: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'More than three equal marks are not allowed'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:51:22'!
test17SlideXAndWinGame

	| board |
	board _ self boardWithSixMarks. 
	
	board slideXFrom: 3@1 to: 2@2.
	self assert: (board at: 2@2) = #x.
	self assert: (board at: 3@1) = 'empty'.
	self assert: (board winnerIs: #x).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:51:55'!
test18SlideYAndWinGame

	| board |
	board _ self boardWithSixMarks.
	
	board slideXFrom: 3@3 to: 2@3.
	board slideYFrom: 2@1 to: 2@2.
	self assert: (board at: 2@2) = #y.
	self assert: (board at: 2@1) = 'empty'.
	self assert: (board winnerIs: #y).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:52:10'!
test19CantSlideXFromEmptyPosition

	| board |
	board _ self boardWithSixMarks.
	
	self
		should: [ board slideXFrom: 1@3 to: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide from an empty position'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:52:28'!
test20CantSlideXToOccupiedPosition

	| board |
	board _ self boardWithSixMarks.

	self
		should: [ board slideXFrom: 1@1 to: 1@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide to an occupied position'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:52:50'!
test21CantSlideYFromEmptyPositionNeitherToOccupiedPosition

	| board |
	board _ self boardWithSixMarks.
	
	board slideXFrom: 3@3 to: 2@3.
	
	self
		should: [ board slideYFrom: 2@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide from an empty position'
		].
	
	self
		should: [ board slideYFrom: 3@2 to: 2@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide to an occupied position'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:53:02'!
test22CantSlideToOutOfRange

	| board |
	board _ self boardWithSixMarks.
		
	self
		should: [ board slideXFrom: 3@3 to: 3@4 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'.
			self assert: (board at: 3@3) = #x.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:53:14'!
test23YCantSlideOnXTurn

	| board |
	board _ self boardWithSixMarks.
	
	self
		should: [ board slideYFrom: 1@2 to: 2@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Ys turn'.
			self assert: (board at: 1@2) = #y.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:21:55'!
test24XCantSlideOnYTurn

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putYat: 2@1.
	board putXat: 3@1.
	board putYat: 1@2.
	board putXat: 3@3.
	
	"     |     | x 
	   y |     | y
	   x | y  | x
	"	
	
	self
		should: [ board slideXFrom: 3@1 to: 2@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Xs turn'.
			self assert: (board at: 3@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:54:25'!
test25CantSlideIfGameOver

	| board |
	board _ self boardWithSixMarks.
	
	board slideXFrom: 3@1 to: 2@2.
	
	self
		should: [ board slideYFrom: 1@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Game has finished'.
			self assert: (board at: 1@2) = #y.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:54:37'!
test26XCantSlideIfGameOver

	| board |
	board _ self boardWithSixMarks.
	
	board slideXFrom: 3@3 to: 2@3.
	board slideYFrom: 2@1 to: 2@2.

	self
		should: [ board slideXFrom: 1@1 to: 1@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Game has finished'.
			self assert: (board at: 1@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:54:51'!
test27XCantSlideToDistantPosition

	| board |
	board _ self boardWithSixMarks.
	
	self
		should: [ board slideXFrom: 1@1 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide that far'.
			self assert: (board at: 1@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:55:07'!
test28YCantSlideToDistantPosition

	| board |
	board _ self boardWithSixMarks.
	
	board slideXFrom: 1@1 to: 2@2.
	self
		should: [ board slideYFrom: 2@1 to: 2@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide that far'.
			self assert: (board at: 2@1) = #y.
		].! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board isXTurn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'JR 5/22/2019 20:07:06'!
at: aPosition

	(aPosition x between: 1 and: 3) 
	ifTrue: [ (aPosition y between: 1 and: 3) 
		ifTrue: [ ^ board at: aPosition ifAbsent: 'empty' ]
		ifFalse: [ ^ self error: 'Out of range']
	]
	ifFalse: [ ^ self error: 'Out of range']! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:50:16'!
at: aPosition put: aMark

	(self xIsWinner or: self yIsWinner) ifTrue: [ ^ self error: 'Game has finished' ].
	(self boardContainsThreeMarksWith: aMark) ifTrue: [ ^ self error: 'More than three equal marks are not allowed' ].

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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:52:39'!
boardContainsThreeMarksWith: aMark

	^ (board occurrencesOf: aMark) = 3! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:20:57'!
initialize

	board _ Dictionary new.
	isXTurn _ true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:59:43'!
putXat: aPosition 

	(isXTurn) ifFalse: [ ^ self error: 'It is not Xs turn' ].
	self at: aPosition put: #x! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 18:59:40'!
putYat: aPosition 

	(isXTurn) ifTrue: [ ^ self error: 'It is not Ys turn' ].
	self at: aPosition put: #y! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:24:44'!
threeDiagonallyContinuosWith: aMark

	^ (((self at: 1@1) = aMark) and: ((self at: 2@2) = aMark) and: ((self at: 3@3) = aMark))
		or: (((self at: 3@1) = aMark) and: ((self at: 2@2) = aMark) and: ((self at: 1@3) = aMark))
		! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:21:00'!
threeHorizontallyContinuosWith: aMark

	^ (((self at: 1@1) = aMark) and: ((self at: 2@1) = aMark) and: ((self at: 3@1) = aMark))
		or: (((self at: 1@2) = aMark) and: ((self at: 2@2) = aMark) and: ((self at: 3@2) = aMark))
		or: (((self at: 1@3) = aMark) and: ((self at: 2@3) = aMark) and: ((self at: 3@3) = aMark))
		! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:14:21'!
threeVerticallyContinuosWith: aMark

	^ (((self at: 1@1) = aMark) and: ((self at: 1@2) = aMark) and: ((self at: 1@3) = aMark))
		or: (((self at: 2@1) = aMark) and: ((self at: 2@2) = aMark) and: ((self at: 2@3) = aMark))
		or: (((self at: 3@1) = aMark) and: ((self at: 3@2) = aMark) and: ((self at: 3@3) = aMark))
		! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:24:14'!
winnerIs: aMark

	^ (self threeVerticallyContinuosWith: aMark)
		or: (self threeHorizontallyContinuosWith: aMark)
		or: (self threeDiagonallyContinuosWith: aMark)! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:03:42'!
xIsWinner

	^ self winnerIs: #x! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'AB 5/20/2019 20:26:12'!
yIsWinner

	^ self winnerIs: #y! !


!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/22/2019 20:44:41'!
isValidSlidingDistanceFrom: anOriginPoint to: aDestinationPoint
	
	^ ((anOriginPoint x - aDestinationPoint x) abs < 2) and: ((anOriginPoint y - aDestinationPoint y) abs < 2).! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/22/2019 20:22:23'!
pullXFrom: aPoint

	(self at: aPoint) = 'empty' ifTrue: [^ self error: 'Can not slide from an empty position'].
	(isXTurn) ifFalse: [ ^ self error: 'It is not Xs turn' ].
	board removeKey: aPoint.! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/22/2019 20:19:44'!
pullYFrom: aPoint

	(self at: aPoint) = 'empty' ifTrue: [^ self error: 'Can not slide from an empty position'].
	(isXTurn) ifTrue: [ ^ self error: 'It is not Ys turn' ].
	board removeKey: aPoint.! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/22/2019 20:39:57'!
slideXFrom: anOriginPoint to: aDestinationPoint
	
	(self xIsWinner or: self yIsWinner) ifTrue: [ ^ self error: 'Game has finished' ].
	(self isValidSlidingDistanceFrom: anOriginPoint to: aDestinationPoint) ifFalse: [^ self error: 'Can not slide that far' ].
	(self at: aDestinationPoint) = 'empty' ifFalse: [^ self error: 'Can not slide to an occupied position'].
	self pullXFrom: anOriginPoint.
	self putXat: aDestinationPoint.! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/22/2019 20:46:21'!
slideYFrom: anOriginPoint to: aDestinationPoint
	
	(self xIsWinner or: self yIsWinner) ifTrue: [ ^ self error: 'Game has finished' ].
	(self isValidSlidingDistanceFrom: anOriginPoint to: aDestinationPoint) ifFalse: [^ self error: 'Can not slide that far' ].
	(self at: aDestinationPoint) = 'empty' ifFalse: [^ self error: 'Can not slide to an occupied position'].
	self pullYFrom: anOriginPoint .
	self putYat: aDestinationPoint.! !
