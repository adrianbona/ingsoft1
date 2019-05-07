!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:53:29'!
test01RobotAtX1Y2DoesNotMoveWhenCommandIsEmpty

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: ''.
	
	self assert: robot position = position.
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:28:44'!
test02RobotAtX1Y2MovesToX1Y3WhenMovingForward

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'f'.
	
	self assert: robot position = (1@3).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:28:38'!
test03RobotAtX1Y2RotatesToLeftAndKeepsPosition

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'l'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:46:57'!
test04RobotAtX1Y2MovesToX1Y1WhenMovingBackwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'b'.
	
	self assert: robot position = (1@1).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:56:35'!
test05RobotAtX1Y2RotatesToRightAndKeepsPosition

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'r'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsEast .! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:15:00'!
test06RobotAtX1Y2GivesErrorWhenReceivingUnknownCommand

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	self
		should: [robot followCommands: 'x']  
		raise: Error
		withExceptionDo: [ :anError |
			self assert: robot position = (1@2).
			self assert: robot orientation pointsNorth.
		]
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:15:48'!
test06RobotAtX1Y2RotatesAndGetsError

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	self
		should: [robot followCommands: 'rx']
		raise: Error
		withExceptionDo: [ :anError |
			self assert: robot position = (1@2).
			self assert: robot orientation pointsEast.
		]
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:16:13'!
test07RobotAtX1Y2MovesForwardAndGetsError

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	self
		should: [robot followCommands: 'fx']
		raise: Error
		withExceptionDo: [ :anError |
			self assert: robot position = (1@3).
			self assert: robot orientation pointsNorth.
		]
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:13:36'!
test08RobotAtX1Y2RotatesLeftAndRightAndKeepsRotation

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rl'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:25:04'!
test09RobotAtX1Y2MovesForwardsAndBackwardsAndKeepsPosition

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'fb'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:24:52'!
test10RobotAtX1Y2DoesWholeSpin

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rrrr'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.
	
	robot followCommands: 'llll'.
	
	self assert: robot position = (1@2).
	self assert: robot orientation pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:25:56'!
test11RobotAtX1Y2RotatesLeftAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'lf'.
	
	self assert: robot position = (0@2).
	self assert: robot orientation pointsWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:27:43'!
test12RobotAtX1Y2RotatesRightAndMovesForwards

	| position orientation robot |
	
	position _ 1@2.
	orientation _ North new.
	
	robot _ MarsRover at: position pointingTo: orientation.
	
	robot followCommands: 'rf'.
	
	self assert: robot position = (2@2).
	self assert: robot orientation pointsEast .! !


!classDefinition: #Cardinal category: #MarsRover!
Object subclass: #Cardinal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Cardinal methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:48:38'!
pointsEast

	^ false! !

!Cardinal methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:58:13'!
pointsNorth

	^ false! !

!Cardinal methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:54:52'!
pointsSouth

	^ false! !

!Cardinal methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:58:18'!
pointsWest

	^ false! !


!classDefinition: #East category: #MarsRover!
Cardinal subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:23:47'!
moveBackwards: aRobotFacingEast

	aRobotFacingEast position: (aRobotFacingEast position x - 1)@(aRobotFacingEast position y).! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:28:10'!
moveForward: aRobotFacingEast

	aRobotFacingEast position: (aRobotFacingEast position x + 1)@(aRobotFacingEast position y).! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:48:51'!
pointsEast

	^ true! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:26:44'!
rotateLeft

	^ North new! !

!East methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:55:19'!
rotateRight

	^ South new! !


!classDefinition: #North category: #MarsRover!
Cardinal subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:47:34'!
moveBackwards: aRobotFacingNorth

	aRobotFacingNorth position: (aRobotFacingNorth position x)@(aRobotFacingNorth position y - 1).! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:47:45'!
moveForward: aRobotFacingNorth

	aRobotFacingNorth position: (aRobotFacingNorth position x)@(aRobotFacingNorth position y + 1).! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:57:56'!
pointsNorth

	^ true! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:26:55'!
rotateLeft

	^ West new! !

!North methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:49:14'!
rotateRight

	^ East new! !


!classDefinition: #South category: #MarsRover!
Cardinal subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:54:45'!
pointsSouth

	^ true! !

!South methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:27:12'!
rotateLeft

	^ East new! !

!South methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:05:28'!
rotateRight

	^ West new! !


!classDefinition: #West category: #MarsRover!
Cardinal subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:26:39'!
moveForward: aRobotFacingWest

	aRobotFacingWest position: (aRobotFacingWest position x - 1)@(aRobotFacingWest position y).! !

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 19:57:10'!
pointsWest

	^ true! !

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:27:26'!
rotateLeft

	^ South new! !

!West methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 21:06:10'!
rotateRight

	^ North new! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'moving' stamp: 'AB 5/6/2019 21:09:22'!
followCommands: commands

	commands do: [ :aCommand | 
		aCommand = $l ifTrue: [self rotateLeft] ifFalse: [
			aCommand = $r ifTrue: [self rotateRight] ifFalse: [
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

!MarsRover methodsFor: 'moving' stamp: 'AB 5/6/2019 20:26:18'!
rotateLeft

	orientation _ orientation rotateLeft! !

!MarsRover methodsFor: 'moving' stamp: 'AB 5/6/2019 20:37:31'!
rotateRight

	orientation _ orientation rotateRight! !


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

!MarsRover methodsFor: 'status' stamp: 'AB 5/6/2019 20:41:28'!
position: aPosition

	position _ aPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'AB 5/6/2019 20:09:29'!
at: aPosition pointingTo: anOrientation

	^ (self new) initializeAt: aPosition pointingTo: anOrientation ! !
