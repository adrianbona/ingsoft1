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

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 23:42:42'!
test03WhenAParkingLotIsCreatedWithEvenSlotsAllSlotsEmpty

	| parkingLotSize parkingLot |
	
	parkingLotSize _ 10.
	
	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	self assert: parkingLotSize equals: parkingLot freeSlots size! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 23:44:51'!
test04WhenAParkingLotIsCreatedWithOddSlotsOneIsReservedAndTheRestAreEmpty

	| parkingLotSize parkingLot |

	parkingLotSize _ 11.

	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	self assert: parkingLotSize -1 equals: parkingLot freeSlots size.

	self assert: 1 equals: parkingLot reservedSlots size! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 00:03:33'!
test05ParkingAVehicleReducesFreeSlotsByOne

	| parkingLotSize parkingLot |

	parkingLotSize _ 10.

	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	parkingLot receive: #car.
	
	self assert: parkingLotSize - 1 equals: parkingLot freeSlots size.

	self assert: 1 equals: parkingLot occupiedSlots size! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 00:09:49'!
test06WhenAVehicleLeavesTheEmptySlotsIsAugmentedByOne

	| parkingLotSize parkingLot parkedSlot |

	parkingLotSize _ 10.

	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.
	
	parkedSlot _ parkingLot receive: #bike.

	parkingLot release: parkedSlot.

	self assert: parkingLotSize equals: parkingLot freeSlots size.

	self assert: parkingLot occupiedSlots isEmpty! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 00:16:52'!
test07CanNotReleaseASlotNotIncludedInParkingLot

	| parkingLotSize parkingLot |

	parkingLotSize _ 10.

	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	self 
		should: [ parkingLot release: Slot new ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ParkingLot slotNotInParkingLotErrorDescription equals: anError messageText.
			self assert: parkingLotSize equals: parkingLot freeSlots size
		]! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 00:11:55'!
test08CanNotParkAVehicleInTheBoosSlot

	| parkingLotSize parkingLot |

	parkingLotSize _ 11.

	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	self 
		should: [ (parkingLot bossSlotIfNone: [ self fail ]) receive: #car ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Slot canNotParkInSlotWhenReservedErrorDescription equals: anError messageText.
			self assert: parkingLot occupiedSlots isEmpty
		]! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 00:20:28'!
test09ThereIsNoBoosSlotWhenNumberOfLotsIsEven

	| parkingLotSize parkingLot |

	parkingLotSize _ 10.

	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	parkingLot bossSlotIfNone: [ ^self ].

	self failWith: 'There should not be a boos slot'! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 00:21:46'!
test10CanNotParkIfFull

	| parkingLotSize parkingLot |

	parkingLotSize _ 2.
	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	parkingLot receive: #car.

	parkingLot receive: #bike.

	self 
		should: [ parkingLot receive: #car ]
		raise: Error
		withMessageText: ParkingLot canNotParkIsFullErrorDescription 
! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 10:59:05'!
test11CanNotRealeaseAnEmptyLot

	| parkingLotSize parkingLot |

	parkingLotSize _ 2.

	parkingLot _ ParkingLot with: parkingLotSize and: self defaultPriceList.

	self 
		should: [ parkingLot release: parkingLot freeSlots anyOne ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: ParkingLot canNotReleaseAnEmptySlotErrorDescription equals: anError messageText.
			self assert: parkingLotSize equals: parkingLot freeSlots size
		]! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 11:03:22'!
test12CanGetTheTotalParked

	| parkingLot priceList |

	priceList _ self defaultPriceList.

	parkingLot _ ParkingLot with: 10 and: priceList.

	parkingLot receive: #car.
	parkingLot receive: #car.
	parkingLot receive: #bike.

	self assert: ( (priceList at: #car) * 2) + (priceList at: #bike) equals: parkingLot totalParked! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 11:11:09'!
test13ReservedSlotDoesNotAddToTotalParked

	| parkingLot priceList |

	priceList _ self defaultPriceList.

	parkingLot _ ParkingLot with: 11 and: priceList.

	parkingLot receive: #car.
	parkingLot receive: #car.
	parkingLot receive: #bike.

	self assert: ((priceList at: #car) * 2) + (priceList at: #bike) equals: parkingLot totalParked! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 11:11:36'!
test14CanNotCalculateTotalParkedWithUnknowVehicleType

	| parkingLot priceList |

	priceList _ self defaultPriceList.

	parkingLot _ ParkingLot with: 10 and: priceList.

	parkingLot receive: #unknowVehicleType.

	self
		should: [ parkingLot totalParked ]
		raise: Error
		withMessageText: ParkingLot unknowVehicleTypeErrorDescription ! !

!ParkingLotTest methodsFor: 'tests' stamp: 'AB 7/4/2019 11:12:52'!
test15CanGetTheTotalCarsParked

	| parkingLot priceList |

	priceList _ self defaultPriceList.

	parkingLot _ ParkingLot with: 10 and: priceList.

	parkingLot receive: #car.

	parkingLot receive: #car.

	parkingLot receive: #bike.
	
	self assert: (priceList at: #car)*2 equals: parkingLot totalCarsParked! !

!ParkingLotTest methodsFor: 'tests' stamp: 'HAW 4/24/2019 22:32:31'!
test16CanGetTheTotalBikeParked

	| parkingLot priceList |

	priceList := self defaultPriceList.
	parkingLot := ParkingLot with: 10 and: priceList.

	parkingLot receive: #bike.
	parkingLot receive: #bike.
	parkingLot receive: #car.
	
	self assert: (priceList at: #bike)*2 equals: parkingLot totalBikesParked ! !


!ParkingLotTest methodsFor: 'price list' stamp: 'AB 7/3/2019 23:15:10'!
defaultPriceList

	^ Dictionary new
		at: #car put: 100 * peso;
		at: #bike put: 50 * peso;
		yourself! !


!classDefinition: #SlotTest category: #'ISW1-2019-1C-Parcial'!
TestCase subclass: #SlotTest
	instanceVariableNames: 'number state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 19:20:29'!
test01NewSlotsAreEmpty

	self assert: Slot new isEmpty! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 19:23:01'!
test02ParkingAVehicleMakesTheSlotOccupied

	| slot |

	slot _ Slot new.
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

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:07:58'!
test04CanNotParkInAnOccupiedSlot

	| slot |

	slot _ Slot new.
	slot receive: #car.

	self 
		should: [ slot receive: #car ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Slot canNotParkInSlotWhenOccupiedErrorDescription! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:08:49'!
test05CanNotParkInAReservedSlot

	| slot |

	slot _ Slot new.
	slot reserve.

	self 
		should: [ slot receive: #car ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert:  Slot canNotParkInSlotWhenReservedErrorDescription equals: anError messageText.
			self assert: slot isReserved
		]! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:14:52'!
test06CanNotReleaseAnEmptySlot

	| slot |

	slot _ Slot new.

	self 
		should: [ slot release ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert:  Slot canNotLeaveFromEmptySlotErrorDescription equals: anError messageText.
			self assert: slot isEmpty
		]! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:16:09'!
test07CanNotReleaseAReservedSlot

	| slot |

	slot _ Slot new.
	slot reserve.

	self 
		should: [ slot release ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Slot canNotLeaveFromReservedSlotErrorDescription equals: anError messageText.
			self assert: slot isReserved
		]! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:17:45'!
test08CanNotReserveAnOccupiedSlot

	| slot |

	slot _ Slot new.
	slot receive: #car.
	
	self 
		should: [ slot reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Slot canNotReserveAnOccupiedSlotErrorDescription equals: anError messageText.
			self assert: slot isOccupied
		]! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:19:28'!
test09CanNotReserveAReserveSlot

	| slot |

	slot _ Slot new.
	slot reserve.

	self 
		should: [ slot reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Slot canNotReserveAReservedSlotErrorDescription equals: anError messageText.
			self assert: slot isReserved
		]! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:20:24'!
test10SlotIsEmptyAfterReleasingIt

	| slot |

	slot _ Slot new.
	slot receive: #car.
	slot release.

	self assert: slot isEmpty.
	self deny: slot isOccupied! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 20:21:24'!
test11CostOfAnEmptySlotIsCeroPesos

	| slot |

	slot _ Slot new.

	self assert: 0 * peso equals: (slot costUsing: self defaultPriceList ifUnknowVehicleType: [ self fail ])! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 22:30:29'!
test12CostOfAReservedSlotIsCeroPesos

	| slot |

	slot _ Slot new.
	slot reserve.

	self assert: 0 * peso equals: (slot costUsing: self defaultPriceList ifUnknowVehicleType: [ self fail ])! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 22:31:22'!
test13CostOfAnOcuppiedSlotDependsOnVehicleType

	| slotWithACar slotWithABike priceList |

	slotWithACar _ Slot new.
	slotWithACar receive: #car.

	slotWithABike _ Slot new.
	slotWithABike receive: #bike.
	
	priceList _ self defaultPriceList.
	
	self assert: (priceList at: #car) equals: (slotWithACar costUsing: priceList ifUnknowVehicleType: [ self fail ]).
	self assert: (priceList at: #bike) equals: (slotWithABike costUsing: priceList ifUnknowVehicleType: [ self fail ])! !

!SlotTest methodsFor: 'tests' stamp: 'AB 7/3/2019 22:45:37'!
test14ThereIsNoCostOfInvalidVehicleType

	| slotWithACar priceList |

	slotWithACar _ Slot new.
	slotWithACar receive: #unknowVehicle.

	priceList _ self defaultPriceList.

	slotWithACar costUsing: priceList ifUnknowVehicleType: [ ^self ].
	self failWith: 'should not get cost of invalid vehicle type'! !


!SlotTest methodsFor: 'price list' stamp: 'HAW 4/24/2019 19:56:51'!
defaultPriceList
	
	^Dictionary new
		at: #car put: 100*peso;
		at: #bike put: 50*peso;
		yourself ! !


!classDefinition: #ParkingLot category: #'ISW1-2019-1C-Parcial'!
Object subclass: #ParkingLot
	instanceVariableNames: 'slots prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!ParkingLot methodsFor: 'slot collections' stamp: 'AB 7/3/2019 23:59:22'!
freeSlots

	^ slots select: [ :aSlot | aSlot isEmpty ]! !

!ParkingLot methodsFor: 'slot collections' stamp: 'AB 7/3/2019 23:59:50'!
occupiedSlots

	^ slots select: [ :aSlot | aSlot isOccupied ]! !

!ParkingLot methodsFor: 'slot collections' stamp: 'AB 7/4/2019 11:34:47'!
occupiedSlotsByBikes

	^ slots select: [ :aSlot | aSlot isOccupiedBy: #bike ]! !

!ParkingLot methodsFor: 'slot collections' stamp: 'AB 7/4/2019 11:34:36'!
occupiedSlotsByCars

	^ slots select: [ :aSlot | aSlot isOccupiedBy: #car ]! !

!ParkingLot methodsFor: 'slot collections' stamp: 'AB 7/3/2019 23:59:41'!
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


!ParkingLot methodsFor: 'accessing' stamp: 'AB 7/4/2019 00:19:54'!
bossSlotIfNone: aBlock

	^ slots detect: [ :aSlot | aSlot isReserved ] ifNone: aBlock! !

!ParkingLot methodsFor: 'accessing' stamp: 'AB 7/4/2019 00:21:31'!
receive: aVehicle

	| slot |

	slot _ slots detect: [ :aSlot |  aSlot isEmpty ] ifNone: [ self error: ParkingLot canNotParkIsFullErrorDescription ].

	slot receive: aVehicle.

	^ slot! !

!ParkingLot methodsFor: 'accessing' stamp: 'AB 7/4/2019 00:24:49'!
release: aSlot

	(slots includes: aSlot) ifFalse: [ self error: ParkingLot slotNotInParkingLotErrorDescription ].

	(aSlot isEmpty) ifTrue: [ self error: ParkingLot canNotReleaseAnEmptySlotErrorDescription ].

	aSlot release! !


!ParkingLot methodsFor: 'costing' stamp: 'AB 7/4/2019 11:38:37'!
totalBikesParked

	^ self totalParkedFor: self occupiedSlotsByBikes! !

!ParkingLot methodsFor: 'costing' stamp: 'AB 7/4/2019 11:38:28'!
totalCarsParked

	^ self totalParkedFor: self occupiedSlotsByCars! !

!ParkingLot methodsFor: 'costing' stamp: 'AB 7/4/2019 11:38:15'!
totalParked

	^ self totalParkedFor: self occupiedSlots! !

!ParkingLot methodsFor: 'costing' stamp: 'AB 7/4/2019 11:37:59'!
totalParkedFor: aSlotCollection

	^ aSlotCollection sum: [ :aSlot | 
		aSlot costUsing: prices ifUnknowVehicleType: [ self error: ParkingLot unknowVehicleTypeErrorDescription ]
	]! !


!ParkingLot methodsFor: 'initialization' stamp: 'AB 7/4/2019 00:02:19'!
initializeWith: aSlotsAmount and: aPriceList

	| reserved |
	
	prices _ aPriceList.
	
	slots _ OrderedCollection new.

	reserved _ aSlotsAmount mod: 2.

	(aSlotsAmount - reserved) timesRepeat: [ slots add: Slot new ].
	
	reserved timesRepeat: [ slots add: Slot new reserve ].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParkingLot class' category: #'ISW1-2019-1C-Parcial'!
ParkingLot class
	instanceVariableNames: ''!

!ParkingLot class methodsFor: 'assertion' stamp: 'AB 7/3/2019 23:41:08'!
assertAmountIsAnInteger: anAmount

	(anAmount isInteger) ifFalse: [ self error: self numberOfLotsMustBeIntegerErrorDescription ]! !

!ParkingLot class methodsFor: 'assertion' stamp: 'AB 7/3/2019 23:40:32'!
assertAmountIsBiggerThanZero: anAmount
	
	(anAmount < 1) ifTrue: [ self error: self invalidNumberOfLotsErrorDescription ]! !

!ParkingLot class methodsFor: 'assertion' stamp: 'AB 7/3/2019 23:39:13'!
assertAmountIsBiggerThanZeroAndInteger: anAmount

	self assertAmountIsBiggerThanZero: anAmount.
	
	self assertAmountIsAnInteger: anAmount ! !


!ParkingLot class methodsFor: 'instance creation' stamp: 'AB 7/3/2019 23:38:22'!
with: aSlotsAmount and: aPriceList

	self assertAmountIsBiggerThanZeroAndInteger: aSlotsAmount.
	
	^ self new initializeWith: aSlotsAmount and: aPriceList! !


!ParkingLot class methodsFor: 'error messages' stamp: 'AB 7/3/2019 23:14:07'!
canNotParkIsFullErrorDescription

	^ 'Can not park because ParkingLot is full'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 7/3/2019 23:14:09'!
canNotReleaseAnEmptySlotErrorDescription

	^ 'Your vehicle is not parked here'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 7/3/2019 23:13:57'!
invalidNumberOfLotsErrorDescription
	
	^ 'The number of lots must be positive'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 7/3/2019 23:13:53'!
numberOfLotsMustBeIntegerErrorDescription
	
	^ 'Number of lots must be integer'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 7/3/2019 23:13:49'!
slotNotInParkingLotErrorDescription
	
	^ 'Slot does not belong to this parking lot'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'AB 7/3/2019 23:13:45'!
unknowVehicleTypeErrorDescription

	^ 'Unknow vehicle type'! !


!classDefinition: #Slot category: #'ISW1-2019-1C-Parcial'!
Object subclass: #Slot
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!Slot methodsFor: 'accessing' stamp: 'AB 7/3/2019 22:30:03'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ state costUsing: aPriceList ifUnknowVehicleType: aBlock! !

!Slot methodsFor: 'accessing' stamp: 'AB 7/3/2019 19:27:13'!
receive: aVehicle

	state receive: aVehicle! !

!Slot methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:15:46'!
release

	state release! !

!Slot methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:05:21'!
reserve

	state reserve! !

!Slot methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:02:48'!
state: aState

	state _ aState! !


!Slot methodsFor: 'status' stamp: 'AB 7/3/2019 19:27:26'!
isEmpty

	^ state isEmpty! !

!Slot methodsFor: 'status' stamp: 'AB 7/3/2019 19:27:45'!
isOccupied

	^ state isOccupied! !

!Slot methodsFor: 'status' stamp: 'AB 7/4/2019 11:26:21'!
isOccupiedBy: aVehicleType

	^ state isOccupiedBy: aVehicleType! !

!Slot methodsFor: 'status' stamp: 'AB 7/3/2019 20:05:05'!
isReserved

	^ state isReserved! !


!Slot methodsFor: 'initialization' stamp: 'AB 7/3/2019 19:52:57'!
initialize

	state _ SlotFree for: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Slot class' category: #'ISW1-2019-1C-Parcial'!
Slot class
	instanceVariableNames: ''!

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 19:50:27'!
canNotLeaveFromEmptySlotErrorDescription

	^ 'Can not leave from an already empty slot'! !

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 19:52:15'!
canNotLeaveFromReservedSlotErrorDescription
	
	^'Can not leave from a reserved slot (is only for owners!!)'! !

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 19:42:23'!
canNotParkInSlotWhenOccupiedErrorDescription
	
	^ 'Can not park in ocuppied slot'! !

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 19:43:16'!
canNotParkInSlotWhenReservedErrorDescription

	^ 'Can not park in a slot reserved for the owner'.! !

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 20:41:58'!
canNotReserveAReservedSlotErrorDescription
	
	^'Can not reserve a reserved slots'! !

!Slot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 20:40:34'!
canNotReserveAnOccupiedSlotErrorDescription
	
	^'Can not reserved an occupied slot'! !


!classDefinition: #SlotState category: #'ISW1-2019-1C-Parcial'!
Object subclass: #SlotState
	instanceVariableNames: 'slot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!SlotState methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:13:05'!
receive: aVehicle

	self subclassResponsibility ! !

!SlotState methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:13:10'!
release

	self subclassResponsibility ! !

!SlotState methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:14:17'!
reserve

	self subclassResponsibility ! !


!SlotState methodsFor: 'status' stamp: 'AB 7/3/2019 20:04:12'!
isEmpty

	self subclassResponsibility ! !

!SlotState methodsFor: 'status' stamp: 'AB 7/3/2019 20:04:38'!
isOccupied

	self subclassResponsibility ! !

!SlotState methodsFor: 'status' stamp: 'AB 7/4/2019 11:26:34'!
isOccupiedBy: aVehicleType

	self subclassResponsibility! !

!SlotState methodsFor: 'status' stamp: 'AB 7/3/2019 20:04:31'!
isReserved

	self subclassResponsibility ! !


!SlotState methodsFor: 'costing' stamp: 'AB 7/3/2019 22:28:13'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	self subclassResponsibility ! !


!SlotState methodsFor: 'initialization' stamp: 'AB 7/3/2019 20:00:08'!
initializeFor: aSlot

	slot _ aSlot! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlotState class' category: #'ISW1-2019-1C-Parcial'!
SlotState class
	instanceVariableNames: ''!

!SlotState class methodsFor: 'instance creation' stamp: 'AB 7/3/2019 19:59:44'!
for: aSlot

	^ self new initializeFor: aSlot! !


!classDefinition: #SlotFree category: #'ISW1-2019-1C-Parcial'!
SlotState subclass: #SlotFree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!SlotFree methodsFor: 'status' stamp: 'AB 7/3/2019 19:57:20'!
isEmpty

	^ true! !

!SlotFree methodsFor: 'status' stamp: 'AB 7/4/2019 11:36:21'!
isOccupied

	^ false! !

!SlotFree methodsFor: 'status' stamp: 'AB 7/4/2019 11:36:34'!
isOccupiedBy: aVehicleType

	^ self isOccupied! !

!SlotFree methodsFor: 'status' stamp: 'AB 7/3/2019 20:06:49'!
isReserved

	^ false! !


!SlotFree methodsFor: 'accessing' stamp: 'AB 7/3/2019 22:39:46'!
receive: aVehicle

	slot state: (SlotOccupied for: slot by: aVehicle)! !

!SlotFree methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:12:35'!
release

	self error: Slot canNotLeaveFromEmptySlotErrorDescription ! !

!SlotFree methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:05:51'!
reserve

	slot state: (SlotReserved for: slot)! !


!SlotFree methodsFor: 'costing' stamp: 'AB 7/3/2019 22:28:04'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ 0 * peso! !


!classDefinition: #SlotOccupied category: #'ISW1-2019-1C-Parcial'!
SlotState subclass: #SlotOccupied
	instanceVariableNames: 'vehicle'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!SlotOccupied methodsFor: 'status' stamp: 'AB 7/3/2019 19:57:27'!
isEmpty

	^ false! !

!SlotOccupied methodsFor: 'status' stamp: 'AB 7/3/2019 19:58:00'!
isOccupied

	^ true! !

!SlotOccupied methodsFor: 'status' stamp: 'AB 7/4/2019 11:15:05'!
isOccupiedBy: aVehicleType

	^ vehicle = aVehicleType! !

!SlotOccupied methodsFor: 'status' stamp: 'AB 7/3/2019 20:06:55'!
isReserved

	^ false! !


!SlotOccupied methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:08:23'!
receive: aVehicle

	self error: Slot canNotParkInSlotWhenOccupiedErrorDescription! !

!SlotOccupied methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:21:01'!
release

	slot state: (SlotFree for: slot)! !

!SlotOccupied methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:18:00'!
reserve

	self error: Slot canNotReserveAnOccupiedSlotErrorDescription! !


!SlotOccupied methodsFor: 'costing' stamp: 'AB 7/3/2019 22:46:46'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ aPriceList at: vehicle ifAbsent: aBlock! !


!SlotOccupied methodsFor: 'initialization' stamp: 'AB 7/3/2019 22:41:17'!
initializeFor: aSlot by: aVehicle

	vehicle _ aVehicle.
	super initializeFor: aSlot! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlotOccupied class' category: #'ISW1-2019-1C-Parcial'!
SlotOccupied class
	instanceVariableNames: ''!

!SlotOccupied class methodsFor: 'instance creation' stamp: 'AB 7/3/2019 22:40:32'!
for: aSlot by: aVehicle

	^ self new initializeFor: aSlot by: aVehicle! !


!classDefinition: #SlotReserved category: #'ISW1-2019-1C-Parcial'!
SlotState subclass: #SlotReserved
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!SlotReserved methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:10:38'!
receive: aVehicle

	self error: Slot canNotParkInSlotWhenReservedErrorDescription! !

!SlotReserved methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:16:31'!
release

	self error: Slot canNotLeaveFromReservedSlotErrorDescription ! !

!SlotReserved methodsFor: 'accessing' stamp: 'AB 7/3/2019 20:19:46'!
reserve

	self error: Slot canNotReserveAReservedSlotErrorDescription ! !


!SlotReserved methodsFor: 'status' stamp: 'AB 7/3/2019 20:03:43'!
isEmpty

	^ false! !

!SlotReserved methodsFor: 'status' stamp: 'AB 7/3/2019 20:07:23'!
isOccupied

	^ false! !

!SlotReserved methodsFor: 'status' stamp: 'AB 7/4/2019 11:35:45'!
isOccupiedBy: aVehicleType

	^ self isOccupied! !

!SlotReserved methodsFor: 'status' stamp: 'AB 7/3/2019 20:07:00'!
isReserved

	^ true! !


!SlotReserved methodsFor: 'costing' stamp: 'AB 7/3/2019 22:30:46'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ 0 * peso! !
