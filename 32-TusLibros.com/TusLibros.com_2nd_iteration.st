!classDefinition: #CashierTest category: #'TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'expiredCreditCard emptyPriceList oneItemPriceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CashierTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:38:45'!
test01CannotCheckoutEmptyCart

	| shoppingCart creditCard |
	
	shoppingCart _ ShoppingCart with: emptyPriceList.
	
	self should: [ Cashier new checkout: shoppingCart payingWith: creditCard ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier shoppingCartCanNotBeEmpty.
	]! !

!CashierTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:41:01'!
test02CannotCheckoutCartWithExpiredCreditCard

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	shoppingCart add: #book1.

	self should: [ Cashier new checkout: shoppingCart payingWith: expiredCreditCard ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier expiredCreditCardIsNotValid
	]! !


!CashierTest methodsFor: 'setUp' stamp: 'AB 6/7/2019 12:36:29'!
setUp

	emptyPriceList _ Dictionary new.

	oneItemPriceList _ emptyPriceList copy.
	oneItemPriceList at: #book1 put: 100 * peso.

	expiredCreditCard _ CreditCard 
		with: '1234567890123456' 
		with: (May of: 2019)
		with: 'Jorge'.! !


!classDefinition: #CreditCardTest category: #'TusLibros.com'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'aMonthOfYear a15DigitsNumber a16DigitsNumber a17DigitsNumber a0CharactersLongName a30CharactersLongName a31CharactersLongName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/7/2019 00:17:35'!
test01SizeOfNumberMustBeExactly16CharactersLong
	
	self should: [ CreditCard with: a15DigitsNumber with: aMonthOfYear with: a30CharactersLongName ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	].

	self should: [ CreditCard with: a17DigitsNumber with: aMonthOfYear with: a30CharactersLongName ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: CreditCard cardNumberMustBe16DigitsLong
	]! !

!CreditCardTest methodsFor: 'testing' stamp: 'AB 6/7/2019 00:17:59'!
test02OwnerNameShorterThan1CharacterAndLargerThan30ReturnsError
	
	self should: [ CreditCard with: a16DigitsNumber with: aMonthOfYear with: a0CharactersLongName ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard ownerNameMustBeBetween1And30CharactersLong
	].

	self should: [ CreditCard with: a16DigitsNumber with: aMonthOfYear with: a31CharactersLongName ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard ownerNameMustBeBetween1And30CharactersLong
	]! !


!CreditCardTest methodsFor: 'setUp' stamp: 'AB 6/7/2019 11:01:40'!
setUp

	a0CharactersLongName _ ''.
	a30CharactersLongName _ 'A Credit Card Name'.
	a31CharactersLongName _ 'A really long credit card name!!'.

	a15DigitsNumber _ '123456789012345'.
	a16DigitsNumber _ '1234567890123456'.
	a17DigitsNumber _ '12345678901234567'.

	aMonthOfYear _ July of: 2019! !


!classDefinition: #ShoppingCartTest category: #'TusLibros.com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'emptyPriceList threeItemsPriceList oneItemPriceList twoItemsPriceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:04:08'!
test01CreateNewShoppingCartIsEmptyCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: emptyPriceList.
	
	self assert: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:18:44'!
test02WhenAddingBookToShoppingCarItIsNotEmpty

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	
	shoppingCart add: #book1.
	
	self deny: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:52:47'!
test03WhenAddingABookToShoppingCartCanCheckIsThere

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	
	shoppingCart add: #book1.
	
	self deny: shoppingCart isEmpty.
	self assert: (shoppingCart contains: #book1)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:19:06'!
test04AddingTwoBooksMakesSizeTwoAndBothAreContained

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: twoItemsPriceList.
	
	shoppingCart add: #book1.
	shoppingCart add: #book2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #book1).
	self assert: (shoppingCart contains: #book2)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:19:15'!
test05AddTwoCopiesOfTheSameBookAssertInclusionInCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	
	shoppingCart add: #book1 quantity: 2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #book1)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:19:21'!
test06AddingABookWithAQuantityLessThan1ThrowsAnError

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	
	self should: [shoppingCart add: #book1 quantity: 0]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart quantityMustBeBiggerThanOneError.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:19:29'!
test07AShoppingCartReturnsNumberOfCopiesOfABook 

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	self assert: (shoppingCart quantityOf: #book1) = 0.
	
	shoppingCart add: #book1 quantity: 3.
	self assert: (shoppingCart quantityOf: #book1) = 3.! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:04:36'!
test08AShoppingCartReturnsCollectionWithTheBooksItContains

	| shoppingCart items |
	
	shoppingCart _ ShoppingCart with: threeItemsPriceList.
	
	shoppingCart add: #book1 quantity: 1.
	shoppingCart add: #book2 quantity: 2.
	shoppingCart add: #book3 quantity: 3.
	
	items _ shoppingCart items.
	
	self assert: (items includes: #book1).
	self assert: (items includes: #book2).
	self assert: (items includes: #book3)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:19:37'!
test09CanNotAddANotIntegerQuantityOfBooksToCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	
	self should: [shoppingCart add: #book1 quantity: 2.5]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart quantityMustBeAnIntegerValue.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:19:41'!
test10CanNotAddABookNotIncludedTheCatalogue

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.
	
	self should: [shoppingCart add: #book2 quantity: 2]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart catalogueDoestNotIncludeItem.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/7/2019 12:51:16'!
test11WhenAddingBookToShoppingCartCostIncreases

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneItemPriceList.

	self assert: 0 * peso equals: shoppingCart itemsCost.
		
	shoppingCart add: #book1.
	
	self assert: (oneItemPriceList at: #book1) equals: shoppingCart itemsCost! !


!ShoppingCartTest methodsFor: 'setUp' stamp: 'AB 6/7/2019 12:18:31'!
setUp

	emptyPriceList _ Dictionary new.

	oneItemPriceList _ emptyPriceList copy.
	oneItemPriceList at: #book1 put: 100 * peso.

	twoItemsPriceList _ oneItemPriceList copy.
	twoItemsPriceList at: #book2 put: 200 * peso.

	threeItemsPriceList _ twoItemsPriceList copy.
	threeItemsPriceList at: #book3 put: 300 * peso.! !


!classDefinition: #Cashier category: #'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'check out' stamp: 'AB 6/7/2019 12:40:12'!
checkout: shoppingCart payingWith: creditCard

	| transactionAmout |
	
	(shoppingCart isEmpty) ifTrue: [ self error: Cashier shoppingCartCanNotBeEmpty ].
	
	(creditCard isExpiredOn: (GregorianMonthOfYear current)) ifTrue: [ self error: Cashier expiredCreditCardIsNotValid ].
		
	transactionAmout _ shoppingCart itemsCost! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/5/2019 23:09:51'!
expiredCreditCardIsNotValid

	^ 'Credit card has already expired'! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/5/2019 18:49:13'!
shoppingCartCanNotBeEmpty

	^ 'Shopping cart cannot be empty'! !


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


!ShoppingCart methodsFor: 'adding' stamp: 'AB 6/7/2019 12:20:36'!
add: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: ShoppingCart catalogueDoestNotIncludeItem ].

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

!ShoppingCart methodsFor: 'querying' stamp: 'AB 6/7/2019 12:32:30'!
itemsCost

	^ items sum: [ :item | priceList at: item ] ifEmpty: [ 0 * peso ]! !

!ShoppingCart methodsFor: 'querying' stamp: 'JR 5/31/2019 19:43:38'!
quantityOf: anItem

	^ items occurrencesOf: anItem.! !


!ShoppingCart methodsFor: 'initialization' stamp: 'AB 6/7/2019 12:22:31'!
initializeWith: aPriceList

	items _ OrderedCollection new.
	priceList _ aPriceList.
	super initialize! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros.com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'AB 6/1/2019 16:05:47'!
with: aCatalogue
	
	^ self new initializeWith: aCatalogue! !


!ShoppingCart class methodsFor: 'error handling' stamp: 'AB 6/1/2019 16:10:42'!
catalogueDoestNotIncludeItem

	^ 'Catalogue does not include item'! !

!ShoppingCart class methodsFor: 'error handling' stamp: 'AB 6/5/2019 18:53:04'!
quantityMustBeAnIntegerValue
	
	^ 'Quantity must be an integer value'! !

!ShoppingCart class methodsFor: 'error handling' stamp: 'AB 6/5/2019 18:53:06'!
quantityMustBeBiggerThanOneError
	
	^ 'Quantity must be bigger than one'! !
