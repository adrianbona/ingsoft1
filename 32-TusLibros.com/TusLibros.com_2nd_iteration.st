!classDefinition: #CashierTest category: #'TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CashierTest methodsFor: 'testing' stamp: 'AB 6/8/2019 14:18:42'!
test01CanNotCreateCashierForAnEmptyCart

	| aMerchantProcessor |
	
	self should: [ 
		Cashier 
			with: TesteableObjectsFactory emptyShoppingCart 
			chargingTo: TesteableObjectsFactory workingCreditCard 
			registeringOn: TesteableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier shoppingCartCanNotBeEmpty.
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/8/2019 14:19:00'!
test02CanNotCreateCashierWithExpiredCreditCard

	| aMerchantProcessor |

	self should: [ 
		Cashier 
			with: TesteableObjectsFactory oneItemShoppingCart 
			chargingTo: TesteableObjectsFactory expiredCreditCard 
			registeringOn: TesteableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier expiredCreditCardIsNotValid
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/8/2019 14:19:13'!
test03CheckingOutIncreasesSalesAmount

	| cashier salesBook aMerchantProcessor |

	salesBook _ TesteableObjectsFactory emptySalesBook.

	cashier _ Cashier 
		with: TesteableObjectsFactory oneItemShoppingCart 
		chargingTo: TesteableObjectsFactory workingCreditCard 
		registeringOn: salesBook
		startingOn: Date today
		using: aMerchantProcessor.

	self assert: salesBook isEmpty.

	cashier checkOut.

	self assert: 1 equals: salesBook size! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/8/2019 14:19:33'!
test04CanNotCreateCashierForATotalCostWithMoreThan15DigitsForItsIntegerPart

	| aMerchantProcessor |

	self should: [ 
		Cashier 
			with: TesteableObjectsFactory shoppingCartWithTotalCostLongerThan15Digits 
			chargingTo: TesteableObjectsFactory workingCreditCard 
			registeringOn: TesteableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier totalCostCanNotBeLongerThan15DigitsInItsIntegerPart
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/8/2019 14:19:47'!
test05CanNotCreateCashierForATotalCostWithMoreThan2DigitsInFractionPart

	| aMerchantProcessor |
	
	self should: [ 
		Cashier 
			with: TesteableObjectsFactory shoppingCartWithTotalCostThreeDigitsInFractionPart 
			chargingTo: TesteableObjectsFactory workingCreditCard 
			registeringOn: TesteableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier totalCostCanNotBeLongerThan2DigitsInItsFractionPart
	]! !


!classDefinition: #CreditCardTest category: #'TusLibros.com'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:16:00'!
test01SizeOfNumberMustBeExactly16CharactersLong
	
	self should: [ 
		CreditCard 
			with: TesteableObjectsFactory a15DigitsNumber 
			with: TesteableObjectsFactory aMonthOfYear 
			with: TesteableObjectsFactory a30CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	].

	self should: [ 
		CreditCard 
			with: TesteableObjectsFactory a17DigitsNumber 
			with: TesteableObjectsFactory aMonthOfYear 
			with: TesteableObjectsFactory a30CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	]! !

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:16:32'!
test02OwnerNameShorterThan1CharacterAndLargerThan30ReturnsError
	
	self should: [ 
		CreditCard 
			with: TesteableObjectsFactory a16DigitsNumber 
			with: TesteableObjectsFactory aMonthOfYear 
			with: TesteableObjectsFactory a0CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard ownerNameMustBeBetween1And30CharactersLong
	].

	self should: [ 
		CreditCard 
			with: TesteableObjectsFactory a16DigitsNumber 
			with: TesteableObjectsFactory aMonthOfYear 
			with: TesteableObjectsFactory a31CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard ownerNameMustBeBetween1And30CharactersLong
	]! !


!classDefinition: #ShoppingCartTest category: #'TusLibros.com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:06:33'!
test01CreateNewShoppingCartIsEmptyCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory emptyPriceList.
	
	self assert: shoppingCart isEmpty.
	self assert: shoppingCart totalCost = (0 * peso)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:06:44'!
test02WhenAddingBookToShoppingCarItIsNotEmpty

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory oneItemPriceList.
	
	shoppingCart add: #book1.
	
	self deny: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:06:54'!
test03WhenAddingABookToShoppingCartCanCheckIsThere

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory oneItemPriceList.
	
	shoppingCart add: #book1.
	
	self deny: shoppingCart isEmpty.
	self assert: (shoppingCart contains: #book1)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:00'!
test04AddingTwoBooksMakesSizeTwoAndBothAreContained

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory twoItemsPriceList.
	
	shoppingCart add: #book1.
	shoppingCart add: #book2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #book1).
	self assert: (shoppingCart contains: #book2)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:05'!
test05AddTwoCopiesOfTheSameBookAssertInclusionInCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory oneItemPriceList.
	
	shoppingCart add: #book1 quantity: 2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #book1)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:09'!
test06AddingABookWithAQuantityLessThan1ThrowsAnError

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory oneItemPriceList.
	
	self should: [shoppingCart add: #book1 quantity: 0]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart quantityMustBeBiggerThanOneError.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:13'!
test07AShoppingCartReturnsNumberOfCopiesOfABook 

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory oneItemPriceList.
	self assert: (shoppingCart quantityOf: #book1) = 0.
	
	shoppingCart add: #book1 quantity: 3.
	self assert: (shoppingCart quantityOf: #book1) = 3.! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:17'!
test08AShoppingCartReturnsCollectionWithTheBooksItContains

	| shoppingCart items |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory threeItemsPriceList.
	
	shoppingCart add: #book1 quantity: 1.
	shoppingCart add: #book2 quantity: 2.
	shoppingCart add: #book3 quantity: 3.
	
	items _ shoppingCart items.
	
	self assert: (items includes: #book1).
	self assert: (items includes: #book2).
	self assert: (items includes: #book3)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:20'!
test09CanNotAddANotIntegerQuantityOfBooksToCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory oneItemPriceList.
	
	self should: [shoppingCart add: #book1 quantity: 2.5]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart quantityMustBeAnIntegerValue.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:24'!
test10CanNotAddABookNotIncludedTheCatalogue

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TesteableObjectsFactory oneItemPriceList.
	
	self should: [shoppingCart add: #book2 quantity: 2]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart priceListDoestNotIncludeItem.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:08:36'!
test11WhenAddingBookToShoppingCartCostIncreases

	| shoppingCart priceList |
	
	priceList _ TesteableObjectsFactory oneItemPriceList.
	shoppingCart _ ShoppingCart with: priceList.

	self assert: 0 * peso equals: shoppingCart totalCost.
		
	shoppingCart add: #book1.
	
	self assert: (priceList at: #book1) equals: shoppingCart totalCost! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/8/2019 11:07:31'!
test12CanNotCreateAShoppingCartWithAnItemWithNegativeCostInPriceList

	self should: [ ShoppingCart with: TesteableObjectsFactory oneNegativeItemPriceList ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart canNotHaveItemsWithNegativeCostInPriceList	
	]
	! !


!classDefinition: #Cashier category: #'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'shoppingCart creditCard salesBook date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'check out' stamp: 'JR 6/7/2019 19:51:52'!
checkOut

	salesBook add: (Sale with: shoppingCart items costing: shoppingCart totalCost)! !


!Cashier methodsFor: 'initialization' stamp: 'AB 6/8/2019 14:18:03'!
initializeWith: aShoppingCart chargingTo: aCreditCard registeringOn: aSalesBook startingOn: aDate using: aMerchantProcessor

	shoppingCart _ aShoppingCart.
	creditCard _ aCreditCard.
	salesBook _ aSalesBook.
	date _ aDate.
	merchantProcessor _ aMerchantProcessor ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AB 6/8/2019 14:17:32'!
with: aShoppingCart chargingTo: aCreditCard registeringOn: aSalesBook startingOn: aDate using: aMerchantProcessor
	
	self assertIsNotEmpty: aShoppingCart.
	self assertTotalCostHasUpToFifteenDigits: aShoppingCart.
	self assertTotalCostHasUpToTwoDigitsInItsFractionalPart: aShoppingCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^ self new initializeWith: aShoppingCart chargingTo: aCreditCard registeringOn: aSalesBook startingOn: aDate using: aMerchantProcessor! !


!Cashier class methodsFor: 'error handling' stamp: 'AB 6/7/2019 15:26:54'!
assertIsNotEmpty: aShoppingCart 

	aShoppingCart isEmpty ifTrue: [ self error: self shoppingCartCanNotBeEmpty ]
! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/8/2019 13:50:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	| monthOfYear |
	
	monthOfYear _ GregorianMonthOfYear year: (GregorianYear number: (aDate yearNumber) ) monthNumber: (aDate monthIndex).
	
	(aCreditCard isExpiredOn: monthOfYear) ifTrue: [ self error: self expiredCreditCardIsNotValid ]
! !

!Cashier class methodsFor: 'error handling' stamp: 'JR 6/7/2019 20:06:27'!
assertTotalCostHasUpToFifteenDigits: aShoppingCart

	| totalCostIntegerPart |
	
	totalCostIntegerPart _ aShoppingCart totalCost amount asInteger.

	((totalCostIntegerPart numberOfDigitsInBase: 10) > 15) ifTrue: [ self error: self totalCostCanNotBeLongerThan15DigitsInItsIntegerPart ]! !

!Cashier class methodsFor: 'error handling' stamp: 'JR 6/7/2019 20:25:03'!
assertTotalCostHasUpToTwoDigitsInItsFractionalPart: aShoppingCart

	| totalCostFractionalPart|
	
	totalCostFractionalPart _ ((aShoppingCart totalCost amount) * 100) fractionPart .

	(totalCostFractionalPart > 0) ifTrue: [ self error: self totalCostCanNotBeLongerThan2DigitsInItsFractionPart ]! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/5/2019 23:09:51'!
expiredCreditCardIsNotValid

	^ 'Credit card has already expired'! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/7/2019 15:27:15'!
shoppingCartCanNotBeEmpty

	^ 'Shopping cart can not be empty'! !

!Cashier class methodsFor: 'error handling' stamp: 'JR 6/7/2019 19:34:03'!
totalCostCanNotBeLongerThan15DigitsInItsIntegerPart

	^ 'Total cost can not be longer than 15 digits in its integer part'! !

!Cashier class methodsFor: 'error handling' stamp: 'JR 6/7/2019 19:52:08'!
totalCostCanNotBeLongerThan2DigitsInItsFractionPart

	^ 'Total cost can not be longer than 2 digits in its fractional part'! !


!classDefinition: #CreditCard category: #'TusLibros.com'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCard methodsFor: 'initialization' stamp: 'AB 6/7/2019 00:20:07'!
initializeWith: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersNameBetween1and30CharactersLong

	number _ a16DigitsNumber.
	expiration _ aTwoDigitsMonthAndATwoDigitsYear.
	owner _ anOwnersNameBetween1and30CharactersLong! !


!CreditCard methodsFor: 'expiration' stamp: 'AB 6/6/2019 19:59:27'!
isExpiredOn: aMonthOfYear

	^ expiration < aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 23:02:11'!
cardNumberMustBe16DigitsLong
	
	^ 'Credit card number must be 16 digits long'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 23:02:48'!
ownerNameMustBeBetween1And30CharactersLong
	
	^ 'Owner name must be between 1 and 30 characters long'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'AB 6/7/2019 00:06:37'!
with: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersName

	(a16DigitsNumber size = 16) ifFalse: [ self error: CreditCard cardNumberMustBe16DigitsLong ].

	(anOwnersName size between: 1 and: 30) ifFalse: [ self error: CreditCard ownerNameMustBeBetween1And30CharactersLong ].

	^ self new initializeWith: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersName! !


!classDefinition: #Sale category: #'TusLibros.com'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Sale methodsFor: 'accessing' stamp: 'PFT 6/18/2018 02:27:07'!
items
	
	^ items! !

!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'AB 6/7/2019 15:00:42'!
initializeWith: aCollectionOfItems costing: aTotal

	items _ aCollectionOfItems.
	total _ aTotal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros.com'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AB 6/7/2019 15:00:08'!
with: aCollectionOfItems costing: aTotal

	^ self new initializeWith: aCollectionOfItems costing: aTotal! !


!classDefinition: #ShoppingCart category: #'TusLibros.com'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'items priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCart methodsFor: 'accessing' stamp: 'JR 5/31/2019 20:25:32'!
items
	
	^ items! !


!ShoppingCart methodsFor: 'assertions' stamp: 'AB 6/1/2019 16:17:34'!
assertQuantityIsAnIntegerValueAndBiggerThenZero: aQuantity

	(aQuantity < 1) ifTrue: [ self error: ShoppingCart quantityMustBeBiggerThanOneError ].

	(aQuantity isInteger) ifFalse: [ self error: ShoppingCart quantityMustBeAnIntegerValue ]! !


!ShoppingCart methodsFor: 'adding' stamp: 'JR 6/7/2019 19:24:46'!
add: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: ShoppingCart priceListDoestNotIncludeItem ].

	^ items add: anItem! !

!ShoppingCart methodsFor: 'adding' stamp: 'AB 6/1/2019 16:18:12'!
add: anItem quantity: aQuantity

	self assertQuantityIsAnIntegerValueAndBiggerThenZero: aQuantity.
	
	^ aQuantity timesRepeat: [ self add: anItem ]! !


!ShoppingCart methodsFor: 'querying' stamp: 'JR 5/31/2019 19:43:29'!
contains: anItem

	^ items includes: anItem! !

!ShoppingCart methodsFor: 'querying' stamp: 'AB 5/31/2019 11:12:37'!
isEmpty

	^ items isEmpty! !

!ShoppingCart methodsFor: 'querying' stamp: 'AB 5/31/2019 11:23:00'!
itemsAmount

	^ items size! !

!ShoppingCart methodsFor: 'querying' stamp: 'JR 5/31/2019 19:43:38'!
quantityOf: anItem

	^ items occurrencesOf: anItem.! !

!ShoppingCart methodsFor: 'querying' stamp: 'AB 6/7/2019 15:06:36'!
totalCost

	^ items sum: [ :item | priceList at: item ] ifEmpty: [ 0 * peso ]! !


!ShoppingCart methodsFor: 'initialization' stamp: 'AB 6/7/2019 14:19:39'!
initializeWith: aPriceList

	items _ Bag new.
	priceList _ aPriceList.
	
	super initialize! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros.com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'JR 6/7/2019 19:20:54'!
with: aPriceList
	
	self assertThereAreNoItemsWithNegativeCostsInPriceList: aPriceList.
	
	^ self new initializeWith: aPriceList! !


!ShoppingCart class methodsFor: 'error handling' stamp: 'JR 6/7/2019 19:23:53'!
assertThereAreNoItemsWithNegativeCostsInPriceList: aPriceList

	(aPriceList values allSatisfy: [ :aCost | aCost > 0]) ifFalse: [ self error: ShoppingCart canNotHaveItemsWithNegativeCostInPriceList ]! !

!ShoppingCart class methodsFor: 'error handling' stamp: 'JR 6/7/2019 19:19:53'!
canNotHaveItemsWithNegativeCostInPriceList

	^ 'Price list can not have items with negative costs.'! !

!ShoppingCart class methodsFor: 'error handling' stamp: 'JR 6/7/2019 19:24:51'!
priceListDoestNotIncludeItem

	^ 'Price list does not include item'! !

!ShoppingCart class methodsFor: 'error handling' stamp: 'AB 6/5/2019 18:53:04'!
quantityMustBeAnIntegerValue
	
	^ 'Quantity must be an integer value'! !

!ShoppingCart class methodsFor: 'error handling' stamp: 'AB 6/5/2019 18:53:06'!
quantityMustBeBiggerThanOneError
	
	^ 'Quantity must be bigger than one'! !


!classDefinition: #TesteableObjectsFactory category: #'TusLibros.com'!
Object subclass: #TesteableObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TesteableObjectsFactory class' category: #'TusLibros.com'!
TesteableObjectsFactory class
	instanceVariableNames: ''!

!TesteableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:01:58'!
emptyPriceList

	^ Dictionary new! !

!TesteableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:54:08'!
oneItemPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: #book1 put: 100 * peso.
	
	^ priceList! !

!TesteableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:58:28'!
oneItemWithCostLongerThan15DigitsPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: #book1 put: 1234567890123456 * peso.
	
	^ priceList! !

!TesteableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:55:24'!
oneItemWithCostThreeDigitsInFractionPartPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: #book1 put: 1.234 * peso.
	
	^ priceList! !

!TesteableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 12:00:53'!
oneNegativeItemPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: #book1 put: -100 * peso.
	
	^ priceList! !

!TesteableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:56:49'!
threeItemsPriceList

	| priceList |
	
	priceList _ self twoItemsPriceList.
	priceList at: #book3 put: 300 * peso.
	
	^ priceList! !

!TesteableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:56:30'!
twoItemsPriceList

	| priceList |
	
	priceList _ self oneItemPriceList.
	priceList at: #book2 put: 200 * peso.
	
	^ priceList! !


!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:02'!
a0CharactersLongName

	^ ''! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:44'!
a15DigitsNumber

	^ '123456789012345'! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:54'!
a16DigitsNumber

	^ '1234567890123456'! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:13:36'!
a17DigitsNumber

	^ '12345678901234567'! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:17'!
a30CharactersLongName

	^ 'A Credit Card Name'! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:29'!
a31CharactersLongName

	^ 'A really long credit card name!!'! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:42:01'!
aMonthOfYear

	^ GregorianMonthOfYear current! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:30:25'!
expiredCreditCard

	^ CreditCard
		with: self a16DigitsNumber
		with: (May of: 2019)
		with: self a30CharactersLongName ! !

!TesteableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:29:41'!
workingCreditCard

	^ CreditCard 
		with: self a16DigitsNumber 
		with: self aMonthOfYear
		with: self a30CharactersLongName! !


!TesteableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/8/2019 11:53:07'!
emptyShoppingCart

	^ ShoppingCart with: self oneItemPriceList! !

!TesteableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/8/2019 11:52:24'!
oneItemShoppingCart

	| shoppingCart |

	shoppingCart _ self emptyShoppingCart.
	shoppingCart add: #book1.
	
	^ shoppingCart! !

!TesteableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/8/2019 11:52:44'!
shoppingCartWithTotalCostLongerThan15Digits

	| shoppingCart |

	shoppingCart _ ShoppingCart with: self oneItemWithCostLongerThan15DigitsPriceList.
	shoppingCart add: #book1.
	
	^ shoppingCart! !

!TesteableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/8/2019 11:40:42'!
shoppingCartWithTotalCostThreeDigitsInFractionPart

	| shoppingCart |

	shoppingCart _ ShoppingCart with: self oneItemWithCostThreeDigitsInFractionPartPriceList.
	shoppingCart add: #book1.
	
	^ shoppingCart! !


!TesteableObjectsFactory class methodsFor: 'sales book' stamp: 'AB 6/8/2019 11:18:12'!
emptySalesBook

	^ OrderedCollection new! !
