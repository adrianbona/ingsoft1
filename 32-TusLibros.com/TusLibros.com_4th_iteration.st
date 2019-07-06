!classDefinition: #TusLibrosClientWindow category: #'TusLibros.com'!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: 'listOfBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'NR 6/24/2019 03:31:46'!
defaultExtent

	^ 630@435
	! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:53:30'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	self model when: #catalogRequested send: #refreshSubstringList to: self.! !


!TusLibrosClientWindow methodsFor: 'access' stamp: 'AB 7/6/2019 19:48:51'!
refreshSubstringList
	
	listOfBooks updateList.
	listOfBooks setSelectionIndex: 0.
	! !


!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'AB 7/6/2019 19:48:51'!
build1stColumn2ndRow

	| firstColumnLayoutOfSecondRow |
	
	listOfBooks := PluggableListMorph model: self model listGetter: #substringList indexGetter: #substringsListIndex indexSetter: #substringsListIndex:.
	listOfBooks  borderColor: Color skyBlue.
	listOfBooks  borderWidth: 1.
		
	firstColumnLayoutOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Results');
	addMorph: listOfBooks.
		
	^firstColumnLayoutOfSecondRow.
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'AB 7/6/2019 19:46:23'!
build1stRow

	| sendRequestButton firstRowLayout |
	
	sendRequestButton _ PluggableButtonMorph model: self model stateGetter: nil  action: #catalogRequested  label: 'Get Catalog'.
	
	firstRowLayout _ LayoutMorph newRow.

	firstRowLayout separation: 25;
	padding: #left;
 	addMorph: sendRequestButton.

	^ firstRowLayout! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'AB 7/6/2019 19:46:58'!
build2ndRow

	| showInTranscriptButton secondRowLayout |
	
	showInTranscriptButton _ PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: 'Show Selected Book In Transcript'.	

	secondRowLayout _ LayoutMorph newRow.
	secondRowLayout separation: 25;
	padding: #left;
	addMorph: self build1stColumn2ndRow;
	addMorph: showInTranscriptButton.
	
	^ secondRowLayout! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'AB 7/6/2019 19:47:20'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build2ndRow! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: #'TusLibros.com'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'AB 7/6/2019 19:35:48'!
open
	
	^ self new initializeWith: 'Tus Libros . Com'.! !


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


!classDefinition: #RestInterfaceExternalTest category: #'TusLibros.com'!
TestCase subclass: #RestInterfaceExternalTest
	instanceVariableNames: 'testObjects loginBehavior debitBehavior aRestInterfaceWithAnEmptyPriceList aRestInterfaceWithOneItemPriceList aRestInterfaceWithTwoItemsPriceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

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

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:40:42'!
test01ListingAnEmptyCatalogReturnAnOkResponseWithEmptyCatalog

	| catalog |

	catalog _ aRestInterfaceWithAnEmptyPriceList catalog.
	
	self assert: catalog isEmpty.! !

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 18:46:12'!
test02ListingACatalogReturnsAResponseIncludingListOfItems

	| catalog |

	catalog _ aRestInterfaceWithTwoItemsPriceList catalog.
	
	self assert: catalog size equals: testObjects twoItemsPriceList size.

	self assert: (catalog allSatisfy: [ :anItem | testObjects twoItemsPriceList keys includes: anItem ]).! !

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

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 17:03:37'!
test10WhenAddingAnItemToShoppingCartListingContainsElementAndQuantity

	| shoppingCartId interface createCartResponse |
	
	interface _ aRestInterfaceWithOneItemPriceList.
		
	createCartResponse _ interface 
		createCartFor: testObjects aValidClienId
		protectedWith: testObjects aValidClientPassword.

	shoppingCartId _ (self responseMessageFrom: createCartResponse) asInteger.

	interface addTo: shoppingCartId anItemWithCode: testObjects existingISBN aQuantityOf: 2.

	self assert: (interface listCart: shoppingCartId) equals: interface okResponsePrefix, testObjects existingISBN, '|2'! !

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

!RestInterfaceExternalTest methodsFor: 'testing' stamp: 'AB 7/1/2019 19:20:38'!
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

	self assert: (interface listPurchasesFor: testObjects aValidClienId protectedBy: testObjects aValidClientPassword) equals: interface okResponsePrefix, testObjects existingISBN, '|', quantity printString ,'|', ((testObjects oneItemPriceList at: testObjects existingISBN) * quantity) printString! !

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


!classDefinition: #RestInterfaceInternalTest category: #'TusLibros.com'!
TestCase subclass: #RestInterfaceInternalTest
	instanceVariableNames: 'loginBehavior debitBehavior testObjects aRestInterfaceWithAnEmptyPriceList aRestInterfaceWithOneItemPriceList aRestInterfaceWithTwoItemsPriceList clock aRestInterfaceWithAnEmptyPriceListAndAClock aRestInterfaceWithOneItemPriceListAndAClock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

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


!classDefinition: #Clock category: #'TusLibros.com'!
Object subclass: #Clock
	instanceVariableNames: 'creationDateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Clock methodsFor: 'initialization' stamp: 'AB 6/19/2019 18:29:06'!
initialize

	creationDateAndTime _ DateAndTime now! !

!Clock methodsFor: 'initialization' stamp: 'AB 6/19/2019 18:29:54'!
initializeStartingOn: aDateAndTime

	creationDateAndTime _ aDateAndTime! !


!Clock methodsFor: 'adding' stamp: 'AB 6/19/2019 19:08:47'!
add: aDuration
	
	creationDateAndTime _ creationDateAndTime + aDuration! !


!Clock methodsFor: 'accessing' stamp: 'AB 6/19/2019 18:50:42'!
now

	^ creationDateAndTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: #'TusLibros.com'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'as yet unclassified' stamp: 'AB 6/19/2019 18:54:54'!
startingOn: aDateAndTime

	^ self new initializeStartingOn: aDateAndTime! !


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
	instanceVariableNames: 'items totalAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Purchase methodsFor: 'accessing' stamp: 'AB 6/18/2019 17:11:31'!
items
	
	^ items! !

!Purchase methodsFor: 'accessing' stamp: 'AB 6/19/2019 17:53:04'!
totalAmount
	
	^ totalAmount! !


!Purchase methodsFor: 'initialization' stamp: 'AB 6/19/2019 17:53:04'!
initialize

	items _ Bag new.
	totalAmount _ 0.
	
	super initialize! !


!Purchase methodsFor: 'adding' stamp: 'AB 6/19/2019 17:53:04'!
add: anItem costing: anAmount

	items add: anItem.
	totalAmount _ totalAmount + anAmount! !


!classDefinition: #RestInterfaceExternal category: #'TusLibros.com'!
Object subclass: #RestInterfaceExternal
	instanceVariableNames: 'restInterfaceInternal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'JR 6/30/2019 19:22:32'!
addTo: aShoppingCartId anItemWithCode: anISBN aQuantityOf: anAmount

	^ self try: [
		restInterfaceInternal addTo: aShoppingCartId anItemWithCode: anISBN aQuantityOf: anAmount.
		^ self okResponsePrefix, 'OK'
	]! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/1/2019 19:41:58'!
assertExpirationMonthIsValidAsMonthNumber: anExpirationMonthOfYear
	
	((anExpirationMonthOfYear copyFrom: 1 to: 2) asInteger between: 1 and: 12) ifFalse: [ self error: RestInterfaceExternal expirationMonthOfYearMustContainAValidMonth ]! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/1/2019 19:35:34'!
assertExpirationMonthOfYearContainsOnlyNumbers: anExpirationMonthOfYear
	
	(anExpirationMonthOfYear allSatisfy: [ :character | character digitValue between: 0 and: 9 ]) ifFalse: [ self error: RestInterfaceExternal expirationMonthOfYearMustContainOnlyNumbers ]! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/1/2019 19:09:17'!
assertExpirationMonthOfYearIsSixCharactersLong: anExpirationMonthOfYear
	
	(anExpirationMonthOfYear size = 6) ifFalse: [ self error: RestInterfaceExternal expirationMonthOfYearMustBeExactlySixDigitsLong ]! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 6/30/2019 17:45:21'!
catalog

	^ restInterfaceInternal catalog! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/1/2019 19:40:28'!
checkOut: aShoppingCartId chargingToACreditCardNumbered: aCreditCardNumber expiringOn: aSixDigitsExpirationDate ownedBy: ownersName

	^ self try: [ | expirationAsMonthOfYear |
		
		self assertExpirationMonthOfYearIsSixCharactersLong: aSixDigitsExpirationDate.

		self assertExpirationMonthOfYearContainsOnlyNumbers: aSixDigitsExpirationDate.

		self assertExpirationMonthIsValidAsMonthNumber: aSixDigitsExpirationDate.

		expirationAsMonthOfYear _ self convertSixDigitsStringToMonthOfYear: aSixDigitsExpirationDate.

		restInterfaceInternal checkOut: aShoppingCartId chargingToACreditCardNumbered: aCreditCardNumber expiringOn: expirationAsMonthOfYear ownedBy: ownersName.

		^ '0|OK'.
	]! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/1/2019 19:33:37'!
convertSixDigitsStringToMonthOfYear: aSixDigitsExpirationDate

	^ GregorianMonthOfYear yearNumber: (aSixDigitsExpirationDate copyFrom: 3 to: 6) asInteger monthNumber: (aSixDigitsExpirationDate copyFrom: 1 to: 2) asInteger! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/6/2019 16:10:30'!
createCartFor: aClientId protectedWith: aPassword

	^ self try: [ ^ self okResponsePrefix, (restInterfaceInternal createCartFor: aClientId protectedWith: aPassword) printString ]! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'JR 6/30/2019 18:28:22'!
errorResponsePrefix

	^ '1|'! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'JR 6/30/2019 18:01:40'!
initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord

	restInterfaceInternal _ RestInterfaceInternal withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 6/30/2019 17:45:08'!
initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: aClock

	restInterfaceInternal _ RestInterfaceInternal withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: aClock! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'JR 6/30/2019 19:38:41'!
listCart: aShoppingCartId

	^ self try:
	[
		| bagOfItems |
		
		bagOfItems _ (restInterfaceInternal listCart: aShoppingCartId).
		
		bagOfItems isEmpty ifTrue: [^ self okResponsePrefix ].
		
		^ self bagToString: bagOfItems
	]
! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/1/2019 18:20:37'!
listPurchasesFor: aClientId protectedBy: aPassword

	^ self try:
	[
		| purchase |
		
		purchase _ (restInterfaceInternal listPurchasesFor: aClientId protectedBy: aPassword).
		
		purchase items isEmpty ifTrue: [ ^ self okResponsePrefix, purchase totalAmount printString ].

		^ self purchaseToString: purchase
	]! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'JR 6/30/2019 18:22:58'!
okResponsePrefix

	^ '0|'! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/1/2019 18:19:59'!
purchaseToString: purchase

	^ (self bagToString: purchase items), '|' , (purchase totalAmount printString)! !

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'JR 6/30/2019 19:04:22'!
try: aBlock

	aBlock
	on: Error
	do: [ :anEror | ^ self errorResponsePrefix , anEror messageText ]! !


!RestInterfaceExternal methodsFor: 'conversions' stamp: 'AB 7/1/2019 17:21:16'!
bagToDictionary: aBagOfItems

	| groupedItems |
	
	groupedItems _ Dictionary new.
	
	aBagOfItems do: [ :itemFromBag |
		groupedItems at: itemFromBag put: (aBagOfItems occurrencesOf: itemFromBag) ].
	
	^ groupedItems! !

!RestInterfaceExternal methodsFor: 'conversions' stamp: 'AB 7/1/2019 17:22:15'!
bagToString: aBagOfItems
	
	^ self dictionaryToString: (self bagToDictionary: aBagOfItems)! !

!RestInterfaceExternal methodsFor: 'conversions' stamp: 'AB 7/6/2019 16:50:02'!
dictionaryToString: aDictionaryWithItems

	| outputString |

	outputString _ '0|'.

	aDictionaryWithItems keysAndValuesDo: [ :key :value |
		outputString _ outputString , key , '|' , value printString, '|' ].

	^ outputString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterfaceExternal class' category: #'TusLibros.com'!
RestInterfaceExternal class
	instanceVariableNames: ''!

!RestInterfaceExternal class methodsFor: 'as yet unclassified' stamp: 'AB 7/1/2019 19:06:44'!
expirationMonthOfYearMustBeExactlySixDigitsLong
	
	^ 'Expiration month of year must be 6 digits long'! !

!RestInterfaceExternal class methodsFor: 'as yet unclassified' stamp: 'AB 7/1/2019 19:42:23'!
expirationMonthOfYearMustContainAValidMonth
	
	^ 'Expiration month of year must contain a valid month'! !

!RestInterfaceExternal class methodsFor: 'as yet unclassified' stamp: 'AB 7/1/2019 19:36:03'!
expirationMonthOfYearMustContainOnlyNumbers
	
	^ 'Expiration month of year must contain only numbers'! !

!RestInterfaceExternal class methodsFor: 'as yet unclassified' stamp: 'JR 6/30/2019 18:00:26'!
withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord

	^ self new initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord! !

!RestInterfaceExternal class methodsFor: 'as yet unclassified' stamp: 'AB 6/30/2019 17:39:53'!
withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: aClock

	^ self new initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: aClock! !


!classDefinition: #RestInterfaceInternal category: #'TusLibros.com'!
Object subclass: #RestInterfaceInternal
	instanceVariableNames: 'priceList merchantProcessor currentCartId clientsRecord salesBook clock sessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!RestInterfaceInternal methodsFor: 'initialization' stamp: 'AB 6/22/2019 12:36:11'!
initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord

	self initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: Clock new! !

!RestInterfaceInternal methodsFor: 'initialization' stamp: 'AB 6/22/2019 12:36:18'!
initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: aClock

	priceList _ aPriceList.
	merchantProcessor _ aMerchantProcessor.
	clientsRecord _ aUsersRecord.
	clock _ aClock.

	salesBook _ Dictionary new.
	sessions _ Dictionary new.
	currentCartId _ 0! !


!RestInterfaceInternal methodsFor: 'cart creation' stamp: 'AB 6/22/2019 12:34:45'!
createCartFor: aClientId protectedWith: aPassword

	| cartId |

	self assertClientExistsWith: aClientId and: aPassword.

	cartId _ self uniqueCartId.

	self createSessionFor: aClientId with: cartId.

	^ cartId! !

!RestInterfaceInternal methodsFor: 'cart creation' stamp: 'AB 6/22/2019 12:33:49'!
createSessionFor: aClientId with: aShoppingCartId

	sessions at: aShoppingCartId put: (Session for: aClientId with: (ShoppingCart with: priceList) expiringOn: clock now + self sessionDuration)! !


!RestInterfaceInternal methodsFor: 'clients records' stamp: 'AB 6/11/2019 22:54:47'!
assertClientExistsWith: aClientId and: aPassword

	 clientsRecord isRegisteredWith: aClientId and: aPassword! !


!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 6/22/2019 12:40:15'!
addTo: aShoppingCartId anItemWithCode: anISBN aQuantityOf: anAmount

	| session |

	session _ self sessionFor: aShoppingCartId.

	session shoppingCart add: anISBN quantity: anAmount! !

!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 6/30/2019 17:44:45'!
catalog

	^ priceList keys! !

!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 6/22/2019 12:48:01'!
checkOut: aShoppingCartId chargingToACreditCardNumbered: aCreditCardNumber expiringOn: aMonthOfYear ownedBy: ownersName 

	| cashier creditCard session clientSalesBook |

	creditCard _ CreditCard with: aCreditCardNumber with: aMonthOfYear with: ownersName.

	session _ self sessionFor: aShoppingCartId.

	clientSalesBook _ self salesBooksFor: session client.

	cashier _ Cashier with: session shoppingCart chargingTo: creditCard registeringOn: clientSalesBook startingOn: clock now using: merchantProcessor.

	cashier checkOut.
	
	self removeSession: session! !

!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 6/22/2019 12:38:31'!
listCart: aShoppingCartId

	^ (self sessionFor: aShoppingCartId) shoppingCart items! !

!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 6/19/2019 17:51:23'!
listPurchasesFor: aClientId protectedBy: aPassword

	| clientPurchases |

	self assertClientExistsWith: aClientId and: aPassword.

	clientPurchases _ Purchase new.

	(self salesBooksFor: aClientId) do: [ :aSalesBook | 
		aSalesBook items do: [ :anItem | 
			clientPurchases add: anItem costing: (priceList at: anItem)
		] 
	].

	^ clientPurchases! !

!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 6/15/2019 00:57:53'!
salesBooksFor: aClientId

	^ salesBook at: aClientId ifAbsentPut: [ OrderedCollection new ]! !

!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 6/30/2019 16:53:20'!
shoppingCartIsExpired: aShoppingCartId

	^ (sessions at: aShoppingCartId ifAbsent: [ self error: RestInterfaceInternal shoppingCartNotFound ]) isExpiredOn: clock now! !


!RestInterfaceInternal methodsFor: 'id' stamp: 'AB 6/22/2019 12:34:31'!
uniqueCartId

	^ currentCartId _ currentCartId + 1! !


!RestInterfaceInternal methodsFor: 'session expiration' stamp: 'AB 6/30/2019 16:53:20'!
assertSessionIsUnexpired: aSession

	(aSession isExpiredOn: clock now) ifTrue: [
		self removeSession: aSession.
		self error: RestInterfaceInternal shoppingCartHasExpired
	]! !

!RestInterfaceInternal methodsFor: 'session expiration' stamp: 'AB 6/20/2019 00:10:55'!
assertSessionIsUnexpiredAndelayExpirationTo: aSession

	self assertSessionIsUnexpired: aSession.
	
	self delayExpirationTo: aSession! !

!RestInterfaceInternal methodsFor: 'session expiration' stamp: 'AB 6/20/2019 00:10:36'!
delayExpirationTo: aSession

	aSession expiringOn: clock now + self sessionDuration! !

!RestInterfaceInternal methodsFor: 'session expiration' stamp: 'AB 6/20/2019 09:57:40'!
removeSession: aSession

	sessions removeKey: (sessions keyAtValue: aSession)! !

!RestInterfaceInternal methodsFor: 'session expiration' stamp: 'AB 6/20/2019 00:09:39'!
sessionDuration
	
	^ Duration minutes: 30! !

!RestInterfaceInternal methodsFor: 'session expiration' stamp: 'AB 6/30/2019 16:53:20'!
sessionFor: aShoppingCartId

	| session |

	session _ sessions at: aShoppingCartId ifAbsent: [ self error: RestInterfaceInternal shoppingCartNotFound ].
	
	self assertSessionIsUnexpiredAndelayExpirationTo: session.

	^ session! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterfaceInternal class' category: #'TusLibros.com'!
RestInterfaceInternal class
	instanceVariableNames: ''!

!RestInterfaceInternal class methodsFor: 'error handling' stamp: 'AB 6/14/2019 14:04:48'!
clientCredentialsDoNotMatchAnyExistingClient
	
	^ 'Client credentials do not match any existing client'! !

!RestInterfaceInternal class methodsFor: 'error handling' stamp: 'AB 6/14/2019 13:59:14'!
invalidClientId
	
	^ 'Client ID is invalid'! !

!RestInterfaceInternal class methodsFor: 'error handling' stamp: 'AB 6/14/2019 13:59:25'!
invalidClientPassword
	
	^ 'Client password is invalid'! !

!RestInterfaceInternal class methodsFor: 'error handling' stamp: 'AB 6/19/2019 19:14:24'!
shoppingCartHasExpired
	
	^ 'Shopping Cart Has Expired'! !

!RestInterfaceInternal class methodsFor: 'error handling' stamp: 'AB 6/12/2019 17:12:31'!
shoppingCartNotFound
	
	^ 'Shopping Cart was not found'! !


!RestInterfaceInternal class methodsFor: 'instance creation' stamp: 'AB 6/15/2019 00:32:39'!
withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord

	^ self new initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord! !

!RestInterfaceInternal class methodsFor: 'instance creation' stamp: 'AB 6/19/2019 18:23:23'!
withCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: aClock

	^ self new initializewithCatalogue: aPriceList processingThrough: aMerchantProcessor signInUsersWith: aUsersRecord calculatingTimeFrom: aClock! !


!classDefinition: #Sale category: #'TusLibros.com'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Sale methodsFor: 'accessing' stamp: 'PFT 6/18/2018 02:27:07'!
items
	
	^ items! !

!Sale methodsFor: 'accessing' stamp: 'AB 6/19/2019 17:52:50'!
totalAmount
	
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


!classDefinition: #Session category: #'TusLibros.com'!
Object subclass: #Session
	instanceVariableNames: 'client shoppingCart expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Session methodsFor: 'initialization' stamp: 'AB 6/19/2019 18:39:05'!
initializeFor: aClientId with: aShoppingCart expiringOn: aDateAndTime

	client _ aClientId.
	shoppingCart _ aShoppingCart.
	expiration _ aDateAndTime ! !


!Session methodsFor: 'accessing' stamp: 'AB 6/15/2019 00:45:07'!
client

	^ client! !

!Session methodsFor: 'accessing' stamp: 'AB 6/15/2019 00:45:03'!
shoppingCart

	^ shoppingCart! !


!Session methodsFor: 'expiration' stamp: 'AB 6/19/2019 20:06:15'!
expiringOn: anExpirationDateAndTime

	expiration _ anExpirationDateAndTime! !

!Session methodsFor: 'expiration' stamp: 'AB 6/19/2019 19:45:59'!
isExpiredOn: aDateAndTime

	^ expiration <= aDateAndTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: #'TusLibros.com'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'AB 6/19/2019 18:38:40'!
for: aClientId with: aShoppingCart expiringOn: aDateAndTime

	^ self new initializeFor: aClientId with: aShoppingCart expiringOn: aDateAndTime! !


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

!ShoppingCart methodsFor: 'assertions' stamp: 'AB 6/22/2019 13:00:05'!
assertQuantityIsAnInteger: aQuantity

	(aQuantity isInteger) ifFalse: [ self error: ShoppingCart quantityMustBeAnIntegerValue ]! !

!ShoppingCart methodsFor: 'assertions' stamp: 'AB 6/22/2019 13:00:46'!
assertQuantityIsAnIntegerValueAndBiggerThenZero: aQuantity

	self assertQuantityIsAnInteger: aQuantity.

	self assertQuantityIsBiggerThenZero: aQuantity! !

!ShoppingCart methodsFor: 'assertions' stamp: 'AB 6/22/2019 13:00:17'!
assertQuantityIsBiggerThenZero: aQuantity

	(aQuantity < 1) ifTrue: [ self error: ShoppingCart quantityMustBeBiggerThanOneError ]! !


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


!ShoppingCart methodsFor: 'initialization' stamp: 'AB 6/22/2019 12:58:56'!
initializeWith: aPriceList

	items _ Bag new.
	priceList _ aPriceList! !

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


!classDefinition: #TusLibrosClientWindowModel category: #'TusLibros.com'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'selectedIndex webClient listOfBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'AB 7/6/2019 19:43:30'!
substringList
	
	^ listOfBooks
! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'AB 7/6/2019 19:43:36'!
substringsListIndex
	
	^ selectedIndex! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'AB 7/6/2019 19:43:42'!
substringsListIndex: anIndex

	selectedIndex _ anIndex! !


!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:42:52'!
initialize

	listOfBooks _ OrderedCollection new.
	selectedIndex _ 0.
	webClient _ TusLibrosWebClient new! !


!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'AB 7/6/2019 19:53:13'!
catalogRequested
		
	listOfBooks _ webClient getCatalog.
	
	self triggerEvent: #catalogRequested with: self.
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'AB 7/6/2019 19:44:31'!
sendSubtringsRequest
		
	listOfBooks _ webClient getCatalog.
	
	self triggerEvent: #catalogRequested with: self.
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'AB 7/6/2019 19:43:17'!
showWordInTranscript
	
	(selectedIndex = 0) ifFalse: 
		[TranscriptWindow openTranscript.
		Transcript clear.
		Transcript show: 'The word selected is: '.
		Transcript show: (listOfBooks at: selectedIndex).
		Transcript show: ' '.].
! !


!classDefinition: #TusLibrosServer category: #'TusLibros.com'!
Object subclass: #TusLibrosServer
	instanceVariableNames: 'webServer port restInterface merchantProcessor priceList kerberos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TusLibrosServer methodsFor: 'third party apps' stamp: 'AB 7/6/2019 16:28:45'!
debit: anAmount from: aCreditCard

	^ merchantProcessor value: anAmount value: aCreditCard! !

!TusLibrosServer methodsFor: 'third party apps' stamp: 'AB 7/6/2019 16:28:55'!
isRegisteredWith: aClientId and: aPassword

	^ kerberos value: aClientId value: aPassword! !


!TusLibrosServer methodsFor: 'enabling services' stamp: 'AB 7/6/2019 18:51:41'!
destroy
	
	webServer ifNotNil: [ webServer destroy ].! !

!TusLibrosServer methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:52:06'!
startListening
	
	webServer startListener ! !

!TusLibrosServer methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:52:12'!
stopListening
	
	webServer stopListener! !


!TusLibrosServer methodsFor: 'initialization' stamp: 'AB 7/6/2019 16:31:05'!
initialize

	kerberos _ [ :aClientId :aPassword | ].

	merchantProcessor _ [ :anAmount :aCreditCard | ].

	priceList _ StoreTestObjectsFactory new twoItemsPriceList.

	restInterface _ RestInterfaceExternal new initializewithCatalogue: priceList processingThrough: self signInUsersWith: self.

	self initializeServices! !

!TusLibrosServer methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:22:38'!
initializeServices

	webServer _ WebServer new listenOn: self port.

	webServer addService: '/catalog' action: [ :request |
		request send200Response: (WebUtils jsonEncode: (restInterface catalog))
	].

	webServer addService: '/createCart' action: [ :request | [
			| clientId password |
			clientId _ (request fields at:'clientId').		
			password _ (request fields at:'password').
			request send200Response: (WebUtils jsonEncode: (restInterface createCartFor: clientId protectedWith: password))
		 ]
		on: Error 
		do: [ :anError |
			request send404Response: (WebUtils jsonEncode: ('1|' , anError messageText))
		]
	].

	webServer addService: '/addToCart' action: [ :request | [
			| cartId bookIsbn bookQuantity |
			cartId _ (request fields at:'cartId') asInteger.
			bookIsbn _ (request fields at:'bookIsbn').
			bookQuantity _ (request fields at:'bookQuantity') asInteger.
			request send200Response: (WebUtils jsonEncode: (restInterface addTo: cartId anItemWithCode: bookIsbn aQuantityOf: bookQuantity))
		 ]
		on: Error 
		do: [ :anError |
			request send404Response: (WebUtils jsonEncode: ('1|' , anError messageText))
		]
	].

	webServer addService: '/listCart' action: [ :request | [
			| cartId |
			cartId _ (request fields at:'cartId') asInteger.
			request send200Response: (WebUtils jsonEncode: (restInterface listCart: cartId))
		 ]
		on: Error 
		do: [ :anError |
			request send404Response: (WebUtils jsonEncode: ('1|' , anError messageText))
		]
	].

	webServer addService: '/listPurchases' action: [ :request | [
			| clientId password |
			clientId _ (request fields at:'clientId').		
			password _ (request fields at:'password').
			request send200Response: (WebUtils jsonEncode: (restInterface listPurchasesFor: clientId protectedBy: password))
		 ]
		on: Error 
		do: [ :anError |
			request send404Response: (WebUtils jsonEncode: ('1|' , anError messageText))
		]
	].

	webServer addService: '/checkOutCart' action: [ :request | [
			| cartId creditCardNumber expiration owner |
			cartId _ (request fields at:'cartId') asInteger.	
			creditCardNumber _ (request fields at:'ccn').
			expiration _ (request fields at:'cced').
			owner _ (request fields at:'cco').
			request send200Response: (WebUtils jsonEncode: (restInterface checkOut: cartId chargingToACreditCardNumbered: creditCardNumber expiringOn: expiration ownedBy: owner))
		 ]
		on: Error 
		do: [ :anError |
			request send404Response: (WebUtils jsonEncode: ('1|' , anError messageText))
		]
	].
! !

!TusLibrosServer methodsFor: 'initialization' stamp: 'AB 7/6/2019 18:52:02'!
port

	^ port ifNil: [ port _ 8080 ]! !


!classDefinition: #TusLibrosWebClient category: #'TusLibros.com'!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'NR 6/25/2019 22:25:36'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosWebClient methodsFor: 'sending requests' stamp: 'AB 7/6/2019 19:51:03'!
getCatalog

	| fieldDict resp |

	fieldDict _ Dictionary new.

	resp _ WebClient htmlSubmit: (self url,'/catalog') fields: fieldDict.

	resp isSuccess 
		ifTrue: [ ^ (WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection ]
		ifFalse: [ ^ self error: resp content ]! !


!TusLibrosWebClient methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:34:17'!
port

	^ port ifNil: [ port _ 8080 ]! !

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:34:22'!
url
	
	^ 'http://localhost:', self port asString! !
