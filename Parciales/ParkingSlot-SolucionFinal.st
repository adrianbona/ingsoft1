!classDefinition: #ParkingLotTest category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
TestCase subclass: #ParkingLotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

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


!classDefinition: #SlotTest category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
TestCase subclass: #SlotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

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


!classDefinition: #ParkingLot category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
Object subclass: #ParkingLot
	instanceVariableNames: 'slots prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

!ParkingLot methodsFor: 'parking' stamp: 'HAW 4/24/2019 22:18:34'!
receive: aVehicleType
		
	| freeSlots slotToPark |
	
	freeSlots := self freeSlots.
	freeSlots isEmpty ifTrue: [ self signalFullParkingLot ].
	
	slotToPark := freeSlots atRandom.
	slotToPark receive: aVehicleType.
	
	^slotToPark! !

!ParkingLot methodsFor: 'parking' stamp: 'HAW 4/24/2019 22:18:17'!
release: aSlot

	(slots includes: aSlot) ifFalse: [ self signalSlotNotInParkingLot ].
	aSlot isEmpty ifTrue: [ self signalCanNotReleaseAnEmptySlot ].
	
	aSlot release! !


!ParkingLot methodsFor: 'initialization' stamp: 'HAW 4/24/2019 23:37:31'!
createSlotsWith: aNumberOfSlots

	^((1 to: aNumberOfSlots) collect: [:id | Slot new]) asOrderedCollection! !

!ParkingLot methodsFor: 'initialization' stamp: 'HAW 4/24/2019 23:36:56'!
initializeWith: anAmountOfSlots and: aPriceList
	
	slots := anAmountOfSlots odd 
		ifTrue: [ (self createSlotsWith: anAmountOfSlots - 1) add: Slot new reserve; yourself ]
		ifFalse: [ self createSlotsWith: anAmountOfSlots ].
	
	prices := aPriceList ! !


!ParkingLot methodsFor: 'filtering' stamp: 'HAW 4/24/2019 23:31:25'!
freeSlots

	^slots select: [ :aSlot | aSlot isEmpty ]! !

!ParkingLot methodsFor: 'filtering' stamp: 'HAW 4/24/2019 23:31:42'!
occupiedSlots

	^slots select: [ :aSlot | aSlot isOccupied ]! !

!ParkingLot methodsFor: 'filtering' stamp: 'HAW 4/24/2019 23:32:08'!
reservedSlots

	^slots select: [ :aSlot | aSlot isReserved ]! !


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


!ParkingLot methodsFor: 'cost' stamp: 'HAW 4/24/2019 22:14:44'!
costOf: aSlot 
	
	^aSlot costUsing: prices ifUnknowVehicleType: [ self signalUnknowVehicleType ]! !

!ParkingLot methodsFor: 'cost' stamp: 'HAW 4/24/2019 23:35:34'!
totalBikesParked

	^self totalOf: (self occupiedSlots select: [ :aSlot | aSlot vehicleType = #bike ]) ! !

!ParkingLot methodsFor: 'cost' stamp: 'HAW 4/24/2019 23:35:02'!
totalCarsParked

	^self totalOf: (self occupiedSlots select: [ :aSlot | aSlot vehicleType = #car ])! !

!ParkingLot methodsFor: 'cost' stamp: 'HAW 4/24/2019 23:34:39'!
totalOf: aCollectionOfSlots

	^aCollectionOfSlots sum: [ :aSlot | self costOf: aSlot ].
	! !

!ParkingLot methodsFor: 'cost' stamp: 'HAW 4/24/2019 23:34:49'!
totalParked

	^self totalOf: slots
	! !


!ParkingLot methodsFor: 'boss slot' stamp: 'HAW 4/24/2019 20:21:14'!
bossSlotIfNone: noneBlock
	
	^self reservedSlots ifEmpty: noneBlock ifNotEmpty: [ :reservedSlots | reservedSlots anyOne ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParkingLot class' category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
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

!ParkingLot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 10:45:51'!
canNotReleaseAnEmptySlotErrorDescription

	^  'Your vehicle is not parked here'.! !

!ParkingLot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 09:55:14'!
invalidNumberOfLotsErrorDescription
	
	^'The number of lots must be positive'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 09:55:49'!
numberOfLotsMustBeIntegerErrorDescription
	
	^'Number of lots must be integer'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 22:11:40'!
slotNotInParkingLotErrorDescription
	
	^'Slot does not belong to this parking lot'! !

!ParkingLot class methodsFor: 'error messages' stamp: 'HAW 4/24/2019 22:15:43'!
unknowVehicleTypeErrorDescription

	^'Unknow vehicle type'! !


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


!classDefinition: #Slot category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
Object subclass: #Slot
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

!Slot methodsFor: 'costing' stamp: 'HAW 4/24/2019 23:21:42'!
costUsing: aPriceList ifUnknowVehicleType: unknowVehicleTypeBlock

	^state costUsing: aPriceList ifUnknowVehicleType: unknowVehicleTypeBlock
	! !


!Slot methodsFor: 'initialization' stamp: 'HAW 4/24/2019 23:15:26'!
initialize

	state := EmptySlotState new! !


!Slot methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:15:35'!
isEmpty
	
	^state isEmpty! !

!Slot methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:15:41'!
isOccupied
	
	^state isOccupied! !

!Slot methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:15:49'!
isReserved
	
	^state isReserved! !


!Slot methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:18:32'!
receive: aVehicleType

	state := state receive: aVehicleType 
	! !

!Slot methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:18:46'!
release
	
	state := state release! !

!Slot methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:19:57'!
reserve
	
	state := state reserve! !


!Slot methodsFor: 'vehicle type' stamp: 'HAW 4/24/2019 23:21:13'!
vehicleType
	
	^state vehicleType! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Slot class' category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
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


!classDefinition: #SlotState category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
Object subclass: #SlotState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

!SlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:27:21'!
receive: aVehicleType

	self subclassResponsibility ! !

!SlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:27:31'!
release

	self subclassResponsibility ! !

!SlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:27:36'!
reserve

	self subclassResponsibility ! !


!SlotState methodsFor: 'costing' stamp: 'HAW 4/24/2019 23:27:08'!
costUsing: aPriceList ifUnknowVehicleType: unknowVehicleTypeBlock

	self subclassResponsibility ! !


!SlotState methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:23:10'!
isEmpty

	^false! !

!SlotState methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:23:16'!
isOccupied

	^false! !

!SlotState methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:23:20'!
isReserved

	^false! !


!classDefinition: #EmptySlotState category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
SlotState subclass: #EmptySlotState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

!EmptySlotState methodsFor: 'costing' stamp: 'HAW 4/24/2019 23:22:10'!
costUsing: aPriceList ifUnknowVehicleType: unknowVehicleTypeBlock

	^0*peso
	! !


!EmptySlotState methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:23:50'!
isEmpty

	^true! !


!EmptySlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:18:24'!
receive: aVehicleType

	^OccupiedSlotState with: aVehicleType ! !

!EmptySlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:25:46'!
release

	self error: Slot canNotLeaveFromEmptySlotErrorDescription
	! !

!EmptySlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:24:57'!
reserve

	^ReservedSlotState new! !


!classDefinition: #OccupiedSlotState category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
SlotState subclass: #OccupiedSlotState
	instanceVariableNames: 'vehicleType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

!OccupiedSlotState methodsFor: 'vehicle type' stamp: 'HAW 4/24/2019 23:26:34'!
vehicleType
	
	^vehicleType! !


!OccupiedSlotState methodsFor: 'costing' stamp: 'HAW 4/24/2019 23:22:39'!
costUsing: aPriceList ifUnknowVehicleType: unknowVehicleTypeBlock

	^aPriceList at: vehicleType ifAbsent: unknowVehicleTypeBlock ! !


!OccupiedSlotState methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:23:27'!
isOccupied

	^true! !


!OccupiedSlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:25:28'!
receive: aVehicleType

	self error: Slot canNotParkInSlotWhenOccupiedErrorDescription 
	! !

!OccupiedSlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:19:28'!
release

	^EmptySlotState new! !

!OccupiedSlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:26:03'!
reserve

	self error: Slot canNotReserveAnOccupiedSlotErrorDescription
	! !


!OccupiedSlotState methodsFor: 'initialization' stamp: 'HAW 4/24/2019 23:24:27'!
initializeWith: aVehicleType 

	vehicleType := aVehicleType ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OccupiedSlotState class' category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
OccupiedSlotState class
	instanceVariableNames: ''!

!OccupiedSlotState class methodsFor: 'as yet unclassified' stamp: 'HAW 4/24/2019 23:24:14'!
with: aVehicleType

	^self new initializeWith: aVehicleType ! !


!classDefinition: #ReservedSlotState category: #'ISW1-2019-1C-Parcial-SolucionFinal'!
SlotState subclass: #ReservedSlotState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial-SolucionFinal'!

!ReservedSlotState methodsFor: 'costing' stamp: 'HAW 4/24/2019 23:22:25'!
costUsing: aPriceList ifUnknowVehicleType: unknowVehicleTypeBlock
	
	^0*peso
	! !


!ReservedSlotState methodsFor: 'testing' stamp: 'HAW 4/24/2019 23:23:37'!
isReserved

	^true! !


!ReservedSlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:25:37'!
receive: aVehicleType

	self error: Slot canNotParkInSlotWhenReservedErrorDescription
	! !

!ReservedSlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:25:55'!
release

	self error: Slot canNotLeaveFromReservedSlotErrorDescription
	! !

!ReservedSlotState methodsFor: 'parking' stamp: 'HAW 4/24/2019 23:26:11'!
reserve

	self error: Slot canNotReserveAReservedSlotErrorDescription
	! !
