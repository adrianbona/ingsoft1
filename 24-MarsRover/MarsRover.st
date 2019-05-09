!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:31:59'!
test01RobotAtX1Y2DoesNotMoveWhenCommandIsEmpty

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: ''.
	
	self assert: robot position = position.
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:34:47'!
test02RobotAtX1Y2FacingNorthMovesToX1Y3WhenMovingForward

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'f'.
	
	self assert: robot position = (1@3).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:34:50'!
test03RobotAtX1Y2FacingNorthRotatesLeftAndKeepsSamePosition

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'l'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:34:54'!
test04RobotAtX1Y2FacingNorthMovesToX1Y1WhenMovingBackwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'b'.
	
	self assert: robot position = (1@1).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:34:58'!
test05RobotAtX1Y2FacingNorthRotatesRightAndKeepsSamePosition

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'r'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsEast.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:35:02'!
test06RobotReturnsErrorWhenReceivingUnknownCommand

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	self
		should: [robot followCommands: 'x']  
		raise: Error
		withExceptionDo: [ :anError |
			self assert: robot position = (1@2).
			self assert: robot orientation pointsNorth.
		]
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:35:09'!
test07RobotAtX1Y2FacingNorthMovesForwardAndGetsError

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	self
		should: [robot followCommands: 'fx']
		raise: Error
		withExceptionDo: [ :anError |
			self assert: robot position = (1@3).
			self assert: robot orientation pointsNorth.
		]
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:35:13'!
test08RobotAtX1Y2FacingNorthRotatesAndGetsError

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	self
		should: [robot followCommands: 'rx']
		raise: Error
		withExceptionDo: [ :anError |
			self assert: robot position = (1@2).
			self assert: robot orientation pointsEast.
		]
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:35:17'!
test09RobotAtX1Y2FacingNorthRotatesLeftAndRightAndKeepsSameRotation

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rl'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:35:21'!
test10RobotAtX1Y2FacingNorthMovesForwardAndBackwardsAndKeepsSamePosition

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'fb'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:35:25'!
test11RobotAtX1Y2RotatesLeftAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'lf'.
	
	self assert: robot position = (0@2).
	self assert: robot orientation pointsWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:36:30'!
test12RobotAtX1Y2RotatesRightAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rf'.
	
	self assert: robot position = (2@2).
	self assert: robot orientation pointsEast.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:36:39'!
test13RobotAtX1Y2FacingSouthRotatesLeftAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'S'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'lf'.
	
	self assert: robot position = (2@2).
	self assert: robot orientation pointsEast.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:36:44'!
test14RobotAtX1Y2FacingSouthRotatesRightAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'S'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rf'.
	
	self assert: robot position = (0@2).
	self assert: robot orientation pointsWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:36:50'!
test15RobotAtX1Y2FacingWestRotatesLeftAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'O'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'lf'.
	
	self assert: robot position = (1@1).
	self assert: robot orientation pointsSouth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:36:56'!
test16RobotAtX1Y2FacingWestRotatesRightAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'O'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rf'.
	
	self assert: robot position = (1@3).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:37:32'!
test17RobotAtX1Y2DoesWholeSpin

	| position orientation robot |
	
	position _ 1@2.
	orientation _ CardinalPoint at: 'N'.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rrrr'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.
	
	robot followCommands: 'llll'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.! !


!classDefinition: #CardinalPoint category: #MarsRover!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:48:38'!
pointsEast

	^ false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:58:13'!
pointsNorth

	^ false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:54:52'!
pointsSouth

	^ false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:58:18'!
pointsWest

	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: #MarsRover!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:31:29'!
at: aDirection

	^ (self subclasses
		detect: [ :cardinalSubClass |
			cardinalSubClass matchesValue: aDirection ]
		ifNone: [^self error: 'Wrong direction']) new.! !


!classDefinition: #East category: #MarsRover!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:09:21'!
moveBackwards: aRobotFacingEast

	aRobotFacingEast moveHorizontallyOnePointBackwards! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:09:18'!
moveForward: aRobotFacingEast

	aRobotFacingEast moveHorizontallyOnePointForward! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:48:51'!
pointsEast

	^ true! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:23'!
rotateNinetyDegreesLeft

	^ North new! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:39'!
rotateNinetyDegreesRight

	^ South new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:33:08'!
matchesValue: aDirection

	^ aDirection = 'E'! !


!classDefinition: #North category: #MarsRover!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:09:37'!
moveBackwards: aRobotFacingNorth

	aRobotFacingNorth moveVerticallyOnePointBackwards! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:09:51'!
moveForward: aRobotFacingNorth

	aRobotFacingNorth moveVerticallyOnePointForward! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:57:56'!
pointsNorth

	^ true! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:23'!
rotateNinetyDegreesLeft

	^ West new! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:39'!
rotateNinetyDegreesRight

	^ East new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:33:14'!
matchesValue: aDirection

	^ aDirection = 'N'! !


!classDefinition: #South category: #MarsRover!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:38:39'!
moveForward: aRobotFacingWest

	aRobotFacingWest moveVerticallyOnePointBackwards ! !

!South methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:54:45'!
pointsSouth

	^ true! !

!South methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:23'!
rotateNinetyDegreesLeft

	^ East new! !

!South methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:39'!
rotateNinetyDegreesRight

	^ West new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:33:21'!
matchesValue: aDirection

	^ aDirection = 'S'! !


!classDefinition: #West category: #MarsRover!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:10:19'!
moveForward: aRobotFacingWest

	aRobotFacingWest moveHorizontallyOnePointBackwards ! !

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:57:10'!
pointsWest

	^ true! !

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:23'!
rotateNinetyDegreesLeft

	^ South new! !

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/7/2019 00:16:39'!
rotateNinetyDegreesRight

	^ North new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 14:34:02'!
matchesValue: aDirection

	^ aDirection = 'O'! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'moving' stamp: 'AB 5/7/2019 00:16:39'!
followCommands: commands

	commands do: [ :aCommand | 
		aCommand = $l ifTrue: [self rotateNinetyDegreesLeft] ifFalse: [
			aCommand = $r ifTrue: [self rotateNinetyDegreesRight] ifFalse: [
				aCommand = $f ifTrue: [self moveForward] ifFalse: [
					aCommand = $b ifTrue: [self moveBackwards] ifFalse: [
						self error: 'Invalid command'.
					]
				]
			]
		]
	]! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/6/2019 20:37:47'!
moveBackwards

	self orientation moveBackwards: self! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/6/2019 20:36:37'!
moveForward

	self orientation moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/7/2019 00:12:52'!
moveHorizontallyOnePointBackwards

	position _ (position x - 1) @ position y! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/7/2019 00:12:45'!
moveHorizontallyOnePointForward

	position _ (position x + 1) @ position y! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/7/2019 00:12:38'!
moveVerticallyOnePointBackwards

	position _ position x @ (position y - 1)! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/7/2019 00:12:32'!
moveVerticallyOnePointForward

	position _ position x @ (position y + 1)! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/7/2019 00:16:23'!
rotateNinetyDegreesLeft

	orientation _ orientation rotateNinetyDegreesLeft! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/7/2019 00:16:40'!
rotateNinetyDegreesRight

	orientation _ orientation rotateNinetyDegreesRight! !


!MarsRover methodsFor: 'initialization' stamp: 'AB 5/6/2019 20:45:35'!
initializeAt: aPosition pointingTo: anOrientation

	position _ aPosition.
	orientation _ anOrientation.! !


!MarsRover methodsFor: 'status' stamp: 'AB 5/6/2019 20:10:03'!
orientation

	^ orientation ! !

!MarsRover methodsFor: 'status' stamp: 'AB 5/6/2019 20:41:46'!
orientation: anOrientation

	orientation _ anOrientation ! !

!MarsRover methodsFor: 'status' stamp: 'AB 5/6/2019 20:09:58'!
position

	^ position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:09:29'!
at: aPosition pointingTo: anOrientation

	^ (self new) initializeAt: aPosition pointingTo: anOrientation ! !
