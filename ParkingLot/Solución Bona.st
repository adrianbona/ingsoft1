!classDefinition: #ParkingLotTest category: #'ISW1-2019-1C-Parcial'!
TestCase subclass: #ParkingLotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 16:32:35'!
test01CanNotCreateAParkingLotWithCeroOrLessLots

	self
		should: [ ParkingLot with: 0 and: self defaultPriceList ]
		raise: Error
		withMessageText: ParkingLot invalidNumberOfLotsErrorDescription ! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 16:32:41'!
test02CanNotCreateAParkingLotWithNoIntegerNumberOfLots

	self
		should: [ ParkingLot with: 1.5 and: self defaultPriceList ]
		raise: Error
		withMessageText: ParkingLot numberOfLotsMustBeIntegerErrorDescription ! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 16:33:00'!
test03WhenAParkingLotIsCreatedWithEvenSlotsAllSlotsEmpty

	| parkingLotSize parkingLot |
	
	parkingLotSize := 10.
	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	self assert: parkingLotSize equals: parkingLot freeSlots size ! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 16:33:23'!
test04WhenAParkingLotIsCreatedWithOddSlotsOneIsReservedAndTheRestAreEmpty

	| parkingLotSize parkingLot |
	
	parkingLotSize := 11.

	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	self assert: parkingLotSize -1 equals: parkingLot freeSlots size.
	self assert: 1 equals: parkingLot reservedSlots size! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 16:40:15'!
test05ParkingAVehicleReducesFreeSlotsByOne

	| parkingLotSize parkingLot |
	
	parkingLotSize := 10.
	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	parkingLot receive: #car.
	
	self assert: parkingLotSize - 1 equals: parkingLot freeSlots size.
	self assert: 1 equals: parkingLot occupiedSlots size
! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 16:40:56'!
test06WhenAVehicleLeavesTheEmptySlotsIsAugmentedByOne

	| parkingLotSize parkingLot parkedSlot |
	
	parkingLotSize := 10.
	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	parkedSlot := parkingLot receive: #bike.
	parkingLot release: parkedSlot.

	self assert: parkingLotSize equals: parkingLot freeSlots size.
	self assert: parkingLot occupiedSlots isEmpty! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:30:01'!
test07CanNotReleaseASlotNotIncludedInParkingLot

	| parkingLotSize parkingLot |
	
	parkingLotSize := 10.
	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	self 
		should: [ parkingLot release: Slot new ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ParkingLot slotNotInParkingLotErrorDescription equals: anError messageText.
			self assert: parkingLotSize equals: parkingLot freeSlots size ]! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:29:55'!
test08CanNotParkAVehicleInTheBoosSlot

	| parkingLotSize parkingLot |
	
	parkingLotSize := 11.

	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	self 
		should: [ (parkingLot bossSlotIfNone: [ self fail ]) receive: #car ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Slot canNotParkInSlotWhenReservedErrorDescription equals: anError messageText.
			self assert: parkingLot occupiedSlots isEmpty ]! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:29:50'!
test09ThereIsNoBoosSlotWhenNumberOfLotsIsEven

	| parkingLotSize parkingLot |
	
	parkingLotSize := 10.

	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	parkingLot bossSlotIfNone: [ ^self ].
	self failWith: 'There should not be a boos slot'! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:29:45'!
test10CanNotParkIfFull

	| parkingLotSize parkingLot |
	
	parkingLotSize := 2.
	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	parkingLot receive: #car.
	parkingLot receive: #bike.
	
	self 
		should: [ parkingLot receive: #car ]
		raise: Error
		withMessageText: ParkingLot canNotParkIsFullErrorDescription 
! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:29:40'!
test11CanNotRealeaseAnEmptyLot

	| parkingLotSize parkingLot |
	
	parkingLotSize := 2.
	parkingLot := ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	self 
		should: [ parkingLot release: parkingLot freeSlots anyOne ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: ParkingLot canNotReleaseAnEmptySlotErrorDescription equals: anError messageText.
			self assert: parkingLotSize equals: parkingLot freeSlots size ].
! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:30:51'!
test12CanGetTheTotalParked

	| parkingLot priceList |

	priceList := self defaultPriceList.
	parkingLot := ParkingLot with: 10 and: priceList.
	
	parkingLot receive: #car.
	parkingLot receive: #car.
	parkingLot receive: #bike.

	self assert: ( (priceList at: #car) * 2) + (priceList at: #bike) equals: parkingLot totalParked! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:31:14'!
test13ReservedSlotDoesNotAddToTalParked

	| parkingLot priceList |

	priceList := self defaultPriceList.
	parkingLot := ParkingLot with: 11 and: priceList.

	parkingLot receive: #car.
	parkingLot receive: #car.
	parkingLot receive: #bike.

	self assert: ((priceList at: #car) * 2) + (priceList at: #bike) equals: parkingLot totalParked! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:32:16'!
test14CanNotCalculateTotalParkedWithUnknowVehicleType

	| parkingLot priceList |

	priceList := self defaultPriceList.
	parkingLot := ParkingLot with: 10 and: priceList.

	parkingLot receive: #unknowVehicleType.
	
	self
		should: [ parkingLot totalParked ]
		raise: Error
		withMessageText: ParkingLot unknowVehicleTypeErrorDescription ! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:32:24'!
test15CanGetTheTotalCarsParked

	| parkingLot priceList |

	priceList := self defaultPriceList.
	parkingLot := ParkingLot with: 10 and: priceList.

	parkingLot receive: #car.
	parkingLot receive: #car.
	parkingLot receive: #bike.
	
	self assert: (priceList at: #car)*2 equals: parkingLot totalCarsParked ! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:32:31'!
test16CanGetTheTotalBikeParked

	| parkingLot priceList |

	priceList := self defaultPriceList.
	parkingLot := ParkingLot with: 10 and: priceList.

	parkingLot receive: #bike.
	parkingLot receive: #bike.
	parkingLot receive: #car.
	
	self assert: (priceList at: #bike)*2 equals: parkingLot totalBikesParked ! !


!ParkingLotTest methodsFor: 'price list' stamp: 'HAW 4/24/2019 11:13:24'!
defaultPriceList
	
	^Dictionary new
		at: #car put: 100*peso;
		at: #bike put: 50*peso;
		yourself ! !


!classDefinition: #SlotTest category: #'ISW1-2019-1C-Parcial'!
TestCase subclass: #SlotTest
	instanceVariableNames: 'number state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 19:36:47'!
test01NewSlotsAreEmpty

	self assert: Slot new isEmpty
	
! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 19:38:09'!
test02ParkingAVehicleMakesTheSlotOccupied

	| slot |
	
	slot := Slot new.
	slot receive: #car.
	
	self assert: slot isOccupied.
	self deny: slot isEmpty! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:53'!
test03CanReserveASlot

	| slot |
	
	slot := Slot new.
	slot reserve.
	
	self assert: slot isReserved.
	self deny: slot isOccupied.
	self deny: slot isEmpty! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:48'!
test04CanNotParkInAnOccupiedSlot

	| slot |
	
	slot := Slot new.
	slot receive: #car.
	
	self 
		should: [ slot receive: #car ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Slot canNotParkInSlotWhenOccupiedErrorDescription! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:42'!
test05CanNotParkInAReservedSlot

	| slot |
	
	slot := Slot new.
	slot reserve.
	
	self 
		should: [ slot receive: #car ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert:  Slot canNotParkInSlotWhenReservedErrorDescription equals: anError messageText.
			self assert: slot isReserved ]! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:29'!
test06CanNotReleaseAnEmptySlot

	| slot |
	
	slot := Slot new.
	
	self 
		should: [ slot release ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert:  Slot canNotLeaveFromEmptySlotErrorDescription equals: anError messageText.
			self assert: slot isEmpty ]! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:24'!
test07CanNotReleaseAReservedSlot

	| slot |
	
	slot := Slot new.
	slot reserve.
	
	self 
		should: [ slot release ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Slot canNotLeaveFromReservedSlotErrorDescription equals: anError messageText.
			self assert: slot isReserved ]! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:18'!
test08CanNotReserveAnOccupiedSlot

	| slot |
	
	slot := Slot new.
	slot receive: #car.
	
	self 
		should: [ slot reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Slot canNotReserveAnOccupiedSlotErrorDescription equals: anError messageText.
			self assert: slot isOccupied ]! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:12'!
test09CanNotReserveAReserveSlot

	| slot |
	
	slot := Slot new.
	slot reserve.
	
	self 
		should: [ slot reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Slot canNotReserveAReservedSlotErrorDescription equals: anError messageText.
			self assert: slot isReserved ]! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:08'!
test10SlotIsEmptyAfterReleasingIt

	| slot |

	slot := Slot new.
	slot receive: #car.
	slot release.
	
	self assert: slot isEmpty.
	self deny: slot isOccupied! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:30:03'!
test11CostOfAnEmptySlotIsCeroPesos

	| slot |

	slot := Slot new.
	
	self assert: 0*peso equals: (slot costUsing: self defaultPriceList ifUnknowVehicleType: [ self fail ])! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:29:59'!
test12CostOfAReservedSlotIsCeroPesos

	| slot |

	slot := Slot new.
	slot reserve.
	
	self assert: 0*peso equals: (slot costUsing: self defaultPriceList ifUnknowVehicleType: [ self fail ])! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:29:54'!
test13CostOfAnOcuppiedSlotDependsOnVehicleType

	| slotWithACar slotWithABike priceList |

	slotWithACar := Slot new.
	slotWithACar receive: #car.
	
	slotWithABike := Slot new.
	slotWithABike receive: #bike.
	
	priceList := self defaultPriceList.
	
	self assert: (priceList at: #car) equals: (slotWithACar costUsing: priceList ifUnknowVehicleType: [ self fail ]).
	self assert: (priceList at: #bike) equals: (slotWithABike costUsing: priceList ifUnknowVehicleType: [ self fail ]).
	! !

!SlotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 23:29:50'!
test14ThereIsNoCostOfInvalidVehicleType

	| slotWithACar priceList |

	slotWithACar := Slot new.
	slotWithACar receive: #unknowVehicle.
	
	priceList := self defaultPriceList.
	
	slotWithACar costUsing: priceList ifUnknowVehicleType: [ ^self ].
	self failWith: 'should not get cost of invalid vehicle type'
	! !


!SlotTest methodsFor: 'price list' stamp: 'HAW 4/24/2019 19:56:51'!
defaultPriceList
	
	^Dictionary new
		at: #car put: 100*peso;
		at: #bike put: 50*peso;
		yourself ! !


!classDefinition: #EmptySpace category: #'ISW1-2019-1C-Parcial'!
Object subclass: #EmptySpace
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!EmptySpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:26:27'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ 0! !

!EmptySpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:23:39'!
isEmpty

	^ true! !

!EmptySpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:23:44'!
isOccupied

	^ false! !

!EmptySpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:27:22'!
isReserved

	^ false! !

!EmptySpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:38:48'!
receive: aVehicle

	^ OccupiedSpace for: aVehicle ! !

!EmptySpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:38:29'!
release

	^ self error: Slot canNotLeaveFromEmptySlotErrorDescription ! !

!EmptySpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:38:22'!
reserve

	^ ReservedSpace new! !


!classDefinition: #OccupiedSpace category: #'ISW1-2019-1C-Parcial'!
Object subclass: #OccupiedSpace
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:25:09'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ aBlock value! !

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:23:57'!
isEmpty

	^ false! !

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:23:52'!
isOccupied

	^ true! !

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:27:15'!
isReserved

	^ false! !

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:31:57'!
receive: aVehicle

	^ self error: Slot canNotParkInSlotWhenOccupiedErrorDescription
	! !

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:39:13'!
release

	^ EmptySpace new! !

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:33:31'!
reserve

	^ self error: Slot canNotReserveAnOccupiedSlotErrorDescription
	! !

!OccupiedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 19:06:14'!
vehicleType

	^ self error: ParkingLot unknowVehicleTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OccupiedSpace class' category: #'ISW1-2019-1C-Parcial'!
OccupiedSpace class
	instanceVariableNames: ''!

!OccupiedSpace class methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:15:27'!
for: aVehicle

	^ (self subclasses
	detect: [ :occupiedSpaceSubClass |
		occupiedSpaceSubClass matches: aVehicle ]
	ifNone: [ ^ self new ]) new! !


!classDefinition: #OccupiedSpaceByABike category: #'ISW1-2019-1C-Parcial'!
OccupiedSpace subclass: #OccupiedSpaceByABike
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!OccupiedSpaceByABike methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:45:08'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ aPriceList at: self vehicleType! !

!OccupiedSpaceByABike methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 21:02:16'!
vehicleType

	^ #bike! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OccupiedSpaceByABike class' category: #'ISW1-2019-1C-Parcial'!
OccupiedSpaceByABike class
	instanceVariableNames: ''!

!OccupiedSpaceByABike class methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 21:03:25'!
matches: aVehicle

	^ aVehicle = #bike! !


!classDefinition: #OccupiedSpaceByACar category: #'ISW1-2019-1C-Parcial'!
OccupiedSpace subclass: #OccupiedSpaceByACar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!OccupiedSpaceByACar methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:45:30'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ aPriceList at: self vehicleType! !

!OccupiedSpaceByACar methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 20:57:26'!
vehicleType

	^ #car! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OccupiedSpaceByACar class' category: #'ISW1-2019-1C-Parcial'!
OccupiedSpaceByACar class
	instanceVariableNames: ''!

!OccupiedSpaceByACar class methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 21:03:39'!
matches: aVehicle

	^ aVehicle = #car! !


!classDefinition: #ParkingLot category: #'ISW1-2019-1C-Parcial'!
Object subclass: #ParkingLot
	instanceVariableNames: 'slots prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!ParkingLot methodsFor: 'parking' stamp: 'AB 4/25/2019 20:49:35'!
receive: aVehicleType
		
	| freeSlots slotToPark |
	
	freeSlots := self freeSlots.
	self when: freeSlots isEmptySend: [ self signalFullParkingLot ].
	
	slotToPark := freeSlots atRandom.
	slotToPark receive: aVehicleType.
	
	^slotToPark! !

!ParkingLot methodsFor: 'parking' stamp: 'AB 4/25/2019 20:48:34'!
release: aSlot

	(slots includes: aSlot) ifFalse: [ self signalSlotNotInParkingLot ].
	self when: aSlot isEmptySend: [ self signalCanNotReleaseAnEmptySlot ].
	
	aSlot release! !

!ParkingLot methodsFor: 'parking' stamp: 'AB 4/25/2019 20:48:18'!
when: anObjectThanCanBeEmpty isEmptySend: signal

	(anObjectThanCanBeEmpty isEmpty) ifTrue: signal! !


!ParkingLot methodsFor: 'initialization' stamp: 'AB 4/25/2019 19:44:36'!
initializeWith: anAmountOfSlots and: aPriceList
	
	| amountDifference |
	
	amountDifference _ anAmountOfSlots odd ifTrue: [ 1 ] ifFalse: [ 0 ].
	
	slots := (((1 to: anAmountOfSlots - amountDifference) collect: [ :id | Slot new ]) asOrderedCollection).
	
	amountDifference > 0 ifTrue: [ slots add: Slot new reserve; yourself ].
	
	prices := aPriceList ! !


!ParkingLot methodsFor: 'filtering' stamp: 'AB 4/25/2019 20:06:40'!
freeSlots

	^ slots select: [ :aSlot | aSlot isEmpty ]! !

!ParkingLot methodsFor: 'filtering' stamp: 'AB 4/25/2019 20:12:08'!
occupiedSlots

	^ slots select: [ :aSlot | aSlot isOccupied ]! !

!ParkingLot methodsFor: 'filtering' stamp: 'AB 4/25/2019 20:56:21'!
occupiedSlotsByVehicleType: aVehicleType

	^ (self occupiedSlots) select: [ :aSlot | aSlot vehicleType = aVehicleType]! !

!ParkingLot methodsFor: 'filtering' stamp: 'AB 4/25/2019 20:14:06'!
reservedSlots

	^ slots select: [ :aSlot | aSlot isReserved ]! !


!ParkingLot methodsFor: 'exceptions' stamp: 'HAW 4/24/2019 20:48:43'!
signalCanNotReleaseAnEmptySlot

	self error: self class canNotReleaseAnEmptySlotErrorDescription.! !

!ParkingLot methodsFor: 'exceptions' stamp: 'HAW 4/24/2019 10:16:10'!
signalFullParkingLot

	self error: self class canNotParkIsFullErrorDescription.! !

!ParkingLot methodsFor: 'exceptions' stamp: 'HAW 4/24/2019 22:13:27'!
signalSlotNotInParkingLot
	
	self error: self class slotNotInParkingLotErrorDescription ! !

!ParkingLot methodsFor: 'exceptions' stamp: 'HAW 4/24/2019 22:15:18'!
signalUnknowVehicleType

	self error: self class unknowVehicleTypeErrorDescription! !


!ParkingLot methodsFor: 'cost' stamp: 'AB 4/25/2019 20:29:51'!
costOf: aSlot 
	
	^ aSlot costUsing: prices ifUnknowVehicleType: [ self signalUnknowVehicleType ]! !

!ParkingLot methodsFor: 'cost' stamp: 'AB 4/25/2019 19:08:39'!
totalBikesParked

	^ self totalVehiclesParkedOfType: #bike! !

!ParkingLot methodsFor: 'cost' stamp: 'AB 4/25/2019 19:08:24'!
totalCarsParked

	^ self totalVehiclesParkedOfType: #car! !

!ParkingLot methodsFor: 'cost' stamp: 'AB 4/25/2019 19:04:00'!
totalParked

	^ self totalBikesParked + self totalCarsParked 
	! !

!ParkingLot methodsFor: 'cost' stamp: 'AB 4/25/2019 20:10:57'!
totalVehiclesParkedOfType: vehicleType

	| totalVehiclesParked |
	
	totalVehiclesParked _ 0 * peso.
	(self occupiedSlotsByVehicleType: vehicleType) do: [ :aSlot | totalVehiclesParked _ totalVehiclesParked + (self costOf: aSlot)].
	
	^ totalVehiclesParked
! !


!ParkingLot methodsFor: 'boss slot' stamp: 'AB 4/25/2019 20:29:31'!
bossSlotIfNone: noneBlock
	
	^ self reservedSlots ifEmpty: noneBlock ifNotEmpty: [ :reservedSlots | reservedSlots anyOne ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParkingLot class' category: #'ISW1-2019-1C-Parcial'!
ParkingLot class
	instanceVariableNames: ''!

!ParkingLot class methodsFor: 'instance creation' stamp: 'HAW 4/24/2019 09:56:44'!
with: aNumberOfSlots and: aPriceList
	"creates a Parking Lot with a number of slots and a list of prices"
	
	self assertIsPositive: aNumberOfSlots.
	self assertIsInteger: aNumberOfSlots.
	
	^ self new initializeWith: aNumberOfSlots and: aPriceList.! !


!ParkingLot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 10:16:10'!
canNotParkIsFullErrorDescription

	^ 'Can not park because ParkingLot is full'.! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 19:33:07'!
canNotReleaseAnEmptySlotErrorDescription

	^ 'Your vehicle is not parked here'.! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 19:33:11'!
invalidNumberOfLotsErrorDescription
	
	^ 'The number of lots must be positive'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 19:33:15'!
numberOfLotsMustBeIntegerErrorDescription
	
	^ 'Number of lots must be integer'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 19:33:19'!
slotNotInParkingLotErrorDescription
	
	^ 'Slot does not belong to this parking lot'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 19:33:23'!
unknowVehicleTypeErrorDescription

	^ 'Unknow vehicle type'! !


!ParkingLot class methodsFor: 'assertions' stamp: 'HAW 4/24/2019 09:57:32'!
assertIsInteger: aNumberOfLots

	aNumberOfLots isInteger ifFalse: [ self signalNumberOfLotsMustBeInteger ]! !

!ParkingLot class methodsFor: 'assertions' stamp: 'HAW 4/24/2019 09:53:50'!
assertIsPositive: aNumberOfLots

	aNumberOfLots strictlyPositive ifFalse: [ self signalInvalidNumberOfLots ]! !


!ParkingLot class methodsFor: 'exceptions' stamp: 'HAW 4/24/2019 09:55:14'!
signalInvalidNumberOfLots

	self error: self invalidNumberOfLotsErrorDescription ! !

!ParkingLot class methodsFor: 'exceptions' stamp: 'HAW 4/24/2019 09:57:43'!
signalNumberOfLotsMustBeInteger
	
	self error: self numberOfLotsMustBeIntegerErrorDescription ! !


!classDefinition: #ReservedSpace category: #'ISW1-2019-1C-Parcial'!
Object subclass: #ReservedSpace
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!ReservedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:26:37'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ 0! !

!ReservedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:26:51'!
isEmpty

	^ false! !

!ReservedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:27:04'!
isOccupied

	^ false! !

!ReservedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:26:59'!
isReserved

	^ true! !

!ReservedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:32:09'!
receive: aVehicle

	^ self error: Slot canNotParkInSlotWhenReservedErrorDescription 
	! !

!ReservedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:37:42'!
release

	^ self error: Slot canNotLeaveFromReservedSlotErrorDescription! !

!ReservedSpace methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:33:52'!
reserve

	^ self error: Slot canNotReserveAReservedSlotErrorDescription 
	! !


!classDefinition: #Slot category: #'ISW1-2019-1C-Parcial'!
Object subclass: #Slot
	instanceVariableNames: 'space'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:24:46'!
costUsing: aPriceList ifUnknowVehicleType: aBlock
	
	^ space costUsing: aPriceList ifUnknowVehicleType: aBlock! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:25:39'!
initialize
	
	space _ EmptySpace new! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:24:21'!
isEmpty
	
	^ space isEmpty ! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:22:13'!
isOccupied
	
	^ space isOccupied! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 17:28:13'!
isReserved
	
	^ space isReserved ! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:37:19'!
receive: aVehicle
	
	space _ space receive: aVehicle! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:36:32'!
release
	
	space _ space release! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 18:36:49'!
reserve
	
	space _ space reserve! !

!Slot methodsFor: 'as yet unclassified' stamp: 'AB 4/25/2019 20:58:37'!
vehicleType

	^ space vehicleType! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Slot class' category: #'ISW1-2019-1C-Parcial'!
Slot class
	instanceVariableNames: ''!

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 19:50:27'!
canNotLeaveFromEmptySlotErrorDescription

	^ 'Can not leave from an already empty slot'! !

!Slot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 20:50:23'!
canNotLeaveFromReservedSlotErrorDescription
	
	^ 'Can not leave from a reserved slot (is only for owners!!)'! !

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 19:42:23'!
canNotParkInSlotWhenOccupiedErrorDescription
	
	^ 'Can not park in ocuppied slot'! !

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 19:43:16'!
canNotParkInSlotWhenReservedErrorDescription

	^ 'Can not park in a slot reserved for the owner'.! !

!Slot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 20:50:29'!
canNotReserveAReservedSlotErrorDescription
	
	^ 'Can not reserve a reserved slots'! !

!Slot class methodsFor: 'error messages' stamp: 'AB 4/25/2019 20:50:32'!
canNotReserveAnOccupiedSlotErrorDescription
	
	^ 'Can not reserved an occupied slot'! !
