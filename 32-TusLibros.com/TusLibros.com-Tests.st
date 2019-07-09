!classDefinition: #CashierTest category: #'TusLibros.com-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'debitBehavior testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Tests'!

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


!classDefinition: #CreditCardTest category: #'TusLibros.com-Tests'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Tests'!

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


!classDefinition: #RestInterfaceExternalTest category: #'TusLibros.com-Tests'!
TestCase subclass: #RestInterfaceExternalTest
	instanceVariableNames: 'testObjects loginBehavior debitBehavior aRestInterfaceWithAnEmptyPriceList aRestInterfaceWithOneItemPriceList aRestInterfaceWithTwoItemsPriceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Tests'!

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:04:40'!
debit: anAmount from: aCreditCard

	^ debitBehavior value: anAmount value: aCreditCard! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'JR 6/30/2019 18:20:45'!
isRegisteredWith: aClientId and: aPassword

	^ loginBehavior value: aClientId value: aPassword! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'JR 6/30/2019 18:44:09'!
responseMessageFrom: aString

	^ aString copyFrom: 3 to: aString size.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:52:31'!
setUp

	testObjects _ StoreTestObjectsFactory new.

	loginBehavior _ [ :aClientId :aPassword | ].

	debitBehavior _ [ :anAmount :aCreditCard | ].
	
	aRestInterfaceWithAnEmptyPriceList _ RestInterfaceExternal withCatalogue: testObjects emptyPriceList processingThrough: self signInUsersWith: self.

	aRestInterfaceWithOneItemPriceList _ RestInterfaceExternal withCatalogue: testObjects oneItemPriceList processingThrough: self signInUsersWith: self.

	aRestInterfaceWithTwoItemsPriceList _ RestInterfaceExternal withCatalogue: testObjects twoItemsPriceList processingThrough: self signInUsersWith: self! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/9/2019 12:04:01'!
test01ListingAnEmptyCatalogReturnAnOkResponseWithEmptyCatalog

	| catalog |

	catalog _ aRestInterfaceWithAnEmptyPriceList catalog.
	
	self assert: catalog isEmpty.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/9/2019 12:29:48'!
test02ListingACatalogReturnsAResponseIncludingListOfItems

	| catalog |

	catalog _ aRestInterfaceWithTwoItemsPriceList catalog.
	
	self assert: catalog size equals: testObjects twoItemsPriceList size.

	self assert: (catalog allSatisfy: [ :anItem | testObjects twoItemsPriceList keys anySatisfy: [ :aKey | (anItem indexOfSubCollection: aKey startingAt: 1) = 1 ] ]).
	
	self assert: (catalog allSatisfy: [ :anItem | testObjects twoItemsPriceList values anySatisfy: [ :aValue | (anItem indexOfSubCollection: aValue printString startingAt: 1) > 1 ] ]).! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:46:19'!
test03CreatingACartForValidClientReturnsOkRespondeWithCartId

	| createCartResponse interface |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.
		
	createCartResponse _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self assert: interface okResponsePrefix , '1' equals: createCartResponse! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:39:18'!
test04CreatingACartWithInvalidClientIdReturnsAnErrorResponse

	| createCartResponse interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal invalidClientId ].
	
	interface _ aRestInterfaceWithAnEmptyPriceList.
	
	createCartResponse _ interface 
		createCartFor: testObjects anInvalidClientId
		protectedWith: testObjects aValidClientPassword.
	
	self assert: createCartResponse equals: interface errorResponsePrefix, RestInterfaceInternal invalidClientId ! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:38:58'!
test05CreatingACartWithInvalidPasswordReturnsAnErrorResponse

	| createCartResponse interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal invalidClientPassword ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	createCartResponse _ interface
		createCartFor: testObjects anInvalidClientId
		protectedWith: testObjects aValidClientPassword.
	
	self assert: createCartResponse equals: interface errorResponsePrefix, RestInterfaceInternal invalidClientPassword.
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal clientCredentialsDoNotMatchAnyExistingClient ].
	
	createCartResponse _ interface
		createCartFor: testObjects anInvalidClientId
		protectedWith: testObjects aValidClientPassword.
		
	self assert: createCartResponse equals: interface errorResponsePrefix, RestInterfaceInternal clientCredentialsDoNotMatchAnyExistingClient.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:37:25'!
test06ListingAnEmptyCartReturnsAnOkResponseEmpty

	| createCartResponse interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.
		
	createCartResponse _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	shoppingCartId _ (self responseMessageFrom: createCartResponse) asInteger.
	
	self assert: (interface listCart: shoppingCartId) equals: interface okResponsePrefix.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:36:41'!
test07ListingUnexistingShoppingCartReturnsAnErrorResponse

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.
	
	self assert: (interface listCart: shoppingCartId) equals: interface errorResponsePrefix, RestInterfaceInternal shoppingCartNotFound ! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'JR 6/30/2019 19:19:54'!
test08OkResponseWhenAddingItemToShoppingCart

	| shoppingCartId interface createCartResponse |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	createCartResponse _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	shoppingCartId _ (self responseMessageFrom: createCartResponse) asInteger.

	self assert: (interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1)
		equals: interface okResponsePrefix, 'OK'.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'JR 6/30/2019 19:22:56'!
test09ErrorResponseWhenAddingInvalidItemToShoppingCart

	| shoppingCartId interface createCartResponse addItemResponse |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.
		
	createCartResponse _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	shoppingCartId _ (self responseMessageFrom: createCartResponse) asInteger.

	addItemResponse _ interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.
	
	self assert: addItemResponse equals: interface errorResponsePrefix , ShoppingCart priceListDoestNotIncludeItem.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/8/2019 15:59:27'!
test10WhenAddingAnItemToShoppingCartListingContainsElementAndQuantity

	| shoppingCartId interface createCartResponse |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	createCartResponse _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	shoppingCartId _ (self responseMessageFrom: createCartResponse) asInteger.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 2.

	self assert: (interface listCart: shoppingCartId) equals: interface okResponsePrefix, testObjects existingISBN, '|2|'! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:11:12'!
test11ListingPurchasesWhenNoCheckOutHasBeenDoneReturnsAnOkEmptyResponse

	| interface |

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self assert: (interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword) 
		equals: interface okResponsePrefix, '0'.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:36:18'!
test12ListingPurchasesForInvalidClientIdReturnsErrorResponse

	| interface |
	
	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal invalidClientId ].
	
	interface _ aRestInterfaceWithAnEmptyPriceList.

	self assert: (interface listPurchasesFor: testObjects anInvalidClientId protectedBy: testObjects aValidClientPassword) 
		equals: interface errorResponsePrefix , RestInterfaceInternal invalidClientId.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/8/2019 15:57:23'!
test13CheckingOutAddsContentToListPurchasesResponse

	| shoppingCartId interface createCartResponse quantity |
	
	quantity _ 2.
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	createCartResponse _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	shoppingCartId _ (self responseMessageFrom: createCartResponse) asInteger.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: quantity.
		
	interface 
		checkOut: shoppingCartId 
		chargingToACreditCardNumbered: testObjects a16DigitsNumber 
		expiringOn: testObjects currentMonthOfYearInDigits
		ownedBy: testObjects a30CharactersLongName.

	self assert: (interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword) equals: interface okResponsePrefix, testObjects existingISBN, '|' , quantity printString , '|' , ((testObjects oneItemPriceList at: testObjects existingISBN) * quantity) printString! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 19:10:32'!
test14CheckingOutAnInvalidShoppingCartGivesAnErrorResponse

	| interface checkOutResponse shoppingCartId |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	checkOutResponse _ interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYearInDigits 
			ownedBy: testObjects a30CharactersLongName.

	self assert: checkOutResponse equals: '1|', RestInterfaceInternal shoppingCartNotFound.
	! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 19:06:55'!
test15CheckingOutWithAnExpirationDateWithALengthDifferentToSixReturnsAnErrorResponse

	| interface checkOutResponse shoppingCartId |

	interface _ aRestInterfaceWithOneItemPriceList.

	checkOutResponse _ interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects anExpirationMonthOfYearWithFiveDigits
			ownedBy: testObjects a30CharactersLongName.

	self assert: checkOutResponse equals: '1|', RestInterfaceExternal expirationMonthOfYearMustBeExactlySixDigitsLong! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 19:37:36'!
test16CheckingOutWithAnExpirationDateContainingANonNumberReturnsAnErrorResponse

	| interface checkOutResponse shoppingCartId |

	interface _ aRestInterfaceWithOneItemPriceList.

	checkOutResponse _ interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects anExpirationMonthOfYearContainingANonNumber
			ownedBy: testObjects a30CharactersLongName.

	self assert: checkOutResponse equals: '1|', RestInterfaceExternal expirationMonthOfYearMustContainOnlyNumbers ! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 19:43:22'!
test17CheckingOutWithAnExpirationDateContainingANonExistingMonthNumberReturnsAnErrorResponse

	| interface checkOutResponse shoppingCartId |

	interface _ aRestInterfaceWithOneItemPriceList.

	checkOutResponse _ interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects anExpirationMonthOfYearContainingAnInvalidMonth
			ownedBy: testObjects a30CharactersLongName.

	self assert: checkOutResponse equals: '1|', RestInterfaceExternal expirationMonthOfYearMustContainAValidMonth! !


!classDefinition: #RestInterfaceInternalTest category: #'TusLibros.com-Tests'!
TestCase subclass: #RestInterfaceInternalTest
	instanceVariableNames: 'loginBehavior debitBehavior testObjects aRestInterfaceWithAnEmptyPriceList aRestInterfaceWithOneItemPriceList aRestInterfaceWithTwoItemsPriceList clock aRestInterfaceWithAnEmptyPriceListAndAClock aRestInterfaceWithOneItemPriceListAndAClock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Tests'!

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'JR 6/12/2019 23:05:32'!
debit: anAmount from: aCreditCard

	^ debitBehavior value: anAmount value: aCreditCard! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/11/2019 22:55:18'!
isRegisteredWith: aClientId and: aPassword

	^ loginBehavior value: aClientId value: aPassword! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
setUp

	testObjects _ StoreTestObjectsFactory new.

	loginBehavior _ [ :aClientId :aPassword | ].

	debitBehavior _ [ :anAmount :aCreditCard | ].
	
	clock _ Clock new.

	aRestInterfaceWithAnEmptyPriceList _ RestInterfaceInternal withCatalogue: testObjects emptyPriceList processingThrough: self signInUsersWith: self.

	aRestInterfaceWithAnEmptyPriceListAndAClock _ RestInterfaceInternal withCatalogue: testObjects emptyPriceList processingThrough: self signInUsersWith: self calculatingTimeFrom: clock.
	
	aRestInterfaceWithOneItemPriceList _ RestInterfaceInternal withCatalogue: testObjects oneItemPriceList processingThrough: self signInUsersWith: self.

	aRestInterfaceWithOneItemPriceListAndAClock _ RestInterfaceInternal withCatalogue: testObjects oneItemPriceList processingThrough: self signInUsersWith: self calculatingTimeFrom: clock.
	
	aRestInterfaceWithTwoItemsPriceList _ RestInterfaceInternal withCatalogue: testObjects twoItemsPriceList processingThrough: self signInUsersWith: self.! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:21:10'!
test01CreatingShoppingCartsReturnsUniqueIDs

	| aShoppingCartId anotherShoppingCartId interface |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.
		
	aShoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	anotherShoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self deny: aShoppingCartId = anotherShoppingCartId! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:19'!
test02CanNotCreateCartWithAnInvalidClientId

	| interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal invalidClientId ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface 
			createCartFor: testObjects anInvalidClientId
			protectedWith: testObjects aValidClientPassword
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal invalidClientId
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test03CanNotCreateCartWithAnInvalidClientPassword

	| interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal invalidClientPassword ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface 
			createCartFor: testObjects aValidClienId 
			protectedWith: testObjects anInvalidClientPassword
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal invalidClientPassword
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test04CanNotCreateCartForAnNonExistingClient

	| interface |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal clientCredentialsDoNotMatchAnyExistingClient ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface 
			createCartFor: testObjects aValidClienId 
			protectedWith: testObjects aValidClientPassword
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal clientCredentialsDoNotMatchAnyExistingClient 
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:21:32'!
test05ListingANewShoppingCartReturnsAnEmptyCollection

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self assert: (interface listCart: shoppingCartId) isEmpty! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test06CanNotListAShoppingCartWithAnNonExistingCartId

	| interface |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listCart: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test07CanAddItemInCatalogueToExistingShoppingCart

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self assert: (interface listCart: shoppingCartId) isEmpty.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

	self assert: (interface listCart: shoppingCartId) includes: testObjects existingISBN! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test08CanAddMoreThanOneItemToShoppingCart

	| shoppingCartId interface itemsOnCart |
	
	interface _ aRestInterfaceWithTwoItemsPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	itemsOnCart _ interface listCart: shoppingCartId.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.
	interface addTo: shoppingCartId anItemWithCode: testObjects anotherExistingISBN aQuantityOf: 2.

	self assert: itemsOnCart includes: testObjects existingISBN.
	self assert: 1 equals: (itemsOnCart occurrencesOf: testObjects existingISBN).
	
	self assert: itemsOnCart includes: testObjects anotherExistingISBN.
	self assert: 2 equals: (itemsOnCart occurrencesOf: testObjects anotherExistingISBN)! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test09CanNotAddItemToNonExistingShoppingCart

	| interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	self 
		should: [ interface 
			addTo: 1
			anItemWithCode: testObjects existingISBN aQuantityOf: 1
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test10CanNotAddItemNotInCatalogueToExistingShoppingCart

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self 
		should: [ interface  addTo: shoppingCartId anItemWithCode: testObjects anotherExistingISBN aQuantityOf: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart priceListDoestNotIncludeItem.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test11CanNotAddItemToShoppingCartWithQuantitySmallerThanOne

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self 
		should: [ interface addTo: shoppingCartId anItemWithCode: testObjects anotherExistingISBN aQuantityOf: 0 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart quantityMustBeBiggerThanOneError.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test12CanNotAddItemToShoppingCartWithANonIntegerAmount

	| shoppingCartId interface |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self 
		should: [ interface addTo: shoppingCartId anItemWithCode: testObjects anotherExistingISBN aQuantityOf: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart quantityMustBeAnIntegerValue.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test13ListingItemsOfAShoppingCartReturnsACollectionIncludingItsItems

	| shoppingCartId interface shoppingCartList |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	shoppingCartList _ interface listCart: shoppingCartId.
	self assert: shoppingCartList isEmpty.
	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.
	
	shoppingCartList _ interface listCart: shoppingCartId.

	self deny: shoppingCartList isEmpty.
	self assert: (shoppingCartList includes: testObjects existingISBN)! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test14CanNotListPurchasesWithAnInvalidClientId

	| interface |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal invalidClientId ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listPurchasesFor: testObjects anInvalidClientId protectedBy: testObjects aValidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal invalidClientId
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test15CanNotListPurchasesWithAnInvalidPassword

	| interface |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal invalidClientPassword ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects anInvalidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal invalidClientPassword
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test16CanNotListPurchasesForAnNonExistingClient

	| interface |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterfaceInternal clientCredentialsDoNotMatchAnyExistingClient ].

	interface _ aRestInterfaceWithAnEmptyPriceList.

	self 
		should: [ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal clientCredentialsDoNotMatchAnyExistingClient
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:22:16'!
test17CanNotCheckOutAnEmptyCart

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

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

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test18CanNotCheckOutWithAnExpiredCreditCard

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

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

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test19CanNotCheckOutWithANonExistingShoppingCartId

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
	
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: 2
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test20CanNotCheckOutWithAnInvalidCreditCardName

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
	
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

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

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test21CanNotCheckOutWithAnInvalidCreditCardNumber

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

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

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test22ListingPurchasesBeforeCheckingOutReturnsEmptyCollection

	| interface shoppingCartId |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.
	
	self assert: (interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword) items isEmpty! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test23WhenCheckingOutClientNowRegistersANewPurchase

	| interface shoppingCartId clientPurchases |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.
	
	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.

	self assert: clientPurchases items isEmpty.

	interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.
				
	self deny: clientPurchases items isEmpty! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test24WhenCheckingOutClientNowRegistersANewPurchaseAndItsTotalCost

	| interface shoppingCartId clientPurchases |
		
	interface _ aRestInterfaceWithOneItemPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

	interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.
				
	self assert: (clientPurchases items occurrencesOf: testObjects existingISBN) equals: 1.
	self assert: (testObjects oneItemPriceList at: testObjects existingISBN) = clientPurchases totalAmount! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test25WhenCheckingOutDifferentClientsPurchasesAreRegisteredIndividually

	| interface shoppingCartId anotherShoppingCartId anotherClientPurchases clientPurchases |
		
	interface _ aRestInterfaceWithTwoItemsPriceList.
		
	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	anotherShoppingCartId _ interface 
		createCartFor: testObjects anotherValidClienId
		protectedWith: testObjects anotherValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.
	
	interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	interface addTo: anotherShoppingCartId anItemWithCode: testObjects anotherExistingISBN aQuantityOf: 2.

	interface 
			checkOut: anotherShoppingCartId 
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear
			ownedBy: testObjects a30CharactersLongName.

	clientPurchases _ interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword.

	self assert: (clientPurchases items occurrencesOf: testObjects existingISBN) equals: 1.
	self deny: (clientPurchases items includes: testObjects anotherExistingISBN).
	self assert: (testObjects twoItemsPriceList at: testObjects existingISBN) = clientPurchases totalAmount.

	anotherClientPurchases _ interface listPurchasesFor: testObjects anotherValidClienId protectedBy: testObjects anotherValidClientPassword.
	
	self assert: (anotherClientPurchases items occurrencesOf: testObjects anotherExistingISBN) equals: 2.
	self deny: (anotherClientPurchases items includes: testObjects existingISBN).
	self assert: (testObjects twoItemsPriceList at: testObjects anotherExistingISBN) * 2 = anotherClientPurchases totalAmount! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:23:23'!
test26CreatingAShoppingCartIsNotExpired

	| interface shoppingCartId |

	interface _ aRestInterfaceWithAnEmptyPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	self deny: (interface shoppingCartIsExpired: shoppingCartId)! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:23:28'!
test27AShoppingCartGetsExpiredAfterThirtyMinutes

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	clock add: (Duration minutes: 30).

	self assert: (interface shoppingCartIsExpired: shoppingCartId)! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test28CanNotListContentsOfExpiredShoppingCart

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	clock add: (Duration minutes: 30).

	self 
		should: [ interface listCart: shoppingCartId ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartHasExpired
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test29CanNotListAddItemToExpiredShoppingCart

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	clock add: (Duration minutes: 30).

	self 
		should: [ interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartHasExpired
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test30CanNotCheckOutExpiredShoppingCart

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithOneItemPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

	clock add: (Duration minutes: 30).

	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartHasExpired
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:23:48'!
test31AShoppingCartExpirationGetsRestartedWhenListingItsContents

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	clock add: (Duration minutes: 29).

	interface listCart: shoppingCartId.

	clock add: (Duration minutes: 1).
	
	self deny: (interface shoppingCartIsExpired: shoppingCartId)! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/22/2019 12:37:27'!
test32AShoppingCartExpirationGetsRestartedWhenAddingAnItem

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithOneItemPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	clock add: (Duration minutes: 29).

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

	clock add: (Duration minutes: 1).
	
	self deny: (interface shoppingCartIsExpired: shoppingCartId)! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test33CanNotFindShoppingCartAfterListingContentsOfExpiredShoppingCart

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	clock add: (Duration minutes: 30).

	self 
		should: [ interface listCart: shoppingCartId ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartHasExpired
		].

	self 
		should: [ interface listCart: shoppingCartId ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound 
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test34CanNotFindShoppingCartAfterAddinAnItemToExpiredShoppingCart

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithAnEmptyPriceListAndAClock.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	clock add: (Duration minutes: 30).

	self 
		should: [ interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartHasExpired
		].

	self 
		should: [ interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound
		]! !

!RestInterfaceInternalTest methodsFor: 'testing' stamp: 'AB 6/30/2019 16:53:20'!
test35SendingMessagesToAnAlreadyCheckedOutShoppingReturnsException

	| interface shoppingCartId |
	
	interface _ aRestInterfaceWithOneItemPriceList.

	shoppingCartId _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1.

	interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName.

	self 
		should: [ interface listCart: shoppingCartId ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound
		].

	self 
		should: [ interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound
		].
	
	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: testObjects a16DigitsNumber 
			expiringOn: testObjects currentMonthOfYear 
			ownedBy: testObjects a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterfaceInternal shoppingCartNotFound
		]! !


!classDefinition: #ShoppingCartTest category: #'TusLibros.com-Tests'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Tests'!

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


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros.com-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Tests'!

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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AB 6/17/2019 16:45:02'!
twoItemsPriceList

	| priceList |
	
	priceList _ self oneItemPriceList.
	priceList at: self anotherExistingISBN put: 200 * peso.
	
	^ priceList! !


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


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'AB 6/24/2019 12:09:40'!
initialize

	self initializeStartingOn: DateAndTime today.

	super initialize! !

!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'AB 6/17/2019 16:04:00'!
initializeStartingOn: aDateTime

	today _ aDateTime! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AB 7/1/2019 19:38:02'!
anExpirationMonthOfYearContainingANonNumber

	^ '062o19'! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AB 7/1/2019 19:43:39'!
anExpirationMonthOfYearContainingAnInvalidMonth

	^ '132019'! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AB 7/1/2019 19:05:33'!
anExpirationMonthOfYearWithFiveDigits

	^ '62019'! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AB 6/17/2019 17:39:07'!
currentMonthOfYear

	^ GregorianMonthOfYear yearNumber: (today yearNumber) monthNumber: (today monthIndex)! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AB 7/1/2019 19:23:51'!
currentMonthOfYearInDigits

	| monthNumber monthNumberAsString |
	
	monthNumber _ today monthIndex.

	monthNumberAsString _ ''.

	(monthNumber < 10) ifTrue: [ monthNumberAsString _ '0' ].

	^ monthNumberAsString , monthNumber printString , today yearNumber printString! !

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
