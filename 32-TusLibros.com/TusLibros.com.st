!classDefinition: #CashierTest category: #'TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 23:05:41'!
test01CannotCheckoutEmptyCart

	| catalogue shoppingCart priceList |
	
	catalogue _ OrderedCollection new.
	shoppingCart _ ShoppingCart with: catalogue.
	
	self should: [ | creditCard | Cashier checkout: shoppingCart withPricesFrom: priceList payingWith: creditCard ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier shoppingCartCanNotBeEmpty.
	]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 23:06:04'!
test02CannotCheckoutCartWithItemsNotFoundInPriceList

	| catalogue shoppingCart priceList |
	
	catalogue _ OrderedCollection with: #book1.
	shoppingCart _ ShoppingCart with: catalogue.
	shoppingCart add: #book1.
	priceList _ Dictionary new.
	
	self should: [ | creditCard | Cashier checkout: shoppingCart withPricesFrom: priceList payingWith: creditCard ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier itemNotFoundInPriceList.
	].
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 23:10:45'!
test03CannotCheckoutCartWithExpiredCreditCard

	| catalogue shoppingCart priceList creditCard |
	
	catalogue _ OrderedCollection with: #book1.
	shoppingCart _ ShoppingCart with: catalogue.
	shoppingCart add: #book1.

	priceList _ Dictionary new.
	priceList at: #book1 put: 1.
	
	creditCard _ CreditCard with: '1234567890123456' with: (GregorianMonthOfYear year: 2019 month: April ) with: 'Jorge'.
	
	self should: [ Cashier checkout: shoppingCart withPricesFrom: priceList payingWith: creditCard ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier expiredCreditCardIsNotValid
	]! !


!classDefinition: #ShoppingCartTest category: #'TusLibros.com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'emptyCatalogue threeBooksCatalogue oneBookCatalogue twoBooksCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:08:17'!
test01CreateNewShoppingCartIsEmptyCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: emptyCatalogue.
	
	self assert: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:13:39'!
test02WhenAddingBookToShoppingCarItIsNotEmpty

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneBookCatalogue.
	
	shoppingCart add: #aBook.
	
	self deny: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:13:45'!
test03WhenAddingBookToShoppingCartICanCheckIsThere

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneBookCatalogue.
	
	shoppingCart add: #aBook.
	
	self deny: shoppingCart isEmpty.
	self assert: (shoppingCart contains: #aBook)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:11:47'!
test04AddingTwoBooksMakesSizeTwoAndBothAreContained

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: twoBooksCatalogue.
	
	shoppingCart add: #aBook.
	shoppingCart add: #anotherBook.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #aBook).
	self assert: (shoppingCart contains: #anotherBook)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:13:08'!
test05AddTwoCopiesOfTheSameBookAssertInclusionInCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneBookCatalogue.
	
	shoppingCart add: #aBook quantity: 2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #aBook)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:14:18'!
test06AddingABookWithAQuantityLessThan1ThrowsAnError

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneBookCatalogue.
	
	self should: [shoppingCart add: #aBook quantity: 0]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart quantityMustBeBiggerThanOneError.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:14:31'!
test07AShoppingCartReturnsNumberOfCopiesOfABook 

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneBookCatalogue.
	self assert: (shoppingCart quantityOf: #aBook) = 0.
	
	shoppingCart add: #aBook quantity: 3.
	self assert: (shoppingCart quantityOf: #aBook) = 3.! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:14:44'!
test08AShoppingCartReturnsCollectionWithTheBooksItContains

	| shoppingCart items |
	
	shoppingCart _ ShoppingCart with: threeBooksCatalogue.
	
	shoppingCart add: #book1 quantity: 1.
	shoppingCart add: #book2 quantity: 2.
	shoppingCart add: #book3 quantity: 3.
	
	items _ shoppingCart items.
	
	self assert: (items includes: #book1).
	self assert: (items includes: #book2).
	self assert: (items includes: #book3)! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:14:58'!
test09CanNotAddANotIntegerQuantityOfBooksToCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneBookCatalogue.
	
	self should: [shoppingCart add: #aBook quantity: 2.5]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart quantityMustBeAnIntegerValue.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'testing' stamp: 'AB 6/1/2019 16:15:47'!
test10CanNotAddABookNotIncludedTheCatalogue

	| shoppingCart |
	
	shoppingCart _ ShoppingCart with: oneBookCatalogue.
	
	self should: [shoppingCart add: #anotherBook quantity: 2]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart catalogueDoestNotIncludeItem.
		self assert: shoppingCart isEmpty.
		].! !


!ShoppingCartTest methodsFor: 'setUp' stamp: 'AB 6/5/2019 18:47:39'!
setUp

	emptyCatalogue _ OrderedCollection new.

	oneBookCatalogue _ OrderedCollection new.
	oneBookCatalogue add: #aBook.

	twoBooksCatalogue _ OrderedCollection new.
	twoBooksCatalogue add: #aBook; add: #anotherBook. 

	threeBooksCatalogue _ OrderedCollection new.
	threeBooksCatalogue add: #book1; add: #book2; add: #book3.! !


!classDefinition: #Cashier category: #'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/5/2019 23:09:51'!
expiredCreditCardIsNotValid

	^ 'Credit card has already expired'! !

!Cashier class methodsFor: 'error handling' stamp: 'JR 6/5/2019 07:37:30'!
itemNotFoundInPriceList

	^ 'Shopping cart hast items not found in price list'! !

!Cashier class methodsFor: 'error handling' stamp: 'AB 6/5/2019 18:49:13'!
shoppingCartCanNotBeEmpty

	^ 'Shopping cart cannot be empty'! !


!Cashier class methodsFor: 'checkout' stamp: 'AB 6/5/2019 23:11:46'!
checkout: shoppingCart withPricesFrom: priceList payingWith: creditCard

	| transactionAmout |
	
	(shoppingCart isEmpty) ifTrue: [ self error: Cashier shoppingCartCanNotBeEmpty ].
	
	(shoppingCart items allSatisfy: [ :anItem | priceList includesKey: anItem ]) ifFalse: [ self error: Cashier itemNotFoundInPriceList ].

	(creditCard hasExpired) ifTrue: [ self error: Cashier expiredCreditCardIsNotValid ].
		
	transactionAmout _ 0.	
	shoppingCart items do: [ :anItem | 
			transactionAmout _ transactionAmout + (priceList at: anItem)
		].
	
	! !


!classDefinition: #CreditCard category: #'TusLibros.com'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 23:14:30'!
hasExpired

	^ expiration < GregorianMonthOfYear current! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 22:55:30'!
initializeWith: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersName

	number _ a16DigitsNumber.
	expiration _ aTwoDigitsMonthAndATwoDigitsYear.
	owner _ anOwnersName! !

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

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'AB 6/5/2019 23:01:18'!
with: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersName

	(a16DigitsNumber size = 16) ifFalse: [ self error: CreditCard CardNumberMustBe16DigitsLong ].

	(anOwnersName size between: 1 and: 30) ifFalse: [ self error: CreditCard OwnerNameMustBeBetween1And30CharactersLong ].

	^ self new initializeWith: a16DigitsNumber with: aTwoDigitsMonthAndATwoDigitsYear with: anOwnersName! !


!classDefinition: #ShoppingCart category: #'TusLibros.com'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'items catalogue'
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


!ShoppingCart methodsFor: 'adding' stamp: 'AB 6/1/2019 16:17:51'!
add: anItem

	(catalogue includes: anItem) ifFalse: [ self error: ShoppingCart catalogueDoestNotIncludeItem ].

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


!ShoppingCart methodsFor: 'initialization' stamp: 'AB 6/1/2019 16:06:08'!
initializeWith: aCatalogue

	items _ OrderedCollection new.
	catalogue _ aCatalogue.
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
