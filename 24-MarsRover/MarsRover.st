!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:53:23'!
test01
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'f'.
	self assert: marsRover position equals: 0@1.
	self assert: marsRover facingNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:39:48'!
test02
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'b'.
	self assert: marsRover position equals: 0@-1.
	self assert: marsRover facingNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:39:53'!
test03
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'l'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:39:57'!
test04
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'r'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingEast.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:01'!
test05
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: ''.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:06'!
test06
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	self should:
	[
		marsRover processMovements: 'x'.
	]
	raise: Error
	withExceptionDo:
	[
		:anError | self assert: marsRover position equals: 0@0. 
		self assert: marsRover facingNorth.		
	].
		
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:10'!
test07
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'ff'.
	self assert: marsRover position equals: 0@2.
	self assert: marsRover facingNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:14'!
test08
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'll'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingSouth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:18'!
test09
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'rr'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingSouth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:22'!
test10
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'lf'.
	self assert: marsRover position equals: -1@0.
	self assert: marsRover facingWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:26'!
test11
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'rf'.
	self assert: marsRover position equals: 1@0.
	self assert: marsRover facingEast.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:29'!
test12
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $O).
	marsRover processMovements: 'lf'.
	self assert: marsRover position equals: 0@-1.
	self assert: marsRover facingSouth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:48'!
test13
	
	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'lb'.
	self assert: marsRover position equals: 1@0.
	self assert: marsRover facingWest.
	
	marsRover processMovements: 'lb'.
	self assert: marsRover position equals: 1@1.
	self assert: marsRover facingSouth.
	
	marsRover processMovements: 'lb'.
	self assert: marsRover position equals: 0@1.
	self assert: marsRover facingEast.
	
	marsRover processMovements: 'lb'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:40:55'!
test14

	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'rrrr'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.
	
	marsRover processMovements: 'llll'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:41:07'!
test15

	| marsRover |
	
	marsRover _ MarsRover at: 0@0 facing: (CardinalPoint at: $N).
	marsRover processMovements: 'frfrfrfr'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.
	
	marsRover processMovements: 'flflflfl'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.
	
	marsRover processMovements: 'lblblblb'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.
	
	marsRover processMovements: 'rbrbrbrb'.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover facingNorth.
	! !


!classDefinition: #CardinalPoint category: #MarsRover!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:18'!
isEast

	^ false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:32'!
isNorth

	^ false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:43'!
isSouth

	^ false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:57'!
isWest

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

!East methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:18'!
isEast

	^ true.! !

!East methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:16:57'!
moveBackwards: aMarsRoverFacingEast

	aMarsRoverFacingEast moveHorizontallyOnePointBackwards.! !

!East methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:14:52'!
moveForward: aMarsRoverFacingEast

	aMarsRoverFacingEast moveHorizontallyOnePointForward.! !

!East methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:11:03'!
rotateNinetyDegreesLeft

	^ North new! !

!East methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:11:17'!
rotateNinetyDegreesRight

	^ South new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:57:17'!
matchesValue: aDirection

	^ aDirection = $E.! !


!classDefinition: #North category: #MarsRover!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:32'!
isNorth

	^ true.! !

!North methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:17:13'!
moveBackwards: aMarsRoverFacingNorth

	aMarsRoverFacingNorth moveVerticallyOnePointBackwards.! !

!North methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:14:04'!
moveForward: aMarsRoverFacingNorth

	aMarsRoverFacingNorth moveVerticallyOnePointForward.! !

!North methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:10:53'!
rotateNinetyDegreesLeft

	^ West new! !

!North methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:11:30'!
rotateNinetyDegreesRight

	^ East new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:52:49'!
matchesValue: aDirection

	^ aDirection = $N.! !


!classDefinition: #South category: #MarsRover!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:43'!
isSouth

	^ true.! !

!South methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:17:30'!
moveBackwards: aMarsRoverFacingSouth

	aMarsRoverFacingSouth moveVerticallyOnePointForward.! !

!South methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:15:20'!
moveForward: aMarsRoverFacingSouth

	aMarsRoverFacingSouth moveVerticallyOnePointBackwards.! !

!South methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:10:48'!
rotateNinetyDegreesLeft

	^ East new! !

!South methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:11:40'!
rotateNinetyDegreesRight

	^ West new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:56:33'!
matchesValue: aDirection

	^ aDirection = $S! !


!classDefinition: #West category: #MarsRover!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:58:57'!
isWest

	^ true.! !

!West methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:17:45'!
moveBackwards: aMarsRoverFacingWest

	aMarsRoverFacingWest moveHorizontallyOnePointForward.! !

!West methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:15:39'!
moveForward: aMarsRoverFacingWest

	aMarsRoverFacingWest moveHorizontallyOnePointBackwards.! !

!West methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:10:39'!
rotateNinetyDegreesLeft

	^ South new! !

!West methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 10:23:10'!
rotateNinetyDegreesRight

	^ North new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'JR 5/11/2019 09:56:55'!
matchesValue: aDirection

	^ aDirection = $O.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position facing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

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


!MarsRover methodsFor: 'initialization' stamp: 'JR 5/10/2019 13:30:08'!
initializeAt: aPoint facing: aCardinalPoint
	
	position _ aPoint.
	facing _ aCardinalPoint.! !


!MarsRover methodsFor: 'accessing' stamp: 'JR 5/10/2019 13:12:25'!
facing

	^ facing.! !

!MarsRover methodsFor: 'accessing' stamp: 'JR 5/10/2019 10:55:56'!
position

	^ position.! !


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
