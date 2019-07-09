!classDefinition: #Cashier category: #'TusLibros.com-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'shoppingCart creditCard salesBook date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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

!classDefinition: 'Cashier class' category: #'TusLibros.com-Model'!
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


!classDefinition: #Clock category: #'TusLibros.com-Model'!
Object subclass: #Clock
	instanceVariableNames: 'creationDateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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

!classDefinition: 'Clock class' category: #'TusLibros.com-Model'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'as yet unclassified' stamp: 'AB 6/19/2019 18:54:54'!
startingOn: aDateAndTime

	^ self new initializeStartingOn: aDateAndTime! !


!classDefinition: #CreditCard category: #'TusLibros.com-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

!CreditCard methodsFor: 'initialization' stamp: 'AB 6/10/2019 10:50:03'!
initializeWith: a16DigitsNumber with: aMonthOfYear with: anOwnersNameBetween1and30CharactersLong

	number _ a16DigitsNumber.
	expiration _ aMonthOfYear.
	owner _ anOwnersNameBetween1and30CharactersLong! !


!CreditCard methodsFor: 'expiration' stamp: 'AB 6/17/2019 17:32:55'!
isExpiredOn: aDate

	^ expiration < (GregorianMonthOfYear yearNumber: (aDate yearNumber) monthNumber: (aDate monthIndex))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros.com-Model'!
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


!classDefinition: #Purchase category: #'TusLibros.com-Model'!
Object subclass: #Purchase
	instanceVariableNames: 'items totalAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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


!classDefinition: #RestInterfaceExternal category: #'TusLibros.com-Model'!
Object subclass: #RestInterfaceExternal
	instanceVariableNames: 'restInterfaceInternal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/9/2019 12:39:44'!
catalog

	| catalog |

	catalog _ OrderedCollection new.

	restInterfaceInternal catalog keysAndValuesDo: [ :aKey :aValue | catalog add: (aKey , ' | ' , aValue printString) ].

	^ catalog! !

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

!RestInterfaceExternal methodsFor: 'initialization' stamp: 'AB 7/8/2019 15:57:04'!
purchaseToString: purchase

	^ (self bagToString: purchase items) , (purchase totalAmount printString)! !

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

!classDefinition: 'RestInterfaceExternal class' category: #'TusLibros.com-Model'!
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


!classDefinition: #RestInterfaceInternal category: #'TusLibros.com-Model'!
Object subclass: #RestInterfaceInternal
	instanceVariableNames: 'priceList merchantProcessor currentCartId clientsRecord salesBook clock sessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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

!RestInterfaceInternal methodsFor: 'cart accessing' stamp: 'AB 7/9/2019 12:39:00'!
catalog

	^ priceList! !

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

!classDefinition: 'RestInterfaceInternal class' category: #'TusLibros.com-Model'!
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


!classDefinition: #Sale category: #'TusLibros.com-Model'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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

!classDefinition: 'Sale class' category: #'TusLibros.com-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AB 6/7/2019 15:00:08'!
with: aCollectionOfItems costing: aTotal

	^ self new initializeWith: aCollectionOfItems costing: aTotal! !


!classDefinition: #Session category: #'TusLibros.com-Model'!
Object subclass: #Session
	instanceVariableNames: 'client shoppingCart expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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

!classDefinition: 'Session class' category: #'TusLibros.com-Model'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'AB 6/19/2019 18:38:40'!
for: aClientId with: aShoppingCart expiringOn: aDateAndTime

	^ self new initializeFor: aClientId with: aShoppingCart expiringOn: aDateAndTime! !


!classDefinition: #ShoppingCart category: #'TusLibros.com-Model'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'items priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Model'!

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

!classDefinition: 'ShoppingCart class' category: #'TusLibros.com-Model'!
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
