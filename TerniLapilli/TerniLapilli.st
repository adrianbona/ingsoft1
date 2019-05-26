!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:17:09'!
boardWithSixTokens

	"     |     | x 
	   y |     | y
	   x | y  | x
	"

	| board |
	
	board _ TerniLapilli new.

	board putXat: 1@1.
	board putOat: 2@1.
	board putXat: 3@1.
	board putOat: 1@2.
	board putXat: 3@3.
	board putOat: 3@2.
	
	^ board.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:30:43'!
test01PutAnXAndCheckItsPosition

	| board |

	board _ TerniLapilli new.

	board putXat: 2@2.

	self assert: (board at: 2@2) = #x! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:43:24'!
test02PutXAndPutYInDifferentPositionsAndCheckCorrectness

	| board |
	board _ TerniLapilli new.
	board putXat: 2@1.
	board putOat: 2@2.

	self assert: (board at: 2@1) = #x.
	self assert: (board at: 2@2) = #o! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:43:55'!
test03CanNotPlaceATokenInAnOccuppiedSpace

	| board |
	board _ TerniLapilli new.
	board putXat: 2@2.

	self
		should: [ board putOat: 2@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Already marked'.
			self assert: (board at: 2@2) = #x.
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:45:08'!
test04NotOccuppiedPositionsAreEmptyByDefault

	| board |
	
	board _ TerniLapilli new.

	self assert: (board at: 2@2) = 'empty'! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:52:15'!
test05CanNotPlaceATokenOutOfTheBoard

	| board |
	
	board _ TerniLapilli new.

	self
		should: [ board putXat: 2@4 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'
		].
	
	self
		should: [ board putXat: 4@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:49:42'!
test06GameStartsWithXsTurn

	| board |

	board _ TerniLapilli new.
	
	self
		should: [ board putOat: 2@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (board at: 2@2) = 'empty'.
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:48:03'!
test07CanNotPlaceATokenXWhenItIsNotXsTurn

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:50:29'!
test08CanNotPlaceATokenOWhenItIsNotOsTurn

	| board |
	board _ TerniLapilli new.
	board putXat: 2@2.
	board putOat: 2@3.
	
	self
		should: [ board putOat: 2@1 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (board at: 2@2) = #x.
			self assert: (board at: 2@3) = #o.
			self assert: (board at: 2@1) = 'empty'.
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:53:18'!
test10XIsWinnerWhenPuttingThreeTokensInARow

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putOat: 2@1.
	
	board putXat: 1@2.
	board putOat: 2@2.
	
	board putXat: 1@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:11:23'!
test11XIsWinnerVertically

	| board |
	board _ TerniLapilli new.
	board putXat: 2@1.
	board putOat: 1@1.
	
	board putXat: 2@2.
	board putOat: 1@2.
	
	board putXat: 2@3.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 3@1.
	board putOat: 1@1.
	
	board putXat: 3@2.
	board putOat: 1@2.
	
	board putXat: 3@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:11:37'!
test12XIsWinnerHorizontally

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putOat: 1@2.
	
	board putXat: 2@1.
	board putOat: 2@2.
	
	board putXat: 3@1.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 1@2.
	board putOat: 1@1.
	
	board putXat: 2@2.
	board putOat: 2@1.
	
	board putXat: 3@2.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 1@3.
	board putOat: 1@1.
	
	board putXat: 2@3.
	board putOat: 2@1.
	
	board putXat: 3@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:12:01'!
test13XIsWinnerDiagonally

	| board |
	board _ TerniLapilli new.
	board putXat: 1@1.
	board putOat: 1@2.
	board putXat: 2@2.
	board putOat: 1@3.
	board putXat: 3@3.

	self assert: board xIsWinner.
	
	board _ TerniLapilli new.
	board putXat: 3@1.
	board putOat: 1@2.
	board putXat: 2@2.
	board putOat: 3@2.
	board putXat: 1@3.

	self assert: board xIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:12:58'!
test14OIsWinnerWhenPuttingThreeTokensInARow

	| board |

	board _ TerniLapilli new.

	board putXat: 1@1.
	board putOat: 3@1.
	
	board putXat: 1@2.
	board putOat: 3@2.
	
	board putXat: 2@2.
	board putOat: 3@3.

	self assert: board oIsWinner! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:21:23'!
test15CanNotPlayOnceGameIsOver

	| board |

	board _ TerniLapilli new.
	board putXat: 1@1.
	board putOat: 2@1.
	
	board putXat: 1@2.
	board putOat: 2@2.
	
	board putXat: 1@3.
	
	self
		should: [ board putOat: 3@2. ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Game has finished'
		].
	
	self
		should: [ board putXat: 3@2. ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Game has finished'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:17:46'!
test16CanNotPutMoreThanSixTokens

	| board |

	board _ self boardWithSixTokens.
	
	self
		should: [ board putXat: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'More than three equal marks are not allowed'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:18:18'!
test17SlideXAndWinGame

	| board |

	board _ self boardWithSixTokens. 
	
	board slideXFrom: 3@1 to: 2@2.

	self assert: (board at: 2@2) = #x.
	self assert: (board at: 3@1) = 'empty'.
	self assert: (board winnerIs: #x).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:56:27'!
test18SlideOAndWinGame

	| board |
	
	board _ self boardWithSixTokens.
	
	board slideXFrom: 3@3 to: 2@3.
	board slideOFrom: 2@1 to: 2@2.

	self assert: (board at: 2@2) = #o.
	self assert: (board at: 2@1) = 'empty'.
	self assert: (board winnerIs: #o).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:52:31'!
test19CantSlideXFromEmptyPosition

	| board |
	
	board _ self boardWithSixTokens.
	
	self
		should: [ board slideXFrom: 1@3 to: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide from an empty position'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:52:24'!
test20CantSlideXToOccupiedPosition

	| board |
	
	board _ self boardWithSixTokens.

	self
		should: [ board slideXFrom: 1@1 to: 1@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide to an occupied position'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:55:37'!
test21CantSlideOFromEmptyPositionNeitherToOccupiedPosition

	| board |
	
	board _ self boardWithSixTokens.
	
	board slideXFrom: 3@3 to: 2@3.
	
	self
		should: [ board slideOFrom: 2@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide from an empty position'
		].
	
	self
		should: [ board slideOFrom: 3@2 to: 2@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide to an occupied position'
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:55:53'!
test22CantSlideToOutOfRange

	| board |
	
	board _ self boardWithSixTokens.
		
	self
		should: [ board slideXFrom: 3@3 to: 3@4 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'.
			self assert: (board at: 3@3) = #x.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:24:43'!
test23OCantSlideOnXTurnToSlide

	| board |

	board _ self boardWithSixTokens.
	
	self
		should: [ board slideOFrom: 1@2 to: 2@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (board at: 1@2) = #o.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 12:00:57'!
test24XCantSlideOnOTurnToPut

	| board |
	
	board _ TerniLapilli new.

	board putXat: 1@1.
	board putOat: 2@1.
	board putXat: 3@1.
	board putOat: 1@2.
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 12:02:24'!
test25OCantSlideIfGameOver

	| board |

	board _ self boardWithSixTokens.
	
	board slideXFrom: 3@1 to: 2@2.
	
	self
		should: [ board slideOFrom: 1@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Game has finished'.
			self assert: (board at: 1@2) = #o.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 13:48:15'!
test26XCantSlideIfGameOver

	| board |
	
	board _ self boardWithSixTokens.
	
	board slideXFrom: 3@3 to: 2@3.
	board slideOFrom: 2@1 to: 2@2.

	self
		should: [ board slideXFrom: 1@1 to: 2@1 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Game has finished'.
			self assert: (board at: 1@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 12:09:33'!
test27XCantSlideToDistantPosition

	| board |
	
	board _ self boardWithSixTokens.
	
	self
		should: [ board slideXFrom: 1@1 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide that far'.
			self assert: (board at: 1@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:17:17'!
test28OCantSlideToDistantPosition

	| board |
	
	board _ self boardWithSixTokens.
	
	board slideXFrom: 1@1 to: 2@2.
	self
		should: [ board slideOFrom: 2@1 to: 2@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide that far'.
			self assert: (board at: 2@1) = #o.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:25:41'!
test29OCantSlideOnXTurnToPut

	| board |
	
	board _ TerniLapilli new.

	board putXat: 1@1.
	board putOat: 2@1.
	board putXat: 3@1.
	board putOat: 1@2.
	
	"     |     | x 
	   y |     | y
	   x | y  | x
	"	
	
	self
		should: [ board slideOFrom: 1@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (board at: 1@2) = #o.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:30:09'!
test30OCantSlideOnOTurnToPut

	| board |
	
	board _ TerniLapilli new.

	board putXat: 1@1.
	board putOat: 2@1.
	board putXat: 3@1.
	board putOat: 1@2.
	board putXat: 3@3.
	
	"     |     | x 
	   y |     | y
	   x | y  | x
	"	
	
	self
		should: [ board slideOFrom: 1@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Os turn to slide'.
			self assert: (board at: 1@2) = #o.
			self assert: (board at: 1@3) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:31:48'!
test31XCantSlideOnXTurnToPut

	| board |
	
	board _ TerniLapilli new.

	board putXat: 1@1.
	board putOat: 2@1.
	board putXat: 3@1.
	board putOat: 1@2.
	
	"     |     | x 
	   y |     | y
	   x | y  | x
	"	
	
	self
		should: [ board slideXFrom: 1@1 to: 2@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Xs turn to slide'.
			self assert: (board at: 1@1) = #x.
			self assert: (board at: 2@2) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:35:33'!
test32OCantPutOnXTurnToSlide

	| board |
	
	board _ self boardWithSixTokens.

	self
		should: [ board putOat: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (board at: 1@3) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:42:43'!
test33OCantPutOnOTurnToSlide

	| board |
	
	board _ self boardWithSixTokens.
	
	board slideXFrom: 3@3 to: 2@3.

	self
		should: [ board putOat: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'More than three equal marks are not allowed'.
			self assert: (board at: 1@3) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:43:10'!
test34XCantPutOnOTurnToSlide

	| board |
	
	board _ self boardWithSixTokens.
	
	board slideXFrom: 3@3 to: 2@3.

	self
		should: [ board putXat: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'It is not Xs turn'.
			self assert: (board at: 1@3) = 'empty'.
		].! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 13:40:45'!
assertValidPosition: aPosition

	((aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3)) ifFalse: [ self error: 'Out of range' ].! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 13:51:52'!
assertValidPutIn: aPosition 

	self assertValidPosition: aPosition.
	(self at: aPosition) = 'empty' ifFalse: [^ self error: 'Already marked'].! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 13:46:31'!
assertValidSlideFrom: anOriginPoint to: aDestinationPoint 

	self assertValidPosition: anOriginPoint.
	self assertValidPosition: aDestinationPoint.
	(self isValidSlidingDistanceFrom: anOriginPoint to: aDestinationPoint) ifFalse: [^ self error: 'Can not slide that far' ].
	(self at: aDestinationPoint) = 'empty' ifFalse: [^ self error: 'Can not slide to an occupied position'].
	(self at: anOriginPoint) = 'empty' ifTrue: [^ self error: 'Can not slide from an empty position'].
! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 13:22:09'!
at: aPosition

	^ board at: aPosition ifAbsent: 'empty'.! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 12:54:02'!
boardContainsThreeXTokens

	^ (board occurrencesOf: #x) = 3! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/22/2019 20:44:41'!
isValidSlidingDistanceFrom: anOriginPoint to: aDestinationPoint
	
	^ ((anOriginPoint x - aDestinationPoint x) abs < 2) and: ((anOriginPoint y - aDestinationPoint y) abs < 2).! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 13:54:48'!
threeDiagonallyContinuosWith: aToken

	^ (((self at: 1@1) = aToken) and: ((self at: 2@2) = aToken) and: ((self at: 3@3) = aToken))
		or: (((self at: 3@1) = aToken) and: ((self at: 2@2) = aToken) and: ((self at: 1@3) = aToken))
		! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 12:15:27'!
threeHorizontallyContinuosWith: aToken

	^ (((self at: 1@1) = aToken) and: ((self at: 2@1) = aToken) and: ((self at: 3@1) = aToken))
		or: (((self at: 1@2) = aToken) and: ((self at: 2@2) = aToken) and: ((self at: 3@2) = aToken))
		or: (((self at: 1@3) = aToken) and: ((self at: 2@3) = aToken) and: ((self at: 3@3) = aToken))
		! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 12:15:37'!
threeVerticallyContinuosWith: aToken

	^ (((self at: 1@1) = aToken) and: ((self at: 1@2) = aToken) and: ((self at: 1@3) = aToken))
		or: (((self at: 2@1) = aToken) and: ((self at: 2@2) = aToken) and: ((self at: 2@3) = aToken))
		or: (((self at: 3@1) = aToken) and: ((self at: 3@2) = aToken) and: ((self at: 3@3) = aToken))
		! !


!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/26/2019 13:47:16'!
pullFrom: anOriginPoint andPutIn: aDestinationPoint aToken: aToken 
	
	board removeKey: anOriginPoint.
	
	self at: aDestinationPoint put: aToken.! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/26/2019 12:57:05'!
pullOFrom: anOriginPoint andPutIn: aDestinationPoint

	self pullFrom: anOriginPoint andPutIn: aDestinationPoint aToken: #o! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/26/2019 12:57:28'!
pullXFrom: anOriginPoint andPutIn: aDestinationPoint

	self pullFrom: anOriginPoint andPutIn: aDestinationPoint aToken: #x ! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/26/2019 13:46:58'!
slideOFrom: anOriginPoint to: aDestinationPoint
	
	self assertValidSlideFrom: anOriginPoint to: aDestinationPoint.
	 
	state slideOFrom: anOriginPoint to: aDestinationPoint in: self! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'JR 5/26/2019 13:47:05'!
slideXFrom: anOriginPoint to: aDestinationPoint

	self assertValidSlideFrom: anOriginPoint to: aDestinationPoint.
	
	state slideXFrom: anOriginPoint to: aDestinationPoint in: self! !


!TerniLapilli methodsFor: 'putting' stamp: 'JR 5/26/2019 13:52:34'!
at: aPosition put: aToken

	board at: aPosition put: aToken.
	state changeTurnIn: self.
			! !

!TerniLapilli methodsFor: 'putting' stamp: 'JR 5/26/2019 13:52:11'!
putOat: aPosition
	
	self assertValidPutIn: aPosition.

	state putOat: aPosition in: self
! !

!TerniLapilli methodsFor: 'putting' stamp: 'JR 5/26/2019 13:52:15'!
putXat: aPosition

	self assertValidPutIn: aPosition.

	state putXat: aPosition in: self
! !


!TerniLapilli methodsFor: 'initialization' stamp: 'JR 5/26/2019 12:14:43'!
initialize

	board _ Dictionary new.
	state _ TerniLapilliXTurnToPut new.! !


!TerniLapilli methodsFor: 'winning' stamp: 'AB 5/26/2019 11:14:14'!
oIsWinner

	^ self winnerIs: #o! !

!TerniLapilli methodsFor: 'winning' stamp: 'JR 5/26/2019 12:15:44'!
winnerIs: aToken

	^ (self threeVerticallyContinuosWith: aToken)
		or: (self threeHorizontallyContinuosWith: aToken)
		or: (self threeDiagonallyContinuosWith: aToken)! !

!TerniLapilli methodsFor: 'winning' stamp: 'AB 5/20/2019 20:03:42'!
xIsWinner

	^ self winnerIs: #x! !


!TerniLapilli methodsFor: 'private' stamp: 'AB 5/26/2019 11:42:00'!
state: aState

	state _ aState! !


!classDefinition: #TerniLapilliState category: #TerniLapilli!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:45:59'!
putOat: aPosition in: aGame

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:46:08'!
putXat: aPosition in: aGame

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:46:23'!
slideOFrom: anOriginPoint to: aDestinationPoint in: aGame

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:46:25'!
slideXFrom: anOriginPoint to: aDestinationPoint in: aGame

	self subclassResponsibility ! !


!classDefinition: #TerniLapilliGameOver category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliGameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGameOver methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:16:15'!
putOat: aPosition in: aGame

	self error: 'Game has finished'! !

!TerniLapilliGameOver methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:16:03'!
putXat: aPosition in: aGame

	self error: 'Game has finished'! !

!TerniLapilliGameOver methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 12:01:59'!
slideOFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'Game has finished'! !

!TerniLapilliGameOver methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 12:02:47'!
slideXFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'Game has finished'! !


!classDefinition: #TerniLapilliOTurnSliding category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliOTurnSliding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliOTurnSliding methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:55:12'!
changeTurnIn: aGame

	(aGame oIsWinner) 
		ifTrue: [ aGame state: TerniLapilliGameOver new ] 
		ifFalse: [ aGame state: TerniLapilliXTurnSliding new ]! !

!TerniLapilliOTurnSliding methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:42:35'!
putOat: aPosition in: aGame

	self error: 'More than three equal marks are not allowed'! !

!TerniLapilliOTurnSliding methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:43:44'!
putXat: aPosition in: aGame

	self error: 'It is not Xs turn'! !

!TerniLapilliOTurnSliding methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:54:50'!
slideOFrom: anOriginPoint to: aDestinationPoint in: aGame

	aGame pullOFrom: anOriginPoint andPutIn: aDestinationPoint! !

!TerniLapilliOTurnSliding methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:58:50'!
slideXFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'It is not Xs turn'! !


!classDefinition: #TerniLapilliOTurnToPut category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliOTurnToPut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliOTurnToPut methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:54:16'!
changeTurnIn: aGame

	(aGame oIsWinner) 
		ifTrue: [ aGame state: TerniLapilliGameOver new ] 
		ifFalse: [
			(aGame boardContainsThreeXTokens) 
			ifTrue: [ aGame state: TerniLapilliXTurnSliding new ]
			ifFalse: [ aGame state: TerniLapilliXTurnToPut new ]
		]! !

!TerniLapilliOTurnToPut methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:42:10'!
putOat: aPosition in: aGame

	aGame at: aPosition put: #o! !

!TerniLapilliOTurnToPut methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:48:35'!
putXat: aPosition in: aGame

	self error: 'It is not Xs turn'! !

!TerniLapilliOTurnToPut methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:30:33'!
slideOFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'It is not Os turn to slide'! !

!TerniLapilliOTurnToPut methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 12:01:15'!
slideXFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'It is not Xs turn'! !


!classDefinition: #TerniLapilliXTurnSliding category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliXTurnSliding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliXTurnSliding methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:49:24'!
changeTurnIn: aGame

	(aGame xIsWinner) 
		ifTrue: [ aGame state: TerniLapilliGameOver new ] 
		ifFalse: [ aGame state: TerniLapilliOTurnSliding new ]! !

!TerniLapilliXTurnSliding methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:35:51'!
putOat: aPosition in: aGame

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnSliding methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 12:05:23'!
putXat: aPosition in: aGame

	self error: 'More than three equal marks are not allowed'! !

!TerniLapilliXTurnSliding methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:57:42'!
slideOFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnSliding methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:30:58'!
slideXFrom: anOriginPoint to: aDestinationPoint in: aGame

	aGame pullXFrom: anOriginPoint andPutIn: aDestinationPoint! !


!classDefinition: #TerniLapilliXTurnToPut category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliXTurnToPut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliXTurnToPut methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 11:51:46'!
changeTurnIn: aGame

	(aGame xIsWinner) 
		ifTrue: [ aGame state: TerniLapilliGameOver new ] 
		ifFalse: [ aGame state: TerniLapilliOTurnToPut new ]

	 ! !

!TerniLapilliXTurnToPut methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:47:13'!
putOat: aPosition in: aGame

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnToPut methodsFor: 'as yet unclassified' stamp: 'AB 5/26/2019 10:36:00'!
putXat: aPosition in: aGame

	aGame at: aPosition put: #x ! !

!TerniLapilliXTurnToPut methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:26:52'!
slideOFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnToPut methodsFor: 'as yet unclassified' stamp: 'JR 5/26/2019 12:32:11'!
slideXFrom: anOriginPoint to: aDestinationPoint in: aGame

	self error: 'It is not Xs turn to slide'! !
