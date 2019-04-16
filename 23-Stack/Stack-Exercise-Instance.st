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
	instanceVariableNames: 'emptyString whiteSpaceString emptyStack oneElementStack oneString twoString twoElementsStack nonMatchingString catedraPrefix catedraStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'jr 4/16/2019 18:59:50'!
setUp

	emptyString := ''.
	whiteSpaceString := ' '.
	nonMatchingString := 'XXX'.
	
	oneString := 'Foo'.
	twoString := 'Bar'.

	emptyStack := OOStack new.
	oneElementStack := OOStack new push: oneString.
	twoElementsStack := (OOStack new push: oneString) push: twoString.

	catedraPrefix := 'Wint'.
	catedraStack := (((OOStack new push: 'winter is coming') push: 'winning is everything') push: 'The winds of Winter') push: 'Winter is here'.! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 19:58:43'!
test01returnsNoResultsWhenSearchingInEmptyStack

	self assert: (SentenceFinderByPrefix find: oneString in: emptyStack) find size = 0! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:03:54'!
test02returnsAnErrorWhenSearchingForEmptyStringInEmptyStack

	self should: [
		(SentenceFinderByPrefix find: emptyString in: emptyStack) find.
	]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription.
	]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:04:18'!
test03returnsAnErrorWhenSearchingForEmptyStringInOneElementStack

	self should: [
		(SentenceFinderByPrefix find: emptyString in: oneElementStack) find.
	]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription.
	]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:04:30'!
test04returnsEmptyCollectionWhenSearchingForNonMatchingStringInOneElementStack

	self assert: (SentenceFinderByPrefix find: nonMatchingString in: oneElementStack) find size = 0! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:07:05'!
test05returnsACollectionWithMatchingElementWhenSearchingForAMatchingStringInOneElementStack

	| aCollection |
	
	aCollection := (SentenceFinderByPrefix find: oneString in: oneElementStack) find.

	self assert: aCollection size = 1.
	self assert: aCollection first = oneElementStack pop.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:07:20'!
test06returnsAnErrorWhenSearchingForEmptyStringInTwoElementStack

	self should: [
		(SentenceFinderByPrefix find: emptyString in: twoElementsStack) find.
	]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription.
	]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:07:32'!
test07returnsEmptyCollectionWhenSearchingForNonMatchingStringInTwoElementStack

	self assert: (SentenceFinderByPrefix find: nonMatchingString in: twoElementsStack) find size = 0! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:07:41'!
test08catedraExampleWorks

	self assert: (SentenceFinderByPrefix find: catedraPrefix in: catedraStack) find size = 1.
	self assert: (SentenceFinderByPrefix find: catedraPrefix in: catedraStack) find first = 'Winter is here'! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:07:46'!
test09returnsEmptyCollectionWhenSearchingForMatchingStringWithDifferentCasing

	self assert: (SentenceFinderByPrefix find: 'foo' in: twoElementsStack ) find size = 0! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:07:57'!
test10stackDoesntMutateAfterSentenceFinder

	| comparingStack |
	
	comparingStack := (OOStack new push: oneString ) push: twoString .
	
	(SentenceFinderByPrefix find: nonMatchingString in: twoElementsStack) find.
	
	self assert: comparingStack pop equals: twoElementsStack pop.
	
	self assert: comparingStack pop equals: twoElementsStack pop.
	
	self assert: comparingStack isEmpty.
	
	self assert: twoElementsStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:08:07'!
test11returnsAnErrorWhenSearchingForStringWithWhitespaceInOneElementStack

	self should: [
		(SentenceFinderByPrefix find: whiteSpaceString in: oneElementStack) find.
	]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixCantContainWhiteSpacesErrorDescription.
	]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:08:15'!
test12returnsAnErrorWhenSearchingForStringWithWhitespaceInEmptyStack

	self should: [
		(SentenceFinderByPrefix find: whiteSpaceString in: emptyStack) find.
	]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixCantContainWhiteSpacesErrorDescription.
	]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'jr 4/16/2019 20:08:23'!
test13returnsAnErrorWhenSearchingForStringWithWhitespaceInTwoElementStack

	self should: [
		(SentenceFinderByPrefix find: whiteSpaceString in: twoElementsStack) find.
	]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixCantContainWhiteSpacesErrorDescription.
	]! !


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
	instanceVariableNames: 'stack prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'jr 4/16/2019 20:06:49'!
find

	| aCollection backUpStack |

	aCollection := OrderedCollection new.
	backUpStack := OOStack new.

	SentenceFinderByPrefix moveFrom: stack to: backUpStack whileDoing:
	[
		:anElement | (anElement indexOfSubCollection: prefix startingAt: 1) = 1 ifTrue:
		[
			aCollection add: anElement.
		].
	].

	SentenceFinderByPrefix moveFrom: backUpStack to: stack.

	^ aCollection ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'jr 4/16/2019 19:57:33'!
initializeWith: aPrefix and: aStack

	stack _ aStack.
	prefix _ aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jr 4/16/2019 19:57:14'!
find: aPrefix in: aStack

	aPrefix size = 0 ifTrue: [ ^ self error: self prefixEmptyErrorDescription]. 

	(aPrefix indexOfSubCollection: ' ' startingAt: 1) > 0 ifTrue: [^ self error: self prefixCantContainWhiteSpacesErrorDescription.].

	^ self new initializeWith: aPrefix and: aStack. ! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jr 4/16/2019 19:42:36'!
moveFrom: originStack to: destinationStack

	self moveFrom: originStack to: destinationStack whileDoing: [ :anElement ]! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jr 4/16/2019 19:39:02'!
moveFrom: originStack to: destinationStack whileDoing: aBlock

	[originStack isEmpty] whileFalse: [
		| anElement |
		anElement := originStack pop.

		aBlock value: anElement.

		destinationStack push: anElement.
	].! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jr 4/16/2019 19:57:51'!
prefixCantContainWhiteSpacesErrorDescription

	^ 'Prefix can not contain white spaces'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'jr 4/16/2019 19:57:54'!
prefixEmptyErrorDescription

	^ 'Prefix can not be an empty string'.! !


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
