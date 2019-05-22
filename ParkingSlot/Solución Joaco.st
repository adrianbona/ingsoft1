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


!classDefinition: #ParkingLot category: #'ISW1-2019-1C-Parcial'!
Object subclass: #ParkingLot
	instanceVariableNames: 'slots prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

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


!ParkingLot methodsFor: 'initialization' stamp: 'jr 4/25/2019 20:45:35'!
initializeSlots: anAmountOfSlots
 
		^ ((1 to: anAmountOfSlots) collect: [:id | Slot new]) asOrderedCollection.! !

!ParkingLot methodsFor: 'initialization' stamp: 'jr 4/25/2019 20:47:45'!
initializeWith: anAmountOfSlots and: aPriceList
	
	anAmountOfSlots odd 
		ifTrue: [ slots := (self initializeSlots: (anAmountOfSlots - 1)) add: Slot new reserve; yourself ]
		ifFalse: [ slots := self initializeSlots: anAmountOfSlots].
	
	prices := aPriceList ! !


!ParkingLot methodsFor: 'filtering' stamp: 'jr 4/25/2019 20:40:35'!
collectSlotIf: aFilterCondition

	| collectedSlots filter |
	
	filter _ aFilterCondition asSymbol.
	collectedSlots := OrderedCollection new.
	slots do: [ :aSlot | (aSlot perform: filter) ifTrue: [ collectedSlots add: aSlot ]]. 
	
	^ collectedSlots.! !

!ParkingLot methodsFor: 'filtering' stamp: 'jr 4/25/2019 20:40:51'!
freeSlots

	^ self collectSlotIf: #isEmpty! !

!ParkingLot methodsFor: 'filtering' stamp: 'jr 4/25/2019 20:40:58'!
occupiedSlots

	^ self collectSlotIf: #isOccupied.! !

!ParkingLot methodsFor: 'filtering' stamp: 'jr 4/25/2019 20:40:54'!
reservedSlots
	
	^ self collectSlotIf: #isReserved.! !


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

!ParkingLot methodsFor: 'cost' stamp: 'jr 4/25/2019 20:37:16'!
countSlotsThatSatisfyConditionOf: aBlock

	| totalVehiclesParked |
	
	totalVehiclesParked := 0*peso.
	slots do: [ :aSlot | (aBlock value: aSlot) ifTrue: [totalVehiclesParked := totalVehiclesParked + (self costOf: aSlot)]].
	
	^totalVehiclesParked! !

!ParkingLot methodsFor: 'cost' stamp: 'jr 4/25/2019 20:37:23'!
totalBikesParked

	^ self countSlotsThatSatisfyConditionOf: [:aSlot | aSlot isOccupied and: [ aSlot vehicleType = #bike ]]! !

!ParkingLot methodsFor: 'cost' stamp: 'jr 4/25/2019 20:37:26'!
totalCarsParked

	^ self countSlotsThatSatisfyConditionOf: [:aSlot | aSlot isOccupied and: [ aSlot vehicleType = #car ]]! !

!ParkingLot methodsFor: 'cost' stamp: 'jr 4/25/2019 20:37:29'!
totalParked

	^ self countSlotsThatSatisfyConditionOf: [:aSlot | true].! !


!ParkingLot methodsFor: 'boss slot' stamp: 'HAW 4/24/2019 20:21:14'!
bossSlotIfNone: noneBlock
	
	^self reservedSlots ifEmpty: noneBlock ifNotEmpty: [ :reservedSlots | reservedSlots anyOne ]! !

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


!classDefinition: #Slot category: #'ISW1-2019-1C-Parcial'!
Object subclass: #Slot
	instanceVariableNames: 'slotOccupant'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:54:52'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ slotOccupant costUsing: aPriceList ifUnknowVehicleType: aBlock.! !

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:54:55'!
isEmpty

	^ slotOccupant isEmpty.
! !

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:54:57'!
isOccupied
	
	^ slotOccupant isOccupied.! !

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:55:00'!
isReserved

	^ slotOccupant isKindOf: ReservedSlot.! !

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:55:05'!
receive: aVehicle
	
	slotOccupant ifCantReceiveSignalError.
	(aVehicle = #car) ifTrue: [slotOccupant _ Car new].
	(aVehicle = #bike) ifTrue: [slotOccupant _ Bike new].
	(aVehicle = #bike or: aVehicle = #car) ifFalse: [slotOccupant _ UnknownOccupant new].! !

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:55:09'!
release

	slotOccupant ifCantReleaseSignalError.
	slotOccupant _ NoOccupant new.! !

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:55:15'!
reserve

	slotOccupant reserve.
	slotOccupant _ ReservedSlot new.! !

!Slot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:55:18'!
vehicleType

	^ slotOccupant vehicleType.! !


!Slot methodsFor: 'initialization' stamp: 'jr 4/25/2019 19:59:35'!
initialize

	slotOccupant _ NoOccupant new.! !

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



!classDefinition: #SlotOccupant category: #'ISW1-2019-1C-Parcial'!
Object subclass: #SlotOccupant
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!
!SlotOccupant commentStamp: '<historical>' prior: 0!
La clase SlotOccupant está acoplada a los mensajes de error de la clase Slot. Esto es así porque ya vinieron definidos en ese lugar y no tuve tiempo de refactorizar.
De todos modos la relación Slot "tiene un" SlotOccupant me pareció suficientemente natural como para que pudiera pensar que un SlotOccupant está siempre en un Slot (el nombre mismo los relaciona).

No pude quitar los IFs de #receive ya que el objeto Slot es recibe símbolos para este mensaje, y decidí crear objetos para cada tipo de vehículo en vez de trabajar directamente con los símbolos.!


!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:09:09'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	self subclassResponsibility.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:53:01'!
ifCantReleaseSignalError

	"noop".! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:30:03'!
isEmpty

	self subclassResponsibility.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:55:02'!
isOccupied

	self subclassResponsibility.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:48:08'!
signalCanNotLeaveFromEmptySlotErrorDescription

	self error: Slot canNotLeaveFromEmptySlotErrorDescription.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:48:31'!
signalCanNotLeaveFromReservedSlotErrorDescription

	self error: Slot canNotLeaveFromReservedSlotErrorDescription.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:29:46'!
signalCanNotParkInSlotWhenOccupiedErrorDescription

	self error: Slot canNotParkInSlotWhenOccupiedErrorDescription.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:29:52'!
signalCanNotParkInSlotWhenReservedErrorDescription

	self error: Slot canNotParkInSlotWhenReservedErrorDescription.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:26:32'!
signalCanNotReserveAReservedSlotErrorDescription

	self error: Slot canNotReserveAReservedSlotErrorDescription.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:26:35'!
signalCanNotReserveAnOccupiedSlotErrorDescription

	self error: Slot canNotReserveAnOccupiedSlotErrorDescription.! !

!SlotOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:07:53'!
vehicleType

	self subclassResponsibility.! !


!classDefinition: #Bike category: #'ISW1-2019-1C-Parcial'!
SlotOccupant subclass: #Bike
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!Bike methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:35:10'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ aPriceList at: self vehicleType ifAbsent: [].! !

!Bike methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:43:36'!
ifCantReceiveSignalError
	
	self signalCanNotParkInSlotWhenOccupiedErrorDescription.! !

!Bike methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:34:41'!
isEmpty

	^ false.! !

!Bike methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:55:16'!
isOccupied

	^ true.! !

!Bike methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:33:32'!
reserve

	self signalCanNotReserveAnOccupiedSlotErrorDescription.
! !

!Bike methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:35:00'!
vehicleType

	^ #bike! !


!classDefinition: #Car category: #'ISW1-2019-1C-Parcial'!
SlotOccupant subclass: #Car
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!Car methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:35:39'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ aPriceList at: self vehicleType ifAbsent: [].! !

!Car methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:43:42'!
ifCantReceiveSignalError

	self signalCanNotParkInSlotWhenOccupiedErrorDescription.! !

!Car methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:34:47'!
isEmpty

	^ false.! !

!Car methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:55:22'!
isOccupied

	^ true.! !

!Car methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:20:34'!
reserve

	self signalCanNotReserveAnOccupiedSlotErrorDescription.! !

!Car methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:35:56'!
vehicleType

	^ #car.! !


!classDefinition: #NoOccupant category: #'ISW1-2019-1C-Parcial'!
SlotOccupant subclass: #NoOccupant
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!NoOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:10:43'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ 0 * peso.! !

!NoOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:45:14'!
ifCantReceiveSignalError

"noop"! !

!NoOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:49:41'!
ifCantReleaseSignalError

	self signalCanNotLeaveFromEmptySlotErrorDescription.! !

!NoOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:34:51'!
isEmpty

	^ true.! !

!NoOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:55:30'!
isOccupied

	^ false.! !

!NoOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:25:26'!
reserve

"noop"! !


!classDefinition: #ReservedSlot category: #'ISW1-2019-1C-Parcial'!
SlotOccupant subclass: #ReservedSlot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!ReservedSlot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:10:54'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	^ 0 * peso.! !

!ReservedSlot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:43:53'!
ifCantReceiveSignalError

	self signalCanNotParkInSlotWhenReservedErrorDescription.! !

!ReservedSlot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:50:29'!
ifCantReleaseSignalError

	self signalCanNotLeaveFromReservedSlotErrorDescription.! !

!ReservedSlot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:39:40'!
isEmpty

	^ false.! !

!ReservedSlot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:55:45'!
isOccupied

	^ false.! !

!ReservedSlot methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:21:38'!
reserve

	self signalCanNotReserveAReservedSlotErrorDescription.! !


!classDefinition: #UnknownOccupant category: #'ISW1-2019-1C-Parcial'!
SlotOccupant subclass: #UnknownOccupant
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2019-1C-Parcial'!

!UnknownOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:15:35'!
costUsing: aPriceList ifUnknowVehicleType: aBlock

	aBlock value.! !

!UnknownOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:43:58'!
ifCantReceiveSignalError
	
	self signalCanNotParkInSlotWhenOccupiedErrorDescription.! !

!UnknownOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:47:58'!
isEmpty

	^ false.! !

!UnknownOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 18:55:52'!
isOccupied

	^ true.! !

!UnknownOccupant methodsFor: 'as yet unclassified' stamp: 'jr 4/25/2019 19:20:42'!
reserve

	self signalCanNotReserveAnOccupiedSlotErrorDescription.! !
