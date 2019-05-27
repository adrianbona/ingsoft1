!classDefinition: #TerniLapilliTest category: #TerniLapilli!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:29:05'!
test01PutAnXAndCheckItsPosition

	| game |

	game _ TerniLapilli new.

	game putXat: 2@2.

	self assert: (game at: 2@2) = #x! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:30:59'!
test02PutXAndPutYInDifferentPositionsAndCheckCorrectness

	| game |

	game _ TerniLapilli new.
	
	game putXat: 2@1.
	game putOat: 2@2.

	self assert: (game at: 2@1) = #x.
	self assert: (game at: 2@2) = #o! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:31:03'!
test03CanNotPlaceATokenInAnOccuppiedSpace

	| game |

	game _ TerniLapilli new.

	game putXat: 2@2.

	self
		should: [ game putOat: 2@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Already marked'.
			self assert: (game at: 2@2) = #x.
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:31:11'!
test04NotOccuppiedPositionsAreEmptyByDefault

	| game |
	
	game _ TerniLapilli new.

	self assert: (game at: 2@2) = 'empty'! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:31:18'!
test05CanNotPlaceATokenOutOfTheBoard

	| game |
	
	game _ TerniLapilli new.

	self
		should: [ game putXat: 2@4 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'
		].
	
	self
		should: [ game putXat: 4@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:02:51'!
test06GameStartsWithXsTurn

	| game |

	game _ TerniLapilli new.
	
	self
		should: [ game putOat: 2@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: game isPlayingX.
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (game at: 2@2) = 'empty'.
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:02:43'!
test07CanNotPlaceATokenXWhenItIsNotXsTurn

	| game |

	game _ TerniLapilli new.

	game putXat: 2@2.
	
	self
		should: [ game putXat: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: game isPlayingO.
			self assert: anError messageText = 'It is not Xs turn'.
			self assert: (game at: 2@2) = #x.
			self assert: (game at: 2@3) = 'empty'.
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:02:37'!
test08CanNotPlaceATokenOWhenItIsNotOsTurn

	| game |

	game _ TerniLapilli new.

	game putXat: 2@2.
	game putOat: 2@3.
	
	self
		should: [ game putOat: 2@1 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: game isPlayingX.
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (game at: 2@2) = #x.
			self assert: (game at: 2@3) = #o.
			self assert: (game at: 2@1) = 'empty'.
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:07:20'!
test10XIsWinnerWhenPuttingThreeTokensInARow

	| game |

	game _ TerniLapilli new.

	game putXat: 1@1.
	game putOat: 2@1.
	
	game putXat: 1@2.
	game putOat: 2@2.
	
	game putXat: 1@3.

	self assert: game hasPlayerXWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:07:20'!
test11XIsWinnerVertically

	| game |

	game _ TerniLapilli new.

	game putXat: 2@1.
	game putOat: 1@1.
	
	game putXat: 2@2.
	game putOat: 1@2.
	
	game putXat: 2@3.

	self assert: game hasPlayerXWon.
	
	game _ TerniLapilli new.

	game putXat: 3@1.
	game putOat: 1@1.
	
	game putXat: 3@2.
	game putOat: 1@2.
	
	game putXat: 3@3.

	self assert: game hasPlayerXWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:07:20'!
test12XIsWinnerHorizontally

	| game |

	game _ TerniLapilli new.
	game putXat: 1@1.
	game putOat: 1@2.
	game putXat: 2@1.
	game putOat: 2@2.
	game putXat: 3@1.

	self assert: game hasPlayerXWon.
	
	game _ TerniLapilli new.
	game putXat: 1@2.
	game putOat: 1@1.
	game putXat: 2@2.
	game putOat: 2@1.
	game putXat: 3@2.

	self assert: game hasPlayerXWon.
	
	game _ TerniLapilli new.
	game putXat: 1@3.
	game putOat: 1@1.
	game putXat: 2@3.
	game putOat: 2@1.
	game putXat: 3@3.

	self assert: game hasPlayerXWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:07:19'!
test13XIsWinnerDiagonally

	| game |
	
	game _ TerniLapilli new.
	game putXat: 1@1.
	game putOat: 1@2.
	game putXat: 2@2.
	game putOat: 1@3.
	game putXat: 3@3.

	self assert: game hasPlayerXWon.
	
	game _ TerniLapilli new.
	game putXat: 3@1.
	game putOat: 1@2.
	game putXat: 2@2.
	game putOat: 3@2.
	game putXat: 1@3.

	self assert: game hasPlayerXWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:07:03'!
test14OIsWinnerWhenPuttingThreeTokensInARow

	| game |

	game _ TerniLapilli new.

	game putXat: 1@1.
	game putOat: 3@1.	
	game putXat: 1@2.
	game putOat: 3@2.
	game putXat: 2@2.
	game putOat: 3@3.

	self assert: game hasPlayerOWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:16:27'!
test15CanNotPlayOnceGameIsOver

	| game |

	game _ TerniLapilli new.
	
	game putXat: 1@1.
	game putOat: 2@1.	
	game putXat: 1@2.
	game putOat: 2@2.
	game putXat: 1@3.
	
	self
		should: [ game putOat: 3@2. ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: game hasPlayerXWon.
			self assert: anError messageText = 'Game has finished'
		].
	
	self
		should: [ game putXat: 3@2. ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: game hasPlayerXWon.
			self assert: anError messageText = 'Game has finished'
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:34:32'!
test16CanNotPutMoreThanSixTokens

	| game |

	game _ self boardWithSixTokens.
	
	self
		should: [ game putXat: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'More than three equal marks are not allowed'
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:18:06'!
test17SlideXAndWinGame

	| game |

	game _ self boardWithSixTokens. 

	game slideXFrom: 3@1 to: 2@2.

	self assert: game hasPlayerXWon.
	self assert: (game at: 2@2) = #x.
	self assert: (game at: 3@1) = 'empty'.
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:15:45'!
test18SlideOAndWinGame

	| game |
	
	game _ self boardWithSixTokens.
	
	game slideXFrom: 3@3 to: 2@3.
	game slideOFrom: 2@1 to: 2@2.

	self assert: game hasPlayerOWon.
	self assert: (game at: 2@2) = #o.
	self assert: (game at: 2@1) = 'empty'.
	self assert: (game winnerIs: #o).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:34:56'!
test19CantSlideXFromEmptyPosition

	| game |
	
	game _ self boardWithSixTokens.
	
	self
		should: [ game slideXFrom: 1@3 to: 2@3 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide from an empty position'
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:35:03'!
test20CantSlideXToOccupiedPosition

	| game |
	
	game _ self boardWithSixTokens.

	self
		should: [ game slideXFrom: 1@1 to: 1@2 ] 
 		raise: Error
		 withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide to an occupied position'
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:35:12'!
test21CantSlideOFromEmptyPositionNeitherToOccupiedPosition

	| game |
	
	game _ self boardWithSixTokens.
	
	game slideXFrom: 3@3 to: 2@3.
	
	self
		should: [ game slideOFrom: 2@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide from an empty position'
		].
	
	self
		should: [ game slideOFrom: 3@2 to: 2@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not slide to an occupied position'
		]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:35:20'!
test22CantSlideToOutOfRange

	| game |
	
	game _ self boardWithSixTokens.
		
	self
		should: [ game slideXFrom: 3@3 to: 3@4 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Out of range'.
			self assert: (game at: 3@3) = #x.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:02:10'!
test23OCantSlideOnXTurnToSlide

	| game |

	game _ self boardWithSixTokens.
	
	self
		should: [ game slideOFrom: 1@2 to: 2@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingX.
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (game at: 1@2) = #o.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:02:02'!
test24XCantSlideOnOTurnToPut

	| game |
	
	game _ TerniLapilli new.

	game putXat: 1@1.
	game putOat: 2@1.
	game putXat: 3@1.
	game putOat: 1@2.
	game putXat: 3@3.
	
	self
		should: [ game slideXFrom: 3@1 to: 2@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingO.
			self assert: anError messageText = 'It is not Xs turn'.
			self assert: (game at: 3@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:15:17'!
test25OCantSlideIfGameOver

	| game |

	game _ self boardWithSixTokens.
	
	game slideXFrom: 3@1 to: 2@2.
	
	self
		should: [ game slideOFrom: 1@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game hasPlayerXWon.
			self assert: anError messageText = 'Game has finished'.
			self assert: (game at: 1@2) = #o.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:14:59'!
test26XCantSlideIfGameOver

	| game |
	
	game _ self boardWithSixTokens.
	
	game slideXFrom: 3@3 to: 2@3.
	game slideOFrom: 2@1 to: 2@2.

	self
		should: [ game slideXFrom: 1@1 to: 2@1 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game hasPlayerOWon.
			self assert: anError messageText = 'Game has finished'.
			self assert: (game at: 1@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:01:43'!
test27XCantSlideToDistantPosition

	| game |
	
	game _ self boardWithSixTokens.
	
	self
		should: [ game slideXFrom: 1@1 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingX.
			self assert: anError messageText = 'Can not slide that far'.
			self assert: (game at: 1@1) = #x.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:01:34'!
test28OCantSlideToDistantPosition

	| game |
	
	game _ self boardWithSixTokens.
	
	game slideXFrom: 1@1 to: 2@2.
	
	self
		should: [ game slideOFrom: 2@1 to: 2@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingO.
			self assert: anError messageText = 'Can not slide that far'.
			self assert: (game at: 2@1) = #o.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:01:14'!
test29OCantSlideOnXTurnToPut

	| game |
	
	game _ TerniLapilli new.

	game putXat: 1@1.
	game putOat: 2@1.
	game putXat: 3@1.
	game putOat: 1@2.
	
	self
		should: [ game slideOFrom: 1@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingX.
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (game at: 1@2) = #o.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:01:04'!
test30OCantSlideOnOTurnToPut

	| game |
	
	game _ TerniLapilli new.

	game putXat: 1@1.
	game putOat: 2@1.
	game putXat: 3@1.
	game putOat: 1@2.
	game putXat: 3@3.
	
	self
		should: [ game slideOFrom: 1@2 to: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingO.
			self assert: anError messageText = 'It is not Os turn to slide'.
			self assert: (game at: 1@2) = #o.
			self assert: (game at: 1@3) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:00:57'!
test31XCantSlideOnXTurnToPut

	| game |
	
	game _ TerniLapilli new.

	game putXat: 1@1.
	game putOat: 2@1.
	game putXat: 3@1.
	game putOat: 1@2.

	self
		should: [ game slideXFrom: 1@1 to: 2@2 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingX.
			self assert: anError messageText = 'It is not Xs turn to slide'.
			self assert: (game at: 1@1) = #x.
			self assert: (game at: 2@2) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:00:39'!
test32OCantPutOnXTurnToSlide

	| game |
	
	game _ self boardWithSixTokens.

	self
		should: [ game putOat: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingX.
			self assert: anError messageText = 'It is not Os turn'.
			self assert: (game at: 1@3) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 12:37:03'!
test33OCantPutOnOTurnToSlide

	| game |
	
	game _ self boardWithSixTokens.
	
	game slideXFrom: 3@3 to: 2@3.

	self
		should: [ game putOat: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'More than three equal marks are not allowed'.
			self assert: (game at: 1@3) = 'empty'.
		].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'AB 5/27/2019 15:00:28'!
test34XCantPutOnOTurnToSlide

	| game |
	
	game _ self boardWithSixTokens.
	
	game slideXFrom: 3@3 to: 2@3.

	self
		should: [ game putXat: 1@3 ] 
 		raise: Error
		withExceptionDo: [ :anError |
			self assert: game isPlayingO.
			self assert: anError messageText = 'It is not Xs turn'.
			self assert: (game at: 1@3) = 'empty'.
		].! !


!TerniLapilliTest methodsFor: 'setUp' stamp: 'AB 5/27/2019 14:39:06'!
boardWithSixTokens

	"    |     | x 
	  y |     |  y
	  x | y  | x "

	| board |
	
	board _ TerniLapilli new.

	board putXat: 1@1.
	board putOat: 2@1.
	board putXat: 3@1.
	board putOat: 1@2.
	board putXat: 3@3.
	board putOat: 3@2.
	
	^ board.! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'validations' stamp: 'AB 5/27/2019 14:30:11'!
assertPositionIsInARange1To3: aPosition

	((aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3)) ifFalse: [ self error: 'Out of range' ].! !

!TerniLapilli methodsFor: 'validations' stamp: 'AB 5/27/2019 14:34:37'!
assertPositionsAreInRangeOriginIsOccupiedDestinationIsEmptyAndCanSlideFrom: anOriginPoint to: aDestinationPoint 

	self assertPositionIsInARange1To3: anOriginPoint.
	self assertPositionIsInARange1To3: aDestinationPoint.

	(self isDistanceValidForSlidingFrom: anOriginPoint to: aDestinationPoint) ifFalse: [^ self error: 'Can not slide that far' ].

	(self at: aDestinationPoint) = 'empty' ifFalse: [^ self error: 'Can not slide to an occupied position'].
	(self at: anOriginPoint) = 'empty' ifTrue: [^ self error: 'Can not slide from an empty position'].
! !

!TerniLapilli methodsFor: 'validations' stamp: 'AB 5/27/2019 14:31:24'!
assertPostionIsInRangeAndEmpty: aPosition 

	self assertPositionIsInARange1To3: aPosition.
	
	(self at: aPosition) = 'empty' ifFalse: [^ self error: 'Already marked']! !

!TerniLapilli methodsFor: 'validations' stamp: 'AB 5/27/2019 13:55:50'!
at: aPosition

	^ board at: aPosition ifAbsent: 'empty'! !

!TerniLapilli methodsFor: 'validations' stamp: 'JR 5/26/2019 12:54:02'!
boardContainsThreeXTokens

	^ (board occurrencesOf: #x) = 3! !

!TerniLapilli methodsFor: 'validations' stamp: 'AB 5/27/2019 14:35:03'!
isDistanceValidForSlidingFrom: anOriginPoint to: aDestinationPoint
	
	^ ((anOriginPoint x - aDestinationPoint x) abs < 2) 
		and: ((anOriginPoint y - aDestinationPoint y) abs < 2)! !

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

!TerniLapilli methodsFor: 'sliding movements' stamp: 'AB 5/27/2019 14:34:37'!
slideOFrom: anOriginPoint to: aDestinationPoint
	
	self assertPositionsAreInRangeOriginIsOccupiedDestinationIsEmptyAndCanSlideFrom: anOriginPoint to: aDestinationPoint.
	 
	state slideOFrom: anOriginPoint to: aDestinationPoint! !

!TerniLapilli methodsFor: 'sliding movements' stamp: 'AB 5/27/2019 14:34:37'!
slideXFrom: anOriginPoint to: aDestinationPoint

	self assertPositionsAreInRangeOriginIsOccupiedDestinationIsEmptyAndCanSlideFrom: anOriginPoint to: aDestinationPoint.
	
	state slideXFrom: anOriginPoint to: aDestinationPoint! !


!TerniLapilli methodsFor: 'putting' stamp: 'AB 5/27/2019 13:55:19'!
at: aPosition put: aToken

	board at: aPosition put: aToken.
	
	state changeTurn! !

!TerniLapilli methodsFor: 'putting' stamp: 'AB 5/27/2019 14:31:24'!
putOat: aPosition
	
	self assertPostionIsInRangeAndEmpty: aPosition.

	state putOat: aPosition! !

!TerniLapilli methodsFor: 'putting' stamp: 'AB 5/27/2019 14:31:24'!
putXat: aPosition

	self assertPostionIsInRangeAndEmpty: aPosition.

	state putXat: aPosition! !


!TerniLapilli methodsFor: 'initialization' stamp: 'AB 5/27/2019 13:46:27'!
initialize

	board _ Dictionary new.
	state _ (TerniLapilliXTurnToPut for: self).! !


!TerniLapilli methodsFor: 'winning' stamp: 'JR 5/26/2019 12:15:44'!
winnerIs: aToken

	^ (self threeVerticallyContinuosWith: aToken)
		or: (self threeHorizontallyContinuosWith: aToken)
		or: (self threeDiagonallyContinuosWith: aToken)! !


!TerniLapilli methodsFor: 'private' stamp: 'AB 5/26/2019 11:42:00'!
state: aState

	state _ aState! !


!TerniLapilli methodsFor: 'status' stamp: 'AB 5/27/2019 15:08:14'!
hasPlayerOWon

	^ state hasPlayerOWon! !

!TerniLapilli methodsFor: 'status' stamp: 'AB 5/27/2019 15:08:22'!
hasPlayerXWon

	^ state hasPlayerXWon! !

!TerniLapilli methodsFor: 'status' stamp: 'AB 5/27/2019 15:19:03'!
isOver

	^ state isOver! !

!TerniLapilli methodsFor: 'status' stamp: 'AB 5/27/2019 14:54:10'!
isPlayingO

	^ state isPlayingO! !

!TerniLapilli methodsFor: 'status' stamp: 'AB 5/27/2019 14:54:07'!
isPlayingX

	^ state isPlayingX! !

!TerniLapilli methodsFor: 'status' stamp: 'AB 5/27/2019 15:19:12'!
isTied

	^ state isTied! !


!classDefinition: #TerniLapilliState category: #TerniLapilli!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'AB 5/27/2019 13:33:08'!
initializeFor: aGame

	game _ aGame! !


!TerniLapilliState methodsFor: 'putting' stamp: 'AB 5/27/2019 13:48:40'!
putOat: aPosition

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'putting' stamp: 'AB 5/27/2019 13:48:45'!
putXat: aPosition

	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:49:05'!
slideOFrom: anOriginPoint to: aDestinationPoint

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:49:10'!
slideXFrom: anOriginPoint to: aDestinationPoint

	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'update' stamp: 'AB 5/27/2019 13:44:58'!
changeTurn

	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'status' stamp: 'AB 5/27/2019 15:10:14'!
hasPlayerOWon

	^ false! !

!TerniLapilliState methodsFor: 'status' stamp: 'AB 5/27/2019 15:09:43'!
hasPlayerXWon

	^ false! !

!TerniLapilliState methodsFor: 'status' stamp: 'AB 5/27/2019 15:05:28'!
isOver

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'status' stamp: 'AB 5/27/2019 14:54:25'!
isPlayingO

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'status' stamp: 'AB 5/27/2019 14:54:23'!
isPlayingX

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'status' stamp: 'AB 5/27/2019 15:05:25'!
isTied

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #TerniLapilli!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'initialization' stamp: 'AB 5/27/2019 13:47:15'!
for: aGame

	^ self new initializeFor: aGame! !


!classDefinition: #TerniLapilliGameOver category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliGameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGameOver methodsFor: 'putting' stamp: 'AB 5/27/2019 13:50:25'!
putOat: aPosition

	self error: 'Game has finished'! !

!TerniLapilliGameOver methodsFor: 'putting' stamp: 'AB 5/27/2019 13:50:29'!
putXat: aPosition

	self error: 'Game has finished'! !


!TerniLapilliGameOver methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:50:04'!
slideOFrom: anOriginPoint to: aDestinationPoint

	self error: 'Game has finished'! !

!TerniLapilliGameOver methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:50:00'!
slideXFrom: anOriginPoint to: aDestinationPoint

	self error: 'Game has finished'! !


!TerniLapilliGameOver methodsFor: 'status' stamp: 'AB 5/27/2019 15:09:30'!
hasPlayerOWon

	^ game winnerIs: #o! !

!TerniLapilliGameOver methodsFor: 'status' stamp: 'AB 5/27/2019 15:09:25'!
hasPlayerXWon

	^ game winnerIs: #x! !

!TerniLapilliGameOver methodsFor: 'status' stamp: 'AB 5/27/2019 15:04:01'!
isOver

	^ true! !

!TerniLapilliGameOver methodsFor: 'status' stamp: 'AB 5/27/2019 14:55:06'!
isPlayingO

	self error: 'Game has finished'! !

!TerniLapilliGameOver methodsFor: 'status' stamp: 'AB 5/27/2019 14:55:05'!
isPlayingX

	self error: 'Game has finished'! !

!TerniLapilliGameOver methodsFor: 'status' stamp: 'AB 5/27/2019 15:04:17'!
isTied

	^ false! !


!TerniLapilliGameOver methodsFor: 'update' stamp: 'AB 5/27/2019 13:45:22'!
changeTurn

	self error: 'Game has finished'! !


!classDefinition: #TerniLapilliOTurnSliding category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliOTurnSliding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliOTurnSliding methodsFor: 'putting' stamp: 'AB 5/27/2019 13:51:02'!
putOat: aPosition

	self error: 'More than three equal marks are not allowed'! !

!TerniLapilliOTurnSliding methodsFor: 'putting' stamp: 'AB 5/27/2019 13:51:06'!
putXat: aPosition

	self error: 'It is not Xs turn'! !


!TerniLapilliOTurnSliding methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:51:22'!
slideOFrom: anOriginPoint to: aDestinationPoint

	game pullOFrom: anOriginPoint andPutIn: aDestinationPoint! !

!TerniLapilliOTurnSliding methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:51:28'!
slideXFrom: anOriginPoint to: aDestinationPoint

	self error: 'It is not Xs turn'! !


!TerniLapilliOTurnSliding methodsFor: 'update' stamp: 'AB 5/27/2019 15:13:40'!
changeTurn

	(game winnerIs: #o)
		ifTrue: [ game state: (TerniLapilliGameOver for: game) ] 
		ifFalse: [ game state: (TerniLapilliXTurnSliding for: game) ]! !


!TerniLapilliOTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 15:04:35'!
isOver

	^ false! !

!TerniLapilliOTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 14:55:51'!
isPlayingO

	^ true! !

!TerniLapilliOTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 14:55:46'!
isPlayingX

	^ false! !

!TerniLapilliOTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 15:04:31'!
isTied

	^ true! !


!classDefinition: #TerniLapilliOTurnToPut category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliOTurnToPut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliOTurnToPut methodsFor: 'putting' stamp: 'AB 5/27/2019 13:52:17'!
putOat: aPosition

	game at: aPosition put: #o! !

!TerniLapilliOTurnToPut methodsFor: 'putting' stamp: 'AB 5/27/2019 13:52:23'!
putXat: aPosition

	self error: 'It is not Xs turn'! !


!TerniLapilliOTurnToPut methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:52:38'!
slideOFrom: anOriginPoint to: aDestinationPoint

	self error: 'It is not Os turn to slide'! !

!TerniLapilliOTurnToPut methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:52:43'!
slideXFrom: anOriginPoint to: aDestinationPoint

	self error: 'It is not Xs turn'! !


!TerniLapilliOTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 15:04:57'!
isOver

	^ false! !

!TerniLapilliOTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 14:56:21'!
isPlayingO

	^ true! !

!TerniLapilliOTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 14:56:15'!
isPlayingX

	^ false! !

!TerniLapilliOTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 15:04:52'!
isTied

	^ true! !


!TerniLapilliOTurnToPut methodsFor: 'update' stamp: 'AB 5/27/2019 15:13:28'!
changeTurn

	(game winnerIs: #o)
		ifTrue: [ game state: (TerniLapilliGameOver for: game) ] 
		ifFalse: [
			(game boardContainsThreeXTokens) 
			ifTrue: [ game state: (TerniLapilliXTurnSliding for: game) ]
			ifFalse: [ game state: (TerniLapilliXTurnToPut for: game) ]
		]! !


!classDefinition: #TerniLapilliXTurnSliding category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliXTurnSliding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliXTurnSliding methodsFor: 'putting' stamp: 'AB 5/27/2019 13:53:03'!
putOat: aPosition

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnSliding methodsFor: 'putting' stamp: 'AB 5/27/2019 13:53:08'!
putXat: aPosition

	self error: 'More than three equal marks are not allowed'! !


!TerniLapilliXTurnSliding methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:53:19'!
slideOFrom: anOriginPoint to: aDestinationPoint

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnSliding methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:53:27'!
slideXFrom: anOriginPoint to: aDestinationPoint

	game pullXFrom: anOriginPoint andPutIn: aDestinationPoint! !


!TerniLapilliXTurnSliding methodsFor: 'update' stamp: 'AB 5/27/2019 15:13:10'!
changeTurn

	(game winnerIs: #x)
		ifTrue: [ game state: (TerniLapilliGameOver for: game) ] 
		ifFalse: [ game state: (TerniLapilliOTurnSliding for: game) ]! !


!TerniLapilliXTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 15:05:06'!
isOver

	^ false! !

!TerniLapilliXTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 14:56:52'!
isPlayingO

	^ false! !

!TerniLapilliXTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 14:56:47'!
isPlayingX

	^ true! !

!TerniLapilliXTurnSliding methodsFor: 'status' stamp: 'AB 5/27/2019 15:05:02'!
isTied

	^ true! !


!classDefinition: #TerniLapilliXTurnToPut category: #TerniLapilli!
TerniLapilliState subclass: #TerniLapilliXTurnToPut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliXTurnToPut methodsFor: 'putting' stamp: 'AB 5/27/2019 13:53:41'!
putOat: aPosition

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnToPut methodsFor: 'putting' stamp: 'AB 5/27/2019 13:53:48'!
putXat: aPosition

	game at: aPosition put: #x ! !


!TerniLapilliXTurnToPut methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:54:00'!
slideOFrom: anOriginPoint to: aDestinationPoint

	self error: 'It is not Os turn'! !

!TerniLapilliXTurnToPut methodsFor: 'sliding' stamp: 'AB 5/27/2019 13:54:05'!
slideXFrom: anOriginPoint to: aDestinationPoint

	self error: 'It is not Xs turn to slide'! !


!TerniLapilliXTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 15:05:15'!
isOver

	^ false! !

!TerniLapilliXTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 14:57:19'!
isPlayingO

	^ false! !

!TerniLapilliXTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 14:57:14'!
isPlayingX

	^ true! !

!TerniLapilliXTurnToPut methodsFor: 'status' stamp: 'AB 5/27/2019 15:05:11'!
isTied

	^ true! !


!TerniLapilliXTurnToPut methodsFor: 'update' stamp: 'AB 5/27/2019 15:12:47'!
changeTurn

	(game winnerIs: #x) 
		ifTrue: [ game state: (TerniLapilliGameOver for: game) ] 
		ifFalse: [ game state: (TerniLapilliOTurnToPut for: game) ]

	 ! !
