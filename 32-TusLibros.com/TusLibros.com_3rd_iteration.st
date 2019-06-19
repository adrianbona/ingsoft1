!classDefinition: #CashierTest category: #'TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'debitBehavior testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 14:28:58'!
debit: anAmount from: aCreditCard

	^ debitBehavior value: anAmount value: aCreditCard! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:23:29'!
setUp

	testObjects _ StoreTestObjectsFactory new.

	debitBehavior _ [ :anAmount :aCreditCard | ]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:30:32'!
test01CanNotCreateCashierForAnEmptyCart

	| aMerchantProcessor aCreditCard aDateAndTime aSalesBook |
	
	self should: [
		Cashier 
			with: testObjects emptyShoppingCart 
			chargingTo: aCreditCard
			registeringOn: aSalesBook
			startingOn: aDateAndTime
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier shoppingCartCanNotBeEmpty
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:30:03'!
test02CanNotCreateCashierWithExpiredCreditCard

	| aMerchantProcessor aSalesBook |

	self should: [ 
		Cashier 
			with: testObjects oneItemShoppingCart 
			chargingTo: testObjects expiredCreditCard 
			registeringOn: aSalesBook
			startingOn: testObjects today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier expiredCreditCardIsNotValid
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/17/2019 17:35:11'!
test03CheckingOutIncreasesSalesAmount

	| cashier salesBook |

	salesBook _ testObjects emptySalesBook.

	cashier _ Cashier 
		with: testObjects oneItemShoppingCart 
		chargingTo: testObjects workingCreditCard 
		registeringOn: salesBook
		startingOn: testObjects today
		using: self.

	self assert: salesBook isEmpty.

	cashier checkOut.

	self assert: 1 equals: salesBook size! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:28:51'!
test04CanNotCreateCashierForATotalCostWithMoreThan15DigitsForItsIntegerPart

	| aMerchantProcessor aCreditCard aDateAndTime aSalesBook |

	self should: [ 
		Cashier 
			with: testObjects shoppingCartWithTotalCostLongerThan15Digits 
			chargingTo: aCreditCard
			registeringOn: aSalesBook
			startingOn: aDateAndTime
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier totalCostCanNotBeLongerThan15DigitsInItsIntegerPart
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:28:30'!
test05CanNotCreateCashierForATotalCostWithMoreThan2DigitsInFractionPart

	| aMerchantProcessor aCreditCard aSalesBook aDateAndTime |
	
	self should: [
		Cashier 
			with: testObjects shoppingCartWithTotalCostThreeDigitsInFractionPart 
			chargingTo: aCreditCard
			registeringOn: aSalesBook
			startingOn: aDateAndTime
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier totalCostCanNotBeLongerThan2DigitsInItsFractionPart
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/17/2019 17:34:26'!
test06CanNotCheckOutWhenCreditCardIsWithoutFunds

	| cashier salesBook |

 	debitBehavior _ [ :anAmount :aCreditCard | self error: Cashier creditCardHasInsufficientFunds ].

	salesBook _ testObjects emptySalesBook.

	cashier _ Cashier 
		with: testObjects oneItemShoppingCart 
		chargingTo: testObjects workingCreditCard 
		registeringOn: salesBook
		startingOn: testObjects today
		using: self.
	
	self should: [ cashier checkOut ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier creditCardHasInsufficientFunds.
		self assert: salesBook isEmpty
		]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/17/2019 17:34:38'!
test07CanNotCheckOutWhenCreditCardHasReportedStolen

	| cashier salesBook |

 	debitBehavior _ [ :anAmount :aCreditCard | self error: Cashier creditCardHasBeenReportedStolen ].

	salesBook _ testObjects emptySalesBook.

	cashier _ Cashier 
		with: testObjects oneItemShoppingCart 
		chargingTo: testObjects workingCreditCard 
		registeringOn: salesBook
		startingOn: testObjects today
		using: self.
	
	self should: [ cashier checkOut ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier creditCardHasBeenReportedStolen.
		self assert: salesBook isEmpty
		]! !


!classDefinition: #CreditCardTest category: #'TusLibros.com'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:23:20'!
setUp

	testObjects _ StoreTestObjectsFactory new! !

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:10:47'!
test01SizeOfNumberMustBeExactly16CharactersLong
	
	self should: [ 
		CreditCard 
			with: testObjects a15DigitsNumber
			with: testObjects currentMonthOfYear 
			with: testObjects a30CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	].

	self should: [ 
		CreditCard 
			with: testObjects a17DigitsNumber 
			with: testObjects currentMonthOfYear 
			with: testObjects a30CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	]! !

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:08:30'!
test02OwnerNameShorterThan1CharacterAndLargerThan30ReturnsError
	
	self should: [ 
		CreditCard 
			with: testObjects a16DigitsNumber 
			with: testObjects currentMonthOfYear 
			with: testObjects a0CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong
	].

	self should: [ 
		CreditCard 
			with: testObjects a16DigitsNumber 
			with: testObjects currentMonthOfYear 
			with: testObjects a31CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong
	]! !

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:08:41'!
test03CreditCardNumberContainsOnlyNumbers
	
	self should: [ 
		CreditCard 
			with: testObjects a16DigitsStringWithNumbersAndLetters 
			with: testObjects currentMonthOfYear 
			with: testObjects a0CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustContainOnlyNumbers 
	]! !


!classDefinition: #RestInterfaceTest category: #'TusLibros.com'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'loginBehavior debitBehavior testObjects aRestInterfaceWithAnEmptyPriceList aRestInterfaceWithOneItemPriceList aRestInterfaceWithTwoItemsPriceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!RestInterfaceTest methodsFor: 'testing' stamp: 'JR 6/12/2019 23:05:32'!
debit: anAmount from: aCreditCard

	^ debitBehavior value: anAmount value: aCreditCard! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/11/2019 22:55:18'!
isRegisteredWith: aClientId and: aPassword

	^ loginBehavior value: aClientId value: aPassword! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:39:20'!
setUp

	testObjects _ StoreTestObjectsFactory new.

	loginBehavior _ [ :aClientId :aPassword | ].

	debitBehavior _ [ :anAmount :aCreditCard | ].
	
	aRestInterfaceWithOneItemPriceList _ RestInterface withCatalogue: testObjects oneItemPriceList processingThrough: self signInUsersWith: self.
	
	aRestInterfaceWithAnEmptyPriceList _ RestInterface withCatalogue: testObjects oneItemPriceList processingThrough: self signInUsersWith: self.
	
	aRestInterfaceWithTwoItemsPriceList _ RestInterface withCatalogue: testObjects twoItemsPriceList processingThrough: self signInUsersWith: self.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:37:10'!
test01CreatingShoppingCartsReturnsUniqueIDs

	| aShoppingCartId anotherShoppingCartId interface |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.
		
	aShoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	anotherShoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	self deny: aShoppingCartId = anotherShoppingCartId! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:37:23'!
test02CanNotCreateCartWithAnInvalidClientId

	| interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientId ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface 
			createCartFor: testObjects anInvalidClientId
			protectedWith: testObjects aValidClientPassword
			startingOn: testObjects today
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientId
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:37:31'!
test03CanNotCreateCartWithAnInvalidClientPassword

	| interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientPassword ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface 
			createCartFor: testObjects aValidClienId 
			protectedWith: testObjects anInvalidClientPassword 
			startingOn: testObjects today
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientPassword
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:37:40'!
test04CanNotCreateCartForAnNonExistingClient

	| interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface clientCredentialsDoNotMatchAnyExistingClient ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface 
			createCartFor: testObjects aValidClienId 
			protectedWith: testObjects aValidClientPassword 
			startingOn: testObjects today
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface clientCredentialsDoNotMatchAnyExistingClient 
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:37:59'!
test05ListingANewShoppingCartReturnsAnEmptyCollection

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	self assert: (interface listCart: shoppingCartId) isEmpty! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:38:22'!
test06CanNotListAShoppingCartWithAnNonExistingCartId

	| interface |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listCart: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface shoppingCartNotFound
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:36:51'!
test07CanAddItemInCatalogueToExistingShoppingCart

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	self assert: (interface listCart: shoppingCartId) isEmpty.

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.

	self assert: (interface listCart: shoppingCartId) includes: testObjects existingISBN! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:38:52'!
test08CanAddMoreThanOneItemToShoppingCart

	| shoppingCartId interface itemsOnCart |
	
	interface _ aRestInterfaceWithTwoItemsPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	itemsOnCart _ interface listCart: shoppingCartId.

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.
	interface addTo: shoppingCartId aBookWithCode: testObjects anotherExistingISBN aQuantityOf: 2.

	self assert: itemsOnCart includes: testObjects existingISBN.
	self assert: 1 equals: (itemsOnCart occurrencesOf: testObjects existingISBN).
	
	self assert: itemsOnCart includes: testObjects anotherExistingISBN.
	self assert: 2 equals: (itemsOnCart occurrencesOf: testObjects anotherExistingISBN)! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:39:29'!
test09CanNotAddItemToNonExistingShoppingCart

	| interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	self 
		should: [ interface 
			addTo: 1
			aBookWithCode: testObjects existingISBN aQuantityOf: 1
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface shoppingCartNotFound
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:39:43'!
test10CanNotAddItemNotInCatalogueToExistingShoppingCart

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	self 
		should: [ interface  addTo: shoppingCartId aBookWithCode: testObjects anotherExistingISBN aQuantityOf: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart priceListDoestNotIncludeItem.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:39:55'!
test11CanNotAddItemToShoppingCartWithQuantitySmallerThanOne

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	self 
		should: [ interface addTo: shoppingCartId aBookWithCode: testObjects anotherExistingISBN aQuantityOf: 0 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart quantityMustBeBiggerThanOneError.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:40:10'!
test12CanNotAddItemToShoppingCartWithANonIntegerAmount

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	self 
		should: [ interface addTo: shoppingCartId aBookWithCode: testObjects anotherExistingISBN aQuantityOf: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart quantityMustBeAnIntegerValue.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:40:27'!
test13ListingItemsOfAShoppingCartReturnsACollectionIncludingItsItems

	| shoppingCartId interface shoppingCartList |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.

	shoppingCartList _ interface listCart: shoppingCartId.
	self assert: shoppingCartList isEmpty.
	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.
	
	shoppingCartList _ interface listCart: shoppingCartId.

	self deny: shoppingCartList isEmpty.
	self assert: (shoppingCartList includes: testObjects existingISBN)! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:41:10'!
test14CanNotListPurchasesWithAnInvalidClientId

	| interface |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientId ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listPurchasesFor: testObjects anInvalidClientId protectedBy: testObjects aValidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientId
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:41:02'!
test15CanNotListPurchasesWithAnInvalidPassword

	| interface |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientPassword ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects anInvalidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientPassword
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:41:26'!
test16CanNotListPurchasesForAnNonExistingClient

	| interface |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface clientCredentialsDoNotMatchAnyExistingClient ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface clientCredentialsDoNotMatchAnyExistingClient
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:41:47'!
test17CanNotCheckOutAnEmptyCart

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	self 
		should: [ interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier shoppingCartCanNotBeEmpty.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:42:00'!
test18CanNotCheckOutWithAnExpiredCreditCard

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects expiredMonthOfYear 
			ownedBy: testObjects a30CharactersLongName
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier expiredCreditCardIsNotValid
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:42:09'!
test19CanNotCheckOutWithANonExistingShoppingCartId

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
	
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: 2
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface shoppingCartNotFound
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:42:24'!
test20CanNotCheckOutWithAnInvalidCreditCardName

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
	
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a31CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong 
		].
	
		self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a0CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong 
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:43:00'!
test21CanNotCheckOutWithAnInvalidCreditCardNumber

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a15DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
		].
	
	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a17DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong 
		].
	
	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a16DigitsStringWithNumbersAndLetters 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard cardNumberMustContainOnlyNumbers 
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:43:12'!
test22ListingPurchasesBeforeCheckingOutReturnsEmptyCollection

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.
	
	self assert: (interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword) items isEmpty! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:43:21'!
test23WhenCheckingOutClientNowRegistersANewPurchase

	| interface shoppingCartId clientPurchases |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.
	
	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.

	self assert: clientPurchases items isEmpty.

	interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.
				
	self deny: clientPurchases items isEmpty! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:44:34'!
test24WhenCheckingOutClientNowRegistersANewPurchaseAndItsTotalCost

	| interface shoppingCartId clientPurchases |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.

	interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.
				
	self assert: (clientPurchases items occurrencesOf: testObjects existingISBN) equals: 1.
	self assert: (testObjects oneItemPriceList at: testObjects existingISBN) = clientPurchases total! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:45:17'!
test25WhenCheckingOutDifferentClientsPurchasesAreRegisteredIndividually

	| interface shoppingCartId anotherShoppingCartId anotherClientPurchases clientPurchases |
		
	interface _ aRestInterfaceWithTwoItemsPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword
		startingOn: testObjects today.		

	anotherShoppingCartId _ interface 
		createCartFor: testObjects anotherValidClienId
		protectedWith: testObjects anotherValidClientPassword
		startingOn: testObjects today.		

	interface addTo: shoppingCartId aBookWithCode: testObjects existingISBN aQuantityOf: 1.
	
	interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	interface addTo: anotherShoppingCartId aBookWithCode: testObjects anotherExistingISBN aQuantityOf: 2.

	interface 
			checkOut: anotherShoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.

	self assert: clientPurchases items includes: testObjects existingISBN.
	self assert: (clientPurchases items occurrencesOf: testObjects existingISBN) equals: 1.
	self deny: (clientPurchases items includes: testObjects anotherExistingISBN).
	self assert: (testObjects twoItemsPriceList at: testObjects existingISBN) = clientPurchases total.

	anotherClientPurchases _ interface listPurchasesFor: testObjects anotherValidClienId protectedBy: testObjects anotherValidClientPassword.
	
	self assert: anotherClientPurchases items includes: testObjects anotherExistingISBN.
	self assert: (anotherClientPurchases items occurrencesOf: testObjects anotherExistingISBN) equals: 2.
	self deny: (anotherClientPurchases items includes: testObjects existingISBN).
	self assert: (testObjects twoItemsPriceList at: testObjects anotherExistingISBN) * 2 = anotherClientPurchases total! !


!classDefinition: #ShoppingCartTest category: #'TusLibros.com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:23:01'!
setUp

	testObjects _ StoreTestObjectsFactory new! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 21:06:19'!
test01CreateNewShoppingCartIsEmptyCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: testObjects emptyPriceList.
	
	self assert: shoppingCart isEmpty.

	self assert: 0 * peso equals: shoppingCart totalCost! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:31:40'!
test02WhenAddingBookToShoppingCarItIsNotEmpty

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: testObjects oneItemPriceList.
	
	shoppingCart add: testObjects existingISBN.
	
	self deny: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 21:06:52'!
test03WhenAddingABookToShoppingCartCanCheckIsThere

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: testObjects oneItemPriceList.

	shoppingCart add: testObjects existingISBN.
	
	self deny: shoppingCart isEmpty.

	self assert: (shoppingCart contains: testObjects existingISBN)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 21:07:29'!
test04AddingTwoBooksIncrementsSizeByTwoAndBothAreContained

	| shoppingCart |

	shoppingCart _ ShoppingCart with: testObjects twoItemsPriceList.

	shoppingCart add: testObjects existingISBN.
	shoppingCart add: testObjects anotherExistingISBN.

	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: testObjects existingISBN).
	self assert: (shoppingCart contains: testObjects anotherExistingISBN)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:47:49'!
test05AddTwoCopiesOfTheSameBookAssertInclusionInCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: testObjects twoItemsPriceList.
	
	shoppingCart add: testObjects anotherExistingISBN quantity: 2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: testObjects anotherExistingISBN)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 21:07:50'!
test06AddingABookWithAQuantityLessThan1ThrowsAnError

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: testObjects oneItemPriceList.
	
	self should: [ shoppingCart add: testObjects existingISBN quantity: 0 ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart quantityMustBeBiggerThanOneError.
		self assert: shoppingCart isEmpty
		]! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 21:08:51'!
test07AShoppingCartReturnsNumberOfCopiesOfABook 

	| shoppingCart |
	
	shoppingCart _ testObjects emptyShoppingCart.
	
	self assert: 0 equals: (shoppingCart quantityOf: testObjects existingISBN).
	
	shoppingCart add: testObjects existingISBN quantity: 3.

	self assert: 3 equals: (shoppingCart quantityOf: testObjects existingISBN)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 21:12:27'!
test08AShoppingCartReturnsCollectionWithTheBooksItContains

	| shoppingCart items |
	
	shoppingCart _ ShoppingCart with: testObjects twoItemsPriceList.
	
	shoppingCart add: testObjects existingISBN quantity: 1.
	shoppingCart add: testObjects anotherExistingISBN quantity: 2.
	
	items _ shoppingCart items.

	self assert: 3 equals: items size.	
	self assert: (items includes: testObjects existingISBN).
	self assert: (items includes: testObjects anotherExistingISBN)
! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:50:55'!
test09CanNotAddANotIntegerQuantityOfBooksToCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: testObjects oneItemPriceList.
	
	self should: [ shoppingCart add: testObjects existingISBN quantity: 2.5 ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart quantityMustBeAnIntegerValue.
		self assert: shoppingCart isEmpty
		]! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:51:30'!
test10CanNotAddABookNotIncludedTheCatalogue

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: testObjects oneItemPriceList.
	
	self should: [ shoppingCart add: testObjects anotherExistingISBN quantity: 2 ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart priceListDoestNotIncludeItem.
		self assert: shoppingCart isEmpty
		]! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/18/2019 22:20:49'!
test11WhenAddingBookToShoppingCartCostIncreases

	| shoppingCart priceList |
	
	priceList _ testObjects oneItemPriceList.

	shoppingCart _ ShoppingCart with: priceList.

	self assert: 0 * peso equals: shoppingCart totalCost.
		
	shoppingCart add: testObjects existingISBN.
	
	self assert: (priceList at: testObjects existingISBN) equals: shoppingCart totalCost! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/17/2019 16:52:16'!
test12CanNotCreateAShoppingCartWithAnItemWithNegativeCostInPriceList

	self should: [ ShoppingCart with: testObjects oneNegativeItemPriceList ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart canNotHaveItemsWithNegativeCostInPriceList	
	]
	! !


!classDefinition: #ActiveSession category: #'TusLibros.com'!
Object subclass: #ActiveSession
	instanceVariableNames: 'client shoppingCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ActiveSession methodsFor: 'initialization' stamp: 'AB 6/15/2019 00:50:46'!
initializeFor: aClientId with: aShoppingCart

	client _ aClientId.
	shoppingCart _ aShoppingCart! !


!ActiveSession methodsFor: 'accessing' stamp: 'AB 6/15/2019 00:45:07'!
client

	^ client! !

!ActiveSession methodsFor: 'accessing' stamp: 'AB 6/15/2019 00:45:03'!
shoppingCart

	^ shoppingCart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ActiveSession class' category: #'TusLibros.com'!
ActiveSession class
	instanceVariableNames: ''!

!ActiveSession class methodsFor: 'instance creation' stamp: 'AB 6/15/2019 00:43:15'!
for: aClientId with: aShoppingCart

	^ self new initializeFor: aClientId with: aShoppingCart! !


!classDefinition: #Cashier category: #'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'shoppingCart creditCard salesBook date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'check out' stamp: 'AB 6/10/2019 11:29:48'!
checkOut

	self debitTotalCost.

	self registerSale
	! !

!Cashier methodsFor: 'check out' stamp: 'AB 6/10/2019 11:29:28'!
debitTotalCost

	merchantProcessor debit: shoppingCart totalCost from: creditCard! !

!Cashier methodsFor: 'check out' stamp: 'AB 6/10/2019 11:30:08'!
registerSale

	salesBook add: (Sale with: shoppingCart items costing: shoppingCart totalCost)! !


!Cashier methodsFor: 'initialization' stamp: 'AB 6/17/2019 17:20:28'!
initializeWith: aShoppingCart chargingTo: aCreditCard registeringOn: aSalesBook startingOn: aDate using: aMerchantProcessor

	shoppingCart _ aShoppingCart.
	creditCard _ aCreditCard.
	salesBook _ aSalesBook.
	date _ aDate.
	merchantProcessor _ aMerchantProcessor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AB 6/10/2019 11:14:43'!
with: aShoppingCart chargingTo: aCreditCard registeringOn: aSalesBook startingOn: aDate using: aMerchantProcessor
	
	self assertIsNotEmpty: aShoppingCart.
	
	self assertTotalCostIsAValidNumberValue: aShoppingCart.
	
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^ self new initializeWith: aShoppingCart chargingTo: aCreditCard registeringOn: aSalesBook startingOn: aDate using: aMerchantProcessor! !


!Cashier class methodsFor: 'error handling' stamp: 'AB 6/7/2019 15:26:54'!
assertIsNotEmpty: aShoppingCart 

	aShoppingCart isEmpty ifTrue: [ self error: self shoppingCartCanNotBeEmpty ]
! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/17/2019 17:14:59'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self expiredCreditCardIsNotValid ]
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

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/10/2019 10:00:26'!
assertTotalCostIsAValidNumberValue: aShoppingCart
	
	self assertTotalCostHasUpToFifteenDigits: aShoppingCart.
	self assertTotalCostHasUpToTwoDigitsInItsFractionalPart: aShoppingCart
! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/11/2019 14:31:05'!
creditCardHasBeenReportedStolen

	^ 'Credit card owner has reported this card as stolen'! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/11/2019 14:31:17'!
creditCardHasInsufficientFunds

	^ 'Credit card has insufficient funds'! !

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

!CreditCard methodsFor: 'initialization' stamp: 'AB 6/10/2019 10:50:03'!
initializeWith: a16DigitsNumber with: aMonthOfYear with: anOwnersNameBetween1and30CharactersLong

	number _ a16DigitsNumber.
	expiration _ aMonthOfYear.
	owner _ anOwnersNameBetween1and30CharactersLong! !


!CreditCard methodsFor: 'expiration' stamp: 'AB 6/17/2019 17:32:55'!
isExpiredOn: aDate

	^ expiration < (GregorianMonthOfYear yearNumber: (aDate yearNumber) monthNumber: (aDate monthIndex))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error handling' stamp: 'AB 6/17/2019 17:03:12'!
assertCardNumberContainsOnlyNumbers: a16DigitsValue
	
	(a16DigitsValue allSatisfy: [ :character | character digitValue between: 0 and: 9 ]) ifFalse: [ self error: CreditCard cardNumberMustContainOnlyNumbers ]! !

!CreditCard class methodsFor: 'error handling' stamp: 'AB 6/10/2019 11:12:15'!
assertCardNumberIs16DigitsLong: a16DigitsNumber
	
	(a16DigitsNumber size = 16) ifFalse: [ self error: CreditCard cardNumberMustBe16DigitsLong ]! !

!CreditCard class methodsFor: 'error handling' stamp: 'AB 6/10/2019 11:13:13'!
assertOwnersNameBetween1And30CharactersLong: anOwnersName
	
	(anOwnersName size between: 1 and: 30) ifFalse: [ self error: CreditCard ownerNameMustBeBetween1And30CharactersLong ]! !

!CreditCard class methodsFor: 'error handling' stamp: 'AB 6/5/2019 23:02:11'!
cardNumberMustBe16DigitsLong
	
	^ 'Credit card number must be 16 digits long'! !

!CreditCard class methodsFor: 'error handling' stamp: 'AB 6/10/2019 11:23:46'!
cardNumberMustContainOnlyNumbers
	
	^ 'Credit card number must be formed by numbers from 1 to 9'! !

!CreditCard class methodsFor: 'error handling' stamp: 'AB 6/5/2019 23:02:48'!
ownerNameMustBeBetween1And30CharactersLong
	
	^ 'Owner name must be between 1 and 30 characters long'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'AB 6/17/2019 17:21:10'!
with: a16DigitsNumber with: aMonthOfYear with: anOwnersName

	self assertCardNumberContainsOnlyNumbers: a16DigitsNumber.

	self assertCardNumberIs16DigitsLong: a16DigitsNumber.

	self assertOwnersNameBetween1And30CharactersLong: anOwnersName.

	^ self new initializeWith: a16DigitsNumber with: aMonthOfYear with: anOwnersName! !


!classDefinition: #Purchase category: #'TusLibros.com'!
Object subclass: #Purchase
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Purchase methodsFor: 'accessing' stamp: 'AB 6/18/2019 17:11:31'!
items
	
	^ items! !

!Purchase methodsFor: 'accessing' stamp: 'AB 6/18/2019 17:11:31'!
total
	
	^ total! !


!Purchase methodsFor: 'initialization' stamp: 'AB 6/18/2019 17:12:16'!
initialize

	items _ Bag new.
	total _ 0.
	
	super initialize! !


!Purchase methodsFor: 'adding' stamp: 'AB 6/18/2019 17:13:23'!
add: anItem costing: anAmount

	items add: anItem.
	total _ total + anAmount! !


!classDefinition: #RestInterface category: #'TusLibros.com'!
Object subclass: #RestInterface
	instanceVariableNames: 'priceList merchantProcessor currentCartId clientsRecord salesBook activeSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!RestInterface methodsFor: 'initialization' stamp: 'AB 6/15/2019 00:41:49'!
initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord

	priceList _ aPriceList.
	merchantProcessor _ aMerchantProcessor.
	clientsRecord _ aUsersRecord.

	salesBook _ Dictionary new.
	activeSessions _ Dictionary new.
	currentCartId _ 1! !


!RestInterface methodsFor: 'cart creation' stamp: 'AB 6/15/2019 00:48:46'!
createCartFor: aClientId protectedWith: aPassword startingOn: aDatetime

	| aShoppingCart cartId |

	self assertClientExistsWith: aClientId and: aPassword.

	aShoppingCart _ ShoppingCart with: priceList.

	cartId _ currentCartId.	

	activeSessions at: currentCartId put: (ActiveSession for: aClientId with: aShoppingCart).

	currentCartId _ currentCartId + 1.

	^ cartId! !


!RestInterface methodsFor: 'clients records' stamp: 'AB 6/11/2019 22:54:47'!
assertClientExistsWith: aClientId and: aPassword

	 clientsRecord isRegisteredWith: aClientId and: aPassword! !


!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/15/2019 00:45:59'!
addTo: aShoppingCartId aBookWithCode: aBookISBN aQuantityOf: anAmount

	(activeSessions at: aShoppingCartId ifAbsent: [ self error: RestInterface shoppingCartNotFound ]) shoppingCart add: aBookISBN quantity: anAmount! !

!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/15/2019 01:19:19'!
checkOut: aShoppingCartId chargingToACreditCardNumbered: aCreditCardNumber expiringOn: aMonthOfYear ownedBy: ownersName 

	| cashier creditCard session clientSalesBook |
	
	creditCard _ CreditCard with: aCreditCardNumber with: aMonthOfYear with: ownersName.
	
	session _ activeSessions at: aShoppingCartId ifAbsent: [ self error: RestInterface shoppingCartNotFound ].
	
	clientSalesBook _ self salesBooksFor: session client.
	
	cashier _ Cashier with: session shoppingCart chargingTo: creditCard registeringOn: clientSalesBook startingOn: DateAndTime now using: merchantProcessor.
	
	cashier checkOut! !

!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/15/2019 00:47:11'!
listCart: aShoppingCartId

	^ (activeSessions at: aShoppingCartId ifAbsent: [ self error: RestInterface shoppingCartNotFound ]) shoppingCart items! !

!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/18/2019 17:18:50'!
listPurchasesFor: aClientId protectedBy: aPassword

	| clientsPurchase |

	self assertClientExistsWith: aClientId and: aPassword.

	clientsPurchase _ Purchase new.

	(self salesBooksFor: aClientId) do: [ :aSalesBook | 
		aSalesBook items do: [ :anItem | 
			clientsPurchase add: anItem costing: (priceList at: anItem) 
		] 
	].

	^ clientsPurchase! !

!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/15/2019 00:57:53'!
salesBooksFor: aClientId

	^ salesBook at: aClientId ifAbsentPut: [ OrderedCollection new ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #'TusLibros.com'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'error handling' stamp: 'AB 6/14/2019 14:04:48'!
clientCredentialsDoNotMatchAnyExistingClient
	
	^ 'Client credentials do not match any existing client'! !

!RestInterface class methodsFor: 'error handling' stamp: 'AB 6/14/2019 13:59:14'!
invalidClientId
	
	^ 'Client ID is invalid'! !

!RestInterface class methodsFor: 'error handling' stamp: 'AB 6/14/2019 13:59:25'!
invalidClientPassword
	
	^ 'Client password is invalid'! !

!RestInterface class methodsFor: 'error handling' stamp: 'AB 6/12/2019 17:12:31'!
shoppingCartNotFound
	
	^ 'Shopping Cart was not found'! !


!RestInterface class methodsFor: 'instance creation' stamp: 'AB 6/15/2019 00:32:39'!
withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord

	^ self new initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord! !


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


!ShoppingCart methodsFor: 'assertions' stamp: 'AB 6/10/2019 09:44:13'!
assertIsIncludedInPriceList: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: ShoppingCart priceListDoestNotIncludeItem ]! !

!ShoppingCart methodsFor: 'assertions' stamp: 'AB 6/1/2019 16:17:34'!
assertQuantityIsAnIntegerValueAndBiggerThenZero: aQuantity

	(aQuantity < 1) ifTrue: [ self error: ShoppingCart quantityMustBeBiggerThanOneError ].

	(aQuantity isInteger) ifFalse: [ self error: ShoppingCart quantityMustBeAnIntegerValue ]! !


!ShoppingCart methodsFor: 'adding' stamp: 'AB 6/10/2019 09:43:54'!
add: anItem

	self assertIsIncludedInPriceList: anItem.

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

!ShoppingCart class methodsFor: 'instance creation' stamp: 'AB 6/10/2019 09:47:06'!
with: aPriceList
	
	self assertThereAreNoItemsWithZeroOrLessCostsInPriceList: aPriceList.
	
	^ self new initializeWith: aPriceList! !


!ShoppingCart class methodsFor: 'error handling' stamp: 'AB 6/10/2019 09:47:06'!
assertThereAreNoItemsWithZeroOrLessCostsInPriceList: aPriceList

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


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros.com'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:32:28'!
anotherExistingISBN

	^ #book2! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:43:33'!
emptyPriceList

	^ Dictionary new! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:31:00'!
existingISBN

	^ #book1! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:43:50'!
oneItemPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: 100 * peso.
	
	^ priceList! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:44:07'!
oneItemWithCostLongerThan15DigitsPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: 1234567890123456 * peso.
	
	^ priceList! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:44:22'!
oneItemWithCostThreeDigitsInFractionPartPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: 1.234 * peso.
	
	^ priceList! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:44:36'!
oneNegativeItemPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: -100 * peso.
	
	^ priceList! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:44:49'!
threeItemsPriceList

	| priceList |
	
	priceList _ self twoItemsPriceList.
	priceList at: #book3 put: 300 * peso.
	
	^ priceList! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:45:02'!
twoItemsPriceList

	| priceList |
	
	priceList _ self oneItemPriceList.
	priceList at: self anotherExistingISBN put: 200 * peso.
	
	^ priceList! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AB 6/17/2019 16:23:19'!
emptyShoppingCart

	^ ShoppingCart with: self oneItemPriceList! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AB 6/17/2019 16:23:38'!
oneItemShoppingCart

	| shoppingCart |

	shoppingCart _ self emptyShoppingCart.
	shoppingCart add: self existingISBN.
	
	^ shoppingCart! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AB 6/17/2019 16:23:54'!
shoppingCartWithTotalCostLongerThan15Digits

	| shoppingCart |

	shoppingCart _ ShoppingCart with: self oneItemWithCostLongerThan15DigitsPriceList.
	shoppingCart add: self existingISBN.
	
	^ shoppingCart! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AB 6/17/2019 16:24:09'!
shoppingCartWithTotalCostThreeDigitsInFractionPart

	| shoppingCart |

	shoppingCart _ ShoppingCart with: self oneItemWithCostThreeDigitsInFractionPartPriceList.
	shoppingCart add: self existingISBN.
	
	^ shoppingCart! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:15:35'!
a0CharactersLongName

	^ ''! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:15:46'!
a15DigitsNumber

	^ '123456789012345'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:15:58'!
a16DigitsNumber

	^ '1234567890123456'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:16:30'!
a16DigitsStringWithNumbersAndLetters

	^ '123456789o123456'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:16:41'!
a17DigitsNumber

	^ '12345678901234567'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:16:54'!
a30CharactersLongName

	^ 'A Credit Card Name'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:17:07'!
a31CharactersLongName

	^ 'A really long credit card name!!'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:24:37'!
expiredCreditCard

	^ CreditCard
		with: self a16DigitsNumber
		with: self expiredMonthOfYear 
		with: self a30CharactersLongName ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AB 6/17/2019 16:25:29'!
workingCreditCard

	^ CreditCard 
		with: self a16DigitsNumber 
		with: self currentMonthOfYear
		with: self a30CharactersLongName! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'AB 6/18/2019 22:22:51'!
initialize

	today _ DateAndTime today.

	super initialize! !

!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'AB 6/17/2019 16:04:00'!
initializeStartingOn: aDateTime

	today _ aDateTime! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AB 6/17/2019 17:39:07'!
currentMonthOfYear

	^ GregorianMonthOfYear yearNumber: (today yearNumber) monthNumber: (today monthIndex)! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AB 6/17/2019 17:27:20'!
expiredMonthOfYear

	^ GregorianMonthOfYear yearNumber: (today yearNumber) monthNumber: (today monthIndex - 1)! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'sales book' stamp: 'AB 6/17/2019 16:55:37'!
emptySalesBook

	^ OrderedCollection new! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'AB 6/18/2019 12:38:05'!
aValidClienId
	
	^ 'Valid Client ID'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'AB 6/18/2019 12:38:24'!
aValidClientPassword

	^ 'Valid User Password'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'AB 6/18/2019 12:38:35'!
anInvalidClientId
	
	^ 'Invalid Client ID'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'AB 6/18/2019 12:38:47'!
anInvalidClientPassword

	^ 'Invalid Client Password'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'AB 6/18/2019 12:38:57'!
anotherValidClienId
	
	^ 'Another Valid Client ID'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'AB 6/18/2019 12:39:09'!
anotherValidClientPassword

	^ 'Another Valid User Password'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreTestObjectsFactory class' category: #'TusLibros.com'!
StoreTestObjectsFactory class
	instanceVariableNames: ''!

!StoreTestObjectsFactory class methodsFor: 'instance creation' stamp: 'AB 6/17/2019 16:11:38'!
startingOn: aDateTime

	^ self new initializeStartingOn: aDateTime! !
