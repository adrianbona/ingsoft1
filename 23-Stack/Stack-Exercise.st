!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'AB 4/16/2019 13:23:20'!
setUp

	emptyStack := OOStack new.
! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 4/16/2019 13:23:10'!
test01emptyStackReturnsNoResults

	self assert: emptyStack size = 0! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 4/16/2019 13:23:33'!
test01emptyStackReturnsNoResultsWhenFiltering

	self assert: emptyStack size = 0! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'handling' stamp: 'AB 4/16/2019 11:48:51'!
isEmpty

	^ top isEmpty! !

!OOStack methodsFor: 'handling' stamp: 'AB 4/16/2019 11:49:35'!
pop

	| topElement |
	
	topElement _ top value.
	top _ top previous.
	size _ size - 1.
	
	^ topElement.! !

!OOStack methodsFor: 'handling' stamp: 'AB 4/16/2019 11:52:05'!
push: anElement

	| newElementOnTop |

	newElementOnTop _ StackElement new.
	newElementOnTop withElement: anElement andPrevious: top.
	size _ size + 1.
	top _ newElementOnTop.! !

!OOStack methodsFor: 'handling' stamp: 'AB 4/16/2019 11:52:10'!
size

	^ size! !

!OOStack methodsFor: 'handling' stamp: 'AB 4/16/2019 11:52:14'!
top

	^ top value! !


!OOStack methodsFor: 'initialization'!
initialize
	size _ 0.
	top _ StackBottom new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions'!
stackEmptyErrorDescription
	^ 'Stack is empty'.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackBottom category: #'Stack-Exercise'!
Object subclass: #StackBottom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBottom methodsFor: 'handling' stamp: 'AB 4/16/2019 11:44:56'!
isEmpty

	^ true! !

!StackBottom methodsFor: 'handling' stamp: 'AB 4/16/2019 11:45:00'!
previous

	self error: OOStack stackEmptyErrorDescription! !

!StackBottom methodsFor: 'handling' stamp: 'AB 4/16/2019 11:45:05'!
value

	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'handling' stamp: 'AB 4/16/2019 11:45:52'!
isEmpty

	^ false! !

!StackElement methodsFor: 'handling' stamp: 'AB 4/16/2019 11:45:57'!
previous

	^ previous! !

!StackElement methodsFor: 'handling' stamp: 'AB 4/16/2019 11:46:04'!
value

	^ value! !


!StackElement methodsFor: 'initialization' stamp: 'AB 4/16/2019 11:46:36'!
withElement: anElement andPrevious: aStackElement

	value _ anElement.
	previous _ aStackElement.! !
