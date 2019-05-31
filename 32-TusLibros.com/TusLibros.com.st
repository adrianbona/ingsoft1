!classDefinition: #ShoppingCartTest category: #'TusLibros.com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:04:45'!
test01CreateNewShoppingCartIsEmptyCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart new.
	
	self assert: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:08:13'!
test02WhenAddingBookToShoppingCarItIsNotEmpty

	| shoppingCart |
	
	shoppingCart _ ShoppingCart new.
	
	shoppingCart add: #book.
	
	self deny: shoppingCart isEmpty! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:15:31'!
test03WhenAddingBookToShoppingCartICanCheckIsThere

	| shoppingCart |
	
	shoppingCart _ ShoppingCart new.
	
	shoppingCart add: #book.
	
	self deny: shoppingCart isEmpty.
	self assert: (shoppingCart contains: #book)! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:22:49'!
test04AddingTwoBooksMakesSizeTwoAndBothAreContained

	| shoppingCart |
	
	shoppingCart _ ShoppingCart new.
	
	shoppingCart add: #aBook.
	shoppingCart add: #anotherBook.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #aBook).
	self assert: (shoppingCart contains: #anotherBook)! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:33:29'!
test05AddTwoCopiesOfTheSameBookAssertInclusionInCart

	| shoppingCart |
	
	shoppingCart _ ShoppingCart new.
	
	shoppingCart add: #aBook quantity: 2.
	
	self deny: shoppingCart isEmpty.
	self assert: 2 equals: shoppingCart itemsAmount.
	self assert: (shoppingCart contains: #aBook)! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:12:50'!
test06AddingABookWithAQuantityLessThan1ThrowsAnError

	| shoppingCart |
	
	shoppingCart _ ShoppingCart new.
	
	self should: [shoppingCart add: #book quantity: 0]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = ShoppingCart quantityMustBeBiggerThanOneError.
		self assert: shoppingCart isEmpty.
		].! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:29:58'!
test07AShoppingCartReturnsNumberOfCopiesOfABook 

	| shoppingCart |
	
	shoppingCart _ ShoppingCart new.
	self assert: (shoppingCart quantityOf: #aBook) = 0.
	
	shoppingCart add: #aBook quantity: 3.
	self assert: (shoppingCart quantityOf: #aBook) = 3.! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:58:00'!
test08AShoppingCartReturnsACollectionOfItsDistinctBooks 

	| shoppingCart distinctBooks |
	
	shoppingCart _ ShoppingCart new.
	
	shoppingCart add: #book1 quantity: 1.
	shoppingCart add: #book2 quantity: 2.
	shoppingCart add: #book3 quantity: 3.
	
	distinctBooks _ shoppingCart distinctItems.
	
	self assert: (distinctBooks occurrencesOf: #book1) = 1.
	self assert: (distinctBooks occurrencesOf: #book2) = 1.
	self assert: (distinctBooks occurrencesOf: #book3) = 1! !


!classDefinition: #ShoppingCart category: #'TusLibros.com'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:43:18'!
add: anItem

	^ items add: anItem! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:43:23'!
add: anItem quantity: aQuantity

	(aQuantity < 1) ifTrue: [ self error: ShoppingCart quantityMustBeBiggerThanOneError].
	
	^ aQuantity timesRepeat: [ self add: anItem ]! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:43:29'!
contains: anItem

	^ items includes: anItem! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:10:11'!
initialize

	items _ OrderedCollection new.
	super initialize! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:12:37'!
isEmpty

	^ items isEmpty! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:23:00'!
itemsAmount

	^ items size! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:43:38'!
quantityOf: anItem

	^ items occurrencesOf: anItem.! !


!ShoppingCart methodsFor: 'accessing' stamp: 'JR 5/31/2019 19:58:00'!
distinctItems
	
	^ items asSet! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros.com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'JR 5/31/2019 19:09:34'!
quantityMustBeBiggerThanOneError
	
	^ 'Quantity must be bigger than one.'! !
