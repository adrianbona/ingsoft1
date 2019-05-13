!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverFacingNorthAtOrigin marsRoverFacingWestAtOrigin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:31:01'!
assertThat: aMarsRover whenProcessing: aSequenceOfMovements isAt: aPosition andChecksOrientationWith: aMessage
	
	aMarsRover processMovements: aSequenceOfMovements.
	self assert: aMarsRover position equals: aPosition.
	self assert: (aMessage sendTo: aMarsRover).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:30:46'!
test01MovesForwardOneStepAndKeepsFacingNorth

	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'f' isAt: 0@1 andChecksOrientationWith: #facingNorth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:31:45'!
test02MovesBackwardsOneStepAndKeepsFacingNorth

	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'b' isAt: 0@-1 andChecksOrientationWith: #facingNorth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:32:12'!
test03RotatesLeftFacesWestAndRemainsInTheSamePosition
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'l' isAt: 0@0 andChecksOrientationWith: #facingWest.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:32:40'!
test04RotatesRightFacesEastAndRemainsInTheSamePosition
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'r' isAt: 0@0 andChecksOrientationWith: #facingEast.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:33:04'!
test05NoCommandKeepsPositionAndOrientationUnchanged
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: '' isAt: 0@0 andChecksOrientationWith: #facingNorth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:18:32'!
test06InvalidCommandRaisesErrorAndKeepsPositionAndOrientationUnchanged
	
	self should:
	[
		marsRoverFacingNorthAtOrigin processMovements: 'x'.
	]
	raise: Error
	withExceptionDo:
	[
		:anError | self assert: marsRoverFacingNorthAtOrigin position equals: 0@0. 
		self assert: marsRoverFacingNorthAtOrigin facingNorth.		
	].
		
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:33:39'!
test07MovesForwardTwoStepsAndKeepsFacingNorth
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'ff' isAt: 0@2 andChecksOrientationWith: #facingNorth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:34:07'!
test08RotatesLeftTwiceFacesSouthAndRemainsInTheSamePosition
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'll' isAt: 0@0 andChecksOrientationWith: #facingSouth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:34:35'!
test09RotatesRightTwiceFacesEastAndRemainsInTheSamePosition
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'rr' isAt: 0@0 andChecksOrientationWith: #facingSouth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:34:52'!
test10StartsFacingNorthRotatesLeftAndMovesForwardOneStep
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'lf' isAt: -1@0 andChecksOrientationWith: #facingWest.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:35:11'!
test11StartsFacingNorthRotatesRightAndMovesForwardOneStep
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'rf' isAt: 1@0 andChecksOrientationWith: #facingEast.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:35:47'!
test12StartsFacingWestRotatesLeftAndMovesForwardOneStep
	
	self assertThat: marsRoverFacingWestAtOrigin whenProcessing: 'lf' isAt: 0@-1 andChecksOrientationWith: #facingSouth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:37:17'!
test13RotatesLeftAndMovesBackwardsFourTimesReturningBackToInitialPosition
	
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'lb' isAt: 1@0 andChecksOrientationWith: #facingWest.
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'lb' isAt: 1@1 andChecksOrientationWith: #facingSouth.
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'lb' isAt: 0@1 andChecksOrientationWith: #facingEast.
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'lb' isAt: 0@0 andChecksOrientationWith: #facingNorth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:37:58'!
test14FullSpinsInBothDirections

	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'rrrr' isAt: 0@0 andChecksOrientationWith: #facingNorth.
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'llll' isAt: 0@0 andChecksOrientationWith: #facingNorth.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JR 5/12/2019 20:38:58'!
test15SquareTurnsInEveryDirectionReturningToInitialPosition

	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'frfrfrfr' isAt: 0@0 andChecksOrientationWith: #facingNorth.
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'flflflfl' isAt: 0@0 andChecksOrientationWith: #facingNorth.
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'lblblblb' isAt: 0@0 andChecksOrientationWith: #facingNorth.
	self assertThat: marsRoverFacingNorthAtOrigin whenProcessing: 'rbrbrbrb' isAt: 0@0 andChecksOrientationWith: #facingNorth.	! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'JR 5/12/2019 20:17:09'!
setUp	
	
	marsRoverFacingNorthAtOrigin _ MarsRover at: 0@0 facing: (MarsRoverCardinalOrientation at: $N).
	marsRoverFacingWestAtOrigin _ MarsRover at: 0@0 facing: (MarsRoverCardinalOrientation at: $O).! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position facing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'JR 5/10/2019 13:12:25'!
facing

	^ facing.! !

!MarsRover methodsFor: 'accessing' stamp: 'JR 5/10/2019 10:55:56'!
position

	^ position.! !


!MarsRover methodsFor: 'initialization' stamp: 'JR 5/10/2019 13:30:08'!
initializeAt: aPoint facing: aCardinalPoint
	
	position _ aPoint.
	facing _ aCardinalPoint.! !


!MarsRover methodsFor: 'movements' stamp: 'JR 5/11/2019 10:18:01'!
moveBackward

	facing moveBackwards: self.! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/11/2019 10:16:09'!
moveForward

	facing moveForward: self.! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/10/2019 16:40:42'!
moveHorizontallyOnePointBackwards

	position _ (position x - 1) @ (position y)! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/10/2019 16:40:49'!
moveHorizontallyOnePointForward

	position _ (position x + 1) @ (position y)! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/10/2019 16:21:12'!
moveVerticallyOnePointBackwards

	position _ (position x) @ (position y - 1)! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/10/2019 16:20:50'!
moveVerticallyOnePointForward

	position _ (position x) @ (position y + 1)! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/10/2019 16:54:49'!
processMovements: movementsSequence

		movementsSequence do: [ :aCommand | 
		aCommand = $l ifTrue: [self rotateLeft ] ifFalse: [
			aCommand = $r ifTrue: [self rotateRight ] ifFalse: [
				aCommand = $f ifTrue: [self moveForward ] ifFalse: [
					aCommand = $b ifTrue: [self moveBackward ] ifFalse: [
						self error: 'Invalid command'.
					]
				]
			]
		]
	]! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/11/2019 10:12:18'!
rotateLeft

	facing _ facing rotateNinetyDegreesLeft.! !

!MarsRover methodsFor: 'movements' stamp: 'JR 5/11/2019 10:12:46'!
rotateRight

	facing _ facing rotateNinetyDegreesRight.! !


!MarsRover methodsFor: 'orientation queries' stamp: 'JR 5/11/2019 10:58:18'!
facingEast

	^ facing isEast.! !

!MarsRover methodsFor: 'orientation queries' stamp: 'JR 5/11/2019 10:58:32'!
facingNorth

	^ facing isNorth.! !

!MarsRover methodsFor: 'orientation queries' stamp: 'JR 5/11/2019 10:58:43'!
facingSouth

	^ facing isSouth.! !

!MarsRover methodsFor: 'orientation queries' stamp: 'JR 5/11/2019 10:58:57'!
facingWest

	^ facing isWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'JR 5/10/2019 13:29:15'!
at: point facing: cardinalPoint

	^ self new initializeAt: point facing: cardinalPoint.! !


!classDefinition: #MarsRoverCardinalOrientation category: #MarsRover!
Object subclass: #MarsRoverCardinalOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCardinalOrientation methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:18'!
isEast

	^ false! !

!MarsRoverCardinalOrientation methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:32'!
isNorth

	^ false! !

!MarsRoverCardinalOrientation methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:43'!
isSouth

	^ false! !

!MarsRoverCardinalOrientation methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:57'!
isWest

	^ false! !


!MarsRoverCardinalOrientation methodsFor: 'movements' stamp: 'AB 5/13/2019 17:11:55'!
moveBackwards: aMarsRover

	self subclassResponsibility ! !

!MarsRoverCardinalOrientation methodsFor: 'movements' stamp: 'AB 5/13/2019 17:12:23'!
moveForward: aMarsRover

	self subclassResponsibility! !

!MarsRoverCardinalOrientation methodsFor: 'movements' stamp: 'AB 5/13/2019 17:12:44'!
rotateNinetyDegreesLeft

	self subclassResponsibility ! !

!MarsRoverCardinalOrientation methodsFor: 'movements' stamp: 'AB 5/13/2019 17:12:50'!
rotateNinetyDegreesRight

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCardinalOrientation class' category: #MarsRover!
MarsRoverCardinalOrientation class
	instanceVariableNames: ''!

!MarsRoverCardinalOrientation class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:31:29'!
at: aDirection

	^ (self subclasses
		detect: [ :cardinalSubClass |
			cardinalSubClass matchesValue: aDirection ]
		ifNone: [^self error: 'Wrong direction']) new.! !


!classDefinition: #East category: #MarsRover!
MarsRoverCardinalOrientation subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'movements' stamp: 'JR 5/11/2019 10:16:57'!
moveBackwards: aMarsRoverFacingEast

	aMarsRoverFacingEast moveHorizontallyOnePointBackwards.! !

!East methodsFor: 'movements' stamp: 'JR 5/11/2019 10:14:52'!
moveForward: aMarsRoverFacingEast

	aMarsRoverFacingEast moveHorizontallyOnePointForward.! !

!East methodsFor: 'movements' stamp: 'JR 5/11/2019 10:11:03'!
rotateNinetyDegreesLeft

	^ North new! !

!East methodsFor: 'movements' stamp: 'JR 5/11/2019 10:11:17'!
rotateNinetyDegreesRight

	^ South new! !


!East methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:18'!
isEast

	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:57:17'!
matchesValue: aDirection

	^ aDirection = $E.! !


!classDefinition: #North category: #MarsRover!
MarsRoverCardinalOrientation subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'movements' stamp: 'JR 5/11/2019 10:17:13'!
moveBackwards: aMarsRoverFacingNorth

	aMarsRoverFacingNorth moveVerticallyOnePointBackwards.! !

!North methodsFor: 'movements' stamp: 'JR 5/11/2019 10:14:04'!
moveForward: aMarsRoverFacingNorth

	aMarsRoverFacingNorth moveVerticallyOnePointForward.! !

!North methodsFor: 'movements' stamp: 'JR 5/11/2019 10:10:53'!
rotateNinetyDegreesLeft

	^ West new! !

!North methodsFor: 'movements' stamp: 'JR 5/11/2019 10:11:30'!
rotateNinetyDegreesRight

	^ East new! !


!North methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:32'!
isNorth

	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:52:49'!
matchesValue: aDirection

	^ aDirection = $N.! !


!classDefinition: #South category: #MarsRover!
MarsRoverCardinalOrientation subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'movements' stamp: 'JR 5/11/2019 10:17:30'!
moveBackwards: aMarsRoverFacingSouth

	aMarsRoverFacingSouth moveVerticallyOnePointForward.! !

!South methodsFor: 'movements' stamp: 'JR 5/11/2019 10:15:20'!
moveForward: aMarsRoverFacingSouth

	aMarsRoverFacingSouth moveVerticallyOnePointBackwards.! !

!South methodsFor: 'movements' stamp: 'JR 5/11/2019 10:10:48'!
rotateNinetyDegreesLeft

	^ East new! !

!South methodsFor: 'movements' stamp: 'JR 5/11/2019 10:11:40'!
rotateNinetyDegreesRight

	^ West new! !


!South methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:43'!
isSouth

	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:56:33'!
matchesValue: aDirection

	^ aDirection = $S! !


!classDefinition: #West category: #MarsRover!
MarsRoverCardinalOrientation subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'movements' stamp: 'JR 5/11/2019 10:17:45'!
moveBackwards: aMarsRoverFacingWest

	aMarsRoverFacingWest moveHorizontallyOnePointForward.! !

!West methodsFor: 'movements' stamp: 'JR 5/11/2019 10:15:39'!
moveForward: aMarsRoverFacingWest

	aMarsRoverFacingWest moveHorizontallyOnePointBackwards.! !

!West methodsFor: 'movements' stamp: 'JR 5/11/2019 10:10:39'!
rotateNinetyDegreesLeft

	^ South new! !

!West methodsFor: 'movements' stamp: 'JR 5/11/2019 10:23:10'!
rotateNinetyDegreesRight

	^ North new! !


!West methodsFor: 'orientation' stamp: 'JR 5/11/2019 10:58:57'!
isWest

	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:56:55'!
matchesValue: aDirection

	^ aDirection = $O.! !
