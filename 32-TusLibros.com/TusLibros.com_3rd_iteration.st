!classDefinition: #CashierTest category: #'TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 14:28:58'!
debit: anAmount from: aCreditCard

	^ debitBehavior value: anAmount value: aCreditCard! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 14:29:27'!
setUp 

	debitBehavior _ [ :anAmount :aCreditCard | ]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test01CanNotCreateCashierForAnEmptyCart

	| aMerchantProcessor |
	
	self should: [ 
		Cashier 
			with: TestableObjectsFactory emptyShoppingCart 
			chargingTo: TestableObjectsFactory workingCreditCard 
			registeringOn: TestableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier shoppingCartCanNotBeEmpty.
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test02CanNotCreateCashierWithExpiredCreditCard

	| aMerchantProcessor |

	self should: [ 
		Cashier 
			with: TestableObjectsFactory oneItemShoppingCart 
			chargingTo: TestableObjectsFactory expiredCreditCard 
			registeringOn: TestableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier expiredCreditCardIsNotValid
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test03CheckingOutIncreasesSalesAmount

	| cashier salesBook |

	salesBook _ TestableObjectsFactory emptySalesBook.

	cashier _ Cashier 
		with: TestableObjectsFactory oneItemShoppingCart 
		chargingTo: TestableObjectsFactory workingCreditCard 
		registeringOn: salesBook
		startingOn: Date today
		using: self.

	self assert: salesBook isEmpty.

	cashier checkOut.

	self assert: 1 equals: salesBook size! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test04CanNotCreateCashierForATotalCostWithMoreThan15DigitsForItsIntegerPart

	| aMerchantProcessor |

	self should: [ 
		Cashier 
			with: TestableObjectsFactory shoppingCartWithTotalCostLongerThan15Digits 
			chargingTo: TestableObjectsFactory workingCreditCard 
			registeringOn: TestableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier totalCostCanNotBeLongerThan15DigitsInItsIntegerPart
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test05CanNotCreateCashierForATotalCostWithMoreThan2DigitsInFractionPart

	| aMerchantProcessor |
	
	self should: [ 
		Cashier 
			with: TestableObjectsFactory shoppingCartWithTotalCostThreeDigitsInFractionPart 
			chargingTo: TestableObjectsFactory workingCreditCard 
			registeringOn: TestableObjectsFactory emptySalesBook
			startingOn: Date today
			using: aMerchantProcessor
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier totalCostCanNotBeLongerThan2DigitsInItsFractionPart
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test06CanNotCheckOutWhenCreditCardIsWithoutFunds

	| cashier salesBook |

 	debitBehavior _ [ :anAmount :aCreditCard | self error: Cashier creditCardHasInsufficientFunds ].

	salesBook _ TestableObjectsFactory emptySalesBook.

	cashier _ Cashier 
		with: TestableObjectsFactory oneItemShoppingCart 
		chargingTo: TestableObjectsFactory workingCreditCard 
		registeringOn: salesBook
		startingOn: Date today
		using: self.
	
	self should: [ cashier checkOut ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier creditCardHasInsufficientFunds.
		self assert: salesBook isEmpty
		]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test07CanNotCheckOutWhenCreditCardHasReportedStolen

	| cashier salesBook |

 	debitBehavior _ [ :anAmount :aCreditCard | self error: Cashier creditCardHasBeenReportedStolen ].

	salesBook _ TestableObjectsFactory emptySalesBook.

	cashier _ Cashier 
		with: TestableObjectsFactory oneItemShoppingCart 
		chargingTo: TestableObjectsFactory workingCreditCard 
		registeringOn: salesBook
		startingOn: Date today
		using: self.
	
	self should: [ cashier checkOut ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier creditCardHasBeenReportedStolen.
		self assert: salesBook isEmpty
		]! !


!classDefinition: #CreditCardTest category: #'TusLibros.com'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:46:56'!
test01SizeOfNumberMustBeExactly16CharactersLong
	
	self should: [ 
		CreditCard 
			with: TestableObjectsFactory a15DigitsNumber 
			with: TestableObjectsFactory currentMonthOfYear 
			with: TestableObjectsFactory a30CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	].

	self should: [ 
		CreditCard 
			with: TestableObjectsFactory a17DigitsNumber 
			with: TestableObjectsFactory currentMonthOfYear 
			with: TestableObjectsFactory a30CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	]! !

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:46:56'!
test02OwnerNameShorterThan1CharacterAndLargerThan30ReturnsError
	
	self should: [ 
		CreditCard 
			with: TestableObjectsFactory a16DigitsNumber 
			with: TestableObjectsFactory currentMonthOfYear 
			with: TestableObjectsFactory a0CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong
	].

	self should: [ 
		CreditCard 
			with: TestableObjectsFactory a16DigitsNumber 
			with: TestableObjectsFactory currentMonthOfYear 
			with: TestableObjectsFactory a31CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong
	]! !

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:46:56'!
test03CreditCardNumberContainsOnlyNumbers
	
	self should: [ 
		CreditCard 
			with: TestableObjectsFactory a16DigitsStringWithNumbersAndLetters 
			with: TestableObjectsFactory currentMonthOfYear 
			with: TestableObjectsFactory a0CharactersLongName 
		]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustContainOnlyNumbers 
	]! !


!classDefinition: #RestInterfaceTest category: #'TusLibros.com'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'loginBehavior debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!RestInterfaceTest methodsFor: 'testing' stamp: 'JR 6/12/2019 23:05:32'!
debit: anAmount from: aCreditCard

	^ debitBehavior value: anAmount value: aCreditCard! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/11/2019 22:55:18'!
isRegisteredWith: aClientId and: aPassword

	^ loginBehavior value: aClientId value: aPassword! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'JR 6/12/2019 23:06:59'!
setUp 

	loginBehavior _ [ :aClientId :aPassword | ].

	debitBehavior _ [ :anAmount :aCreditCard | ]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 13:15:51'!
test01CreatingShoppingCartsReturnsUniqueIDs

	| aShoppingCartId anotherShoppingCartId interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory emptyPriceList 
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	aShoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	anotherShoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	self deny: aShoppingCartId = anotherShoppingCartId! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:01:14'!
test02CanNotCreateCartWithAnInvalidClientId

	| interface aMerchantProcessor |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientId ].

	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory emptyPriceList 
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.

	self 
		should: [ interface 
			createCartFor: TestableObjectsFactory anInvalidClientId
			protectedWith: TestableObjectsFactory aValidClientPassword
			startingOn: DateAndTime today
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientId
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:01:21'!
test03CanNotCreateCartWithAnInvalidClientPassword

	| interface aMerchantProcessor |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientPassword ].

	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory emptyPriceList 
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.

	self 
		should: [ interface 
			createCartFor: TestableObjectsFactory aValidClienId 
			protectedWith: TestableObjectsFactory anInvalidClientPassword 
			startingOn: DateAndTime today
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientPassword
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 14:04:43'!
test04CanNotCreateCartForAnNonExistingClient

	| interface aMerchantProcessor |
	
 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface clientCredentialsDoNotMatchAnyExistingClient ].

	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory emptyPriceList 
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.

	self 
		should: [ interface 
			createCartFor: TestableObjectsFactory aValidClienId 
			protectedWith: TestableObjectsFactory aValidClientPassword 
			startingOn: DateAndTime today
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface clientCredentialsDoNotMatchAnyExistingClient 
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 14:06:08'!
test05ListingANewShoppingCartReturnsAnEmptyCollection

	| shoppingCartId interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	self assert: (interface listCart: shoppingCartId) isEmpty! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 14:06:58'!
test06CanNotListAShoppingCartWithAnNonExistingCartId

	| interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self 
		recordingTo: TestableObjectsFactory emptySalesBook.		

	self 
		should: [ interface listCart: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface shoppingCartNotFound
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 14:51:16'!
test07CanAddItemInCatalogueToExistingShoppingCart

	| shoppingCartId interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	self assert: (interface listCart: shoppingCartId) isEmpty.

	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1.

	self assert: (interface listCart: shoppingCartId) includes: TestableObjectsFactory existingISBN! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 13:41:31'!
test08CanAddMoreThanOneItemToShoppingCart

	| shoppingCartId interface aMerchantProcessor itemsOnCart |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory twoItemsPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	itemsOnCart _ interface listCart: shoppingCartId.

	self assert: itemsOnCart isEmpty.

	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1.
	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory anotherExistingISBN aQuantityOf: 2.

	self deny: itemsOnCart isEmpty.

	self assert: itemsOnCart includes: TestableObjectsFactory existingISBN.
	self assert: 1 equals: (itemsOnCart occurrencesOf: TestableObjectsFactory existingISBN).
	
	self assert: itemsOnCart includes: TestableObjectsFactory anotherExistingISBN.
	self assert: 2 equals: (itemsOnCart occurrencesOf: TestableObjectsFactory anotherExistingISBN)! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:52:09'!
test09CanNotAddItemToNonExistingShoppingCart

	| interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.

	self 
		should: [ interface 
			addTo: 1
			aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface shoppingCartNotFound
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 14:53:48'!
test10CanNotAddItemNotInCatalogueToExistingShoppingCart

	| shoppingCartId interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	self 
		should: [ interface  addTo: shoppingCartId aBookWithCode: TestableObjectsFactory anotherExistingISBN aQuantityOf: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart priceListDoestNotIncludeItem.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 14:54:37'!
test11CanNotAddItemToShoppingCartWithQuantitySmallerThanOne

	| shoppingCartId interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	self 
		should: [ interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory anotherExistingISBN aQuantityOf: 0 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart quantityMustBeBiggerThanOneError.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 14:55:12'!
test12CanNotAddItemToShoppingCartWithANonIntegerAmount

	| shoppingCartId interface aMerchantProcessor |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	self 
		should: [ interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory anotherExistingISBN aQuantityOf: 1.5 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ShoppingCart quantityMustBeAnIntegerValue
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:12:03'!
test13ListingItemsOfAShoppingCartReturnsACollectionIncludingItsItems

	| shoppingCartId interface aMerchantProcessor shoppingCartList |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.

	shoppingCartList _ interface listCart: shoppingCartId.
	self assert: shoppingCartList isEmpty.
	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1.
	
	shoppingCartList _ interface listCart: shoppingCartId.

	self deny: shoppingCartList isEmpty.
	self assert: (shoppingCartList includes: TestableObjectsFactory existingISBN)! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:03:48'!
test14CanNotListPurchasesWithAnInvalidClientId

	| interface aMerchantProcessor |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientId ].

	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self 
		recordingTo: TestableObjectsFactory emptySalesBook.		

	self 
		should: [ interface listPurchasesFor: TestableObjectsFactory anInvalidClientId protectedBy: TestableObjectsFactory aValidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientId
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:04:24'!
test15CanNotListPurchasesWithAnInvalidPassword

	| interface aMerchantProcessor |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface invalidClientPassword ].

	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self 
		recordingTo: TestableObjectsFactory emptySalesBook.		

	self 
		should: [ interface listPurchasesFor: TestableObjectsFactory aValidClienId protectedBy: TestableObjectsFactory anInvalidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface invalidClientPassword
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:08:42'!
test16CanNotListPurchasesForAnNonExistingClient

	| interface aMerchantProcessor |

 	loginBehavior _ [ :aClientId :aPassword | self error: RestInterface clientCredentialsDoNotMatchAnyExistingClient ].

	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self 
		recordingTo: TestableObjectsFactory emptySalesBook.		

	self 
		should: [ interface listPurchasesFor: TestableObjectsFactory aValidClienId protectedBy: TestableObjectsFactory aValidClientPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface clientCredentialsDoNotMatchAnyExistingClient
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:46:56'!
test17CanNotCheckOutAnEmptyCart

	| interface aMerchantProcessor shoppingCartId |
	
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.		

	self 
		should: [ interface 
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: TestableObjectsFactory a16DigitsNumber 
			expiringOn: TestableObjectsFactory currentMonthOfYear
			ownedBy: TestableObjectsFactory a30CharactersLongName
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier shoppingCartCanNotBeEmpty.
			self assert: (interface listCart: shoppingCartId) isEmpty
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:54:24'!
test18CanNotCheckOutWithAnExpiredCreditCard

	| interface shoppingCartId |
		
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: self
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.		

	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: shoppingCartId 
			chargingToACreditCardNumbered: TestableObjectsFactory a16DigitsNumber 
			expiringOn: TestableObjectsFactory expiredMonthOfYear 
			ownedBy: TestableObjectsFactory a30CharactersLongName
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier expiredCreditCardIsNotValid
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:56:02'!
test19CanNotCheckOutWithANonExistingShoppingCartId

	| interface shoppingCartId |
		
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: self
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.		

	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: 2
			chargingToACreditCardNumbered: TestableObjectsFactory a16DigitsNumber 
			expiringOn: TestableObjectsFactory currentMonthOfYear 
			ownedBy: TestableObjectsFactory a30CharactersLongName
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RestInterface shoppingCartNotFound
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:57:13'!
test20CanNotCheckOutWithAnInvalidCreditCardName

	| interface shoppingCartId |
		
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: self
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.		

	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: TestableObjectsFactory a16DigitsNumber 
			expiringOn: TestableObjectsFactory currentMonthOfYear 
			ownedBy: TestableObjectsFactory a31CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong 
		].
	
		self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: TestableObjectsFactory a16DigitsNumber 
			expiringOn: TestableObjectsFactory currentMonthOfYear 
			ownedBy: TestableObjectsFactory a0CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard ownerNameMustBeBetween1And30CharactersLong 
		]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'AB 6/14/2019 15:59:21'!
test21CanNotCheckOutWithAnInvalidCreditCardNumber

	| interface shoppingCartId |
		
	interface _ RestInterface 
		withCatalogue: TestableObjectsFactory oneItemPriceList
		processingThrough: self
		signInUsersWith: self
		recordingTo: TestableObjectsFactory emptySalesBook.
		
	shoppingCartId _ interface 
		createCartFor: TestableObjectsFactory aValidClienId
		protectedWith: TestableObjectsFactory aValidClientPassword
		startingOn: DateAndTime today.		

	interface addTo: shoppingCartId aBookWithCode: TestableObjectsFactory existingISBN aQuantityOf: 1.

	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: TestableObjectsFactory a15DigitsNumber 
			expiringOn: TestableObjectsFactory currentMonthOfYear 
			ownedBy: TestableObjectsFactory a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
		].
	
	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: TestableObjectsFactory a17DigitsNumber 
			expiringOn: TestableObjectsFactory currentMonthOfYear 
			ownedBy: TestableObjectsFactory a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong 
		].
	
	self 
		should: [ interface
			checkOut: shoppingCartId
			chargingToACreditCardNumbered: TestableObjectsFactory a16DigitsStringWithNumbersAndLetters 
			expiringOn: TestableObjectsFactory currentMonthOfYear 
			ownedBy: TestableObjectsFactory a30CharactersLongName 
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CreditCard cardNumberMustContainOnlyNumbers 
		]! !


!classDefinition: #ShoppingCartTest category: #'TusLibros.com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test01CreateNewShoppingCartIsEmptyCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory emptyPriceList.
	
	self assert: shoppingCart isEmpty.
	self assert: 0 * peso equals: shoppingCart totalCost! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test02WhenAddingBookToShoppingCarItIsNotEmpty

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory oneItemPriceList.
	
	shoppingCart add: #book1.
	
	self deny: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test03WhenAddingABookToShoppingCartCanCheckIsThere

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory oneItemPriceList.
	
	shoppingCart add: #book1.
	
	self deny: shoppingCart isEmpty.
	self assert: (shoppingCart contains: #book1)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test04AddingTwoBooksMakesSizeTwoAndBothAreContained

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory twoItemsPriceList.
	
	shoppingCart add: #book1.
	shoppingCart add: #book2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #book1).
	self assert: (shoppingCart contains: #book2)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test05AddTwoCopiesOfTheSameBookAssertInclusionInCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory oneItemPriceList.
	
	shoppingCart add: #book1 quantity: 2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #book1)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test06AddingABookWithAQuantityLessThan1ThrowsAnError

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory oneItemPriceList.
	
	self should: [shoppingCart add: #book1 quantity: 0]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart quantityMustBeBiggerThanOneError.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test07AShoppingCartReturnsNumberOfCopiesOfABook 

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory oneItemPriceList.
	self assert: 0 equals: (shoppingCart quantityOf: #book1).
	
	shoppingCart add: #book1 quantity: 3.
	self assert: 3 equals: (shoppingCart quantityOf: #book1)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test08AShoppingCartReturnsCollectionWithTheBooksItContains

	| shoppingCart items |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory threeItemsPriceList.
	
	shoppingCart add: #book1 quantity: 1.
	shoppingCart add: #book2 quantity: 2.
	shoppingCart add: #book3 quantity: 3.
	
	items _ shoppingCart items.
	
	self assert: (items includes: #book1).
	self assert: (items includes: #book2).
	self assert: (items includes: #book3)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test09CanNotAddANotIntegerQuantityOfBooksToCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory oneItemPriceList.
	
	self should: [shoppingCart add: #book1 quantity: 2.5]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart quantityMustBeAnIntegerValue.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test10CanNotAddABookNotIncludedTheCatalogue

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: TestableObjectsFactory oneItemPriceList.
	
	self should: [shoppingCart add: #book2 quantity: 2]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart priceListDoestNotIncludeItem.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test11WhenAddingBookToShoppingCartCostIncreases

	| shoppingCart priceList |
	
	priceList _ TestableObjectsFactory oneItemPriceList.
	shoppingCart _ ShoppingCart with: priceList.

	self assert: 0 * peso equals: shoppingCart totalCost.
		
	shoppingCart add: #book1.
	
	self assert: (priceList at: #book1) equals: shoppingCart totalCost! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/11/2019 19:44:16'!
test12CanNotCreateAShoppingCartWithAnItemWithNegativeCostInPriceList

	self should: [ ShoppingCart with: TestableObjectsFactory oneNegativeItemPriceList ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart canNotHaveItemsWithNegativeCostInPriceList	
	]
	! !


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


!CreditCard methodsFor: 'expiration' stamp: 'AB 6/6/2019 19:59:27'!
isExpiredOn: aMonthOfYear

	^ expiration < aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error handling' stamp: 'AB 6/10/2019 11:26:50'!
assertCardNumberContainsOnlyNumbers: a16DigitsNumber
	
	(a16DigitsNumber allSatisfy: [ :character | character digitValue between: 0 and: 9 ]) ifFalse: [ self error: CreditCard cardNumberMustContainOnlyNumbers ]! !

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


!CreditCard class methodsFor: 'instance creation' stamp: 'AB 6/10/2019 11:16:12'!
with: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersName

	self assertCardNumberContainsOnlyNumbers: a16DigitsNumber.

	self assertCardNumberIs16DigitsLong: a16DigitsNumber.

	self assertOwnersNameBetween1And30CharactersLong: anOwnersName.

	^ self new initializeWith: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersName! !


!classDefinition: #RestInterface category: #'TusLibros.com'!
Object subclass: #RestInterface
	instanceVariableNames: 'priceList merchantProcessor currentCartId clientsRecord activeShoppingCarts salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!RestInterface methodsFor: 'initialization' stamp: 'JR 6/12/2019 23:08:17'!
initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord recordingTo: aSalesBook

	priceList _ aPriceList.
	merchantProcessor _ aMerchantProcessor.
	clientsRecord _ aUsersRecord.
	salesBook _ aSalesBook.

	activeShoppingCarts _ Dictionary new.	
	currentCartId _ 1! !


!RestInterface methodsFor: 'cart creation' stamp: 'AB 6/14/2019 13:18:09'!
createCartFor: aClientId protectedWith: aPassword startingOn: aDatetime

	| aShoppingCart cartId |

	self assertClientExistsWith: aClientId and: aPassword.

	aShoppingCart _ ShoppingCart with: priceList.

	cartId _ currentCartId.	

	activeShoppingCarts at: currentCartId put: aShoppingCart.

	currentCartId _ currentCartId + 1.

	^ cartId! !


!RestInterface methodsFor: 'clients records' stamp: 'AB 6/11/2019 22:54:47'!
assertClientExistsWith: aClientId and: aPassword

	 clientsRecord isRegisteredWith: aClientId and: aPassword! !


!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/14/2019 13:28:40'!
addTo: aShoppingCartId aBookWithCode: aBookISBN aQuantityOf: anAmount

	(activeShoppingCarts at: aShoppingCartId ifAbsent: [ self error: RestInterface shoppingCartNotFound ]) add: aBookISBN quantity: anAmount! !

!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/14/2019 15:40:16'!
checkOut: aShoppingCartId chargingToACreditCardNumbered: aCreditCardNumber expiringOn: aMonthOfYear ownedBy: ownersName 

	| cashier shoppingCart creditCard |
	
	creditCard _ CreditCard with: aCreditCardNumber with: aMonthOfYear with: ownersName.
	
	shoppingCart _ activeShoppingCarts at: aShoppingCartId ifAbsent: [ self error: RestInterface shoppingCartNotFound ].
	
	cashier _ Cashier with: shoppingCart chargingTo: creditCard registeringOn: salesBook startingOn: DateAndTime now using: merchantProcessor.
	
	cashier checkOut! !

!RestInterface methodsFor: 'cart accessing' stamp: 'AB 6/14/2019 13:22:34'!
listCart: aShoppingCartId

	^ (activeShoppingCarts at: aShoppingCartId ifAbsent: [ self error: RestInterface shoppingCartNotFound ]) items! !

!RestInterface methodsFor: 'cart accessing' stamp: 'JR 6/12/2019 23:08:49'!
listPurchasesFor: aClientId protectedBy: aPassword

	self assertClientExistsWith: aClientId and: aPassword.
	
	^ salesBook ! !

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


!RestInterface class methodsFor: 'instance creation' stamp: 'AB 6/11/2019 22:39:55'!
withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord recordingTo: aSalesBook

	^ self new initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord recordingTo: aSalesBook! !


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


!classDefinition: #TestableObjectsFactory category: #'TusLibros.com'!
Object subclass: #TestableObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestableObjectsFactory class' category: #'TusLibros.com'!
TestableObjectsFactory class
	instanceVariableNames: ''!

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/11/2019 23:40:51'!
anotherExistingISBN

	^ #book2! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:01:58'!
emptyPriceList

	^ Dictionary new! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/11/2019 23:05:36'!
existingISBN

	^ #book1! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/11/2019 23:05:59'!
oneItemPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: 100 * peso.
	
	^ priceList! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/11/2019 23:06:05'!
oneItemWithCostLongerThan15DigitsPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: 1234567890123456 * peso.
	
	^ priceList! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/11/2019 23:06:10'!
oneItemWithCostThreeDigitsInFractionPartPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: 1.234 * peso.
	
	^ priceList! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/11/2019 23:06:15'!
oneNegativeItemPriceList

	| priceList |
	
	priceList _ self emptyPriceList.
	priceList at: self existingISBN put: -100 * peso.
	
	^ priceList! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/8/2019 11:56:49'!
threeItemsPriceList

	| priceList |
	
	priceList _ self twoItemsPriceList.
	priceList at: #book3 put: 300 * peso.
	
	^ priceList! !

!TestableObjectsFactory class methodsFor: 'price lists' stamp: 'AB 6/11/2019 23:41:05'!
twoItemsPriceList

	| priceList |
	
	priceList _ self oneItemPriceList.
	priceList at: self anotherExistingISBN put: 200 * peso.
	
	^ priceList! !


!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:02'!
a0CharactersLongName

	^ ''! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:44'!
a15DigitsNumber

	^ '123456789012345'! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:54'!
a16DigitsNumber

	^ '1234567890123456'! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/10/2019 11:25:37'!
a16DigitsStringWithNumbersAndLetters

	^ '123456789o123456'! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:13:36'!
a17DigitsNumber

	^ '12345678901234567'! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:17'!
a30CharactersLongName

	^ 'A Credit Card Name'! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/8/2019 11:10:29'!
a31CharactersLongName

	^ 'A really long credit card name!!'! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/14/2019 15:46:56'!
currentMonthOfYear

	^ GregorianMonthOfYear current! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/14/2019 15:50:19'!
expiredCreditCard

	^ CreditCard
		with: self a16DigitsNumber
		with: self expiredMonthOfYear 
		with: self a30CharactersLongName ! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/14/2019 15:50:03'!
expiredMonthOfYear

	^ GregorianMonthOfYear year: (GregorianMonthOfYear current year) monthNumber: (GregorianMonthOfYear current monthNumber -1)! !

!TestableObjectsFactory class methodsFor: 'credit card' stamp: 'AB 6/14/2019 15:46:56'!
workingCreditCard

	^ CreditCard 
		with: self a16DigitsNumber 
		with: self currentMonthOfYear
		with: self a30CharactersLongName! !


!TestableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/8/2019 11:53:07'!
emptyShoppingCart

	^ ShoppingCart with: self oneItemPriceList! !

!TestableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/11/2019 23:41:29'!
oneItemShoppingCart

	| shoppingCart |

	shoppingCart _ self emptyShoppingCart.
	shoppingCart add: self existingISBN.
	
	^ shoppingCart! !

!TestableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/11/2019 23:41:39'!
shoppingCartWithTotalCostLongerThan15Digits

	| shoppingCart |

	shoppingCart _ ShoppingCart with: self oneItemWithCostLongerThan15DigitsPriceList.
	shoppingCart add: self existingISBN.
	
	^ shoppingCart! !

!TestableObjectsFactory class methodsFor: 'shopping cart' stamp: 'AB 6/11/2019 23:41:46'!
shoppingCartWithTotalCostThreeDigitsInFractionPart

	| shoppingCart |

	shoppingCart _ ShoppingCart with: self oneItemWithCostThreeDigitsInFractionPartPriceList.
	shoppingCart add: self existingISBN.
	
	^ shoppingCart! !


!TestableObjectsFactory class methodsFor: 'sales book' stamp: 'AB 6/8/2019 11:18:12'!
emptySalesBook

	^ OrderedCollection new! !


!TestableObjectsFactory class methodsFor: 'rest interface' stamp: 'AB 6/11/2019 22:41:02'!
workingRestInterface
	
	| aMerchantProcessor aUsersRecord |
	
	^ RestInterface 
		withCatalogue: TestableObjectsFactory emptyPriceList
		processingThrough: aMerchantProcessor
		signInUsersWith: aUsersRecord
		recordingTo: TestableObjectsFactory emptySalesBook! !


!TestableObjectsFactory class methodsFor: 'clients record' stamp: 'AB 6/11/2019 22:59:58'!
aValidClienId
	
	^ 'Valid Client ID'! !

!TestableObjectsFactory class methodsFor: 'clients record' stamp: 'AB 6/11/2019 23:00:11'!
aValidClientPassword

	^ 'Valid User Password'! !

!TestableObjectsFactory class methodsFor: 'clients record' stamp: 'AB 6/11/2019 23:00:42'!
anInvalidClientId
	
	^ 'Invalid Client ID'! !

!TestableObjectsFactory class methodsFor: 'clients record' stamp: 'AB 6/11/2019 23:00:38'!
anInvalidClientPassword

	^ 'Invalid Client Password'! !

!TestableObjectsFactory class methodsFor: 'clients record' stamp: 'JR 6/12/2019 23:17:26'!
anotherValidClienId
	
	^ 'Another Valid Client ID'! !

!TestableObjectsFactory class methodsFor: 'clients record' stamp: 'JR 6/12/2019 23:17:34'!
anotherValidClientPassword

	^ 'Another Valid User Password'! !
