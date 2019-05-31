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


!classDefinition: #ShoppingCart category: #'TusLibros.com'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:12:21'!
add: aBook

	^ items add: aBook! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:35:03'!
add: aBook quantity: aQuantity

	^ aQuantity timesRepeat: [ self add: aBook ]! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'AB 5/31/2019 11:16:03'!
contains: aBook

	^ items includes: aBook! !

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
