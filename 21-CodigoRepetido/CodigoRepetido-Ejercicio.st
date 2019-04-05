!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:16:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new. 
	self assertThatExecutionOf: [customerBook addCustomerNamed: 'John Lennon'] inMillisecondsIsLessThan: 50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:18:26'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWith: paulMcCartney.
	self assertThatExecutionOf: [customerBook removeCustomerNamed: paulMcCartney] inMillisecondsIsLessThan: 100.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:41:20'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self asserts:
		[ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
	signals: Error
	whenIsExecuted:
		[ customerBook addCustomerNamed: ''.
			self fail ]. 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:36:18'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := self initializeCustomerBookWith: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:11:45'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWith: paulMcCartney.

	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook activeUsersEquals: 0 suspendedUsersEquals: 1 totalUsersEquals: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:12:03'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook activeUsersEquals: 0 suspendedUsersEquals: 0 totalUsersEquals: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:20:31'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWith: johnLennon.
	
	self assertThatCantSuspend: johnLennon in: customerBook whenSuspending: 'Paul McCartney'. 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:20:24'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWith: johnLennon.
	
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertThatCantSuspend: johnLennon in: customerBook whenSuspending: johnLennon.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 22:02:39'!
try: aBlock failWith: aSignal  assert: anotherBlock
	
	[ aBlock value.
	self fail ]
		on: aSignal 
		do: anotherBlock. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 22:02:15'!
try: aBlock failWith: aSignal  assertThat: anotherBlock
	
	[ aBlock value.
	self fail ]
		on: aSignal 
		do: anotherBlock. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:52:54'!
xxx
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.		
	customerBook := self initializeCustomerBookWith: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jr 4/4/2019 21:56:02'!
xxx: aBlock yyy: signal  zzz: anotherBlock
	
	[ aBlock value.
	self fail ]
		on: signal 
		do: anotherBlock. ! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'jr 4/4/2019 21:20:10'!
assertThatCantSuspend: aCustomer in: aCustomerBook whenSuspending: anotherCustomer

	[ aCustomerBook suspendCustomerNamed: anotherCustomer.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aCustomer) ]! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'jr 4/4/2019 21:15:49'!
assertThatExecutionOf: aBlock inMillisecondsIsLessThan: aQuantityOfMilliseconds
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < (aQuantityOfMilliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'jr 4/4/2019 21:10:57'!
assertThatIn: aCustomerBook activeUsersEquals: aNumberOfActiveUsers suspendedUsersEquals: aNumberOfSuspendedUsers totalUsersEquals: aNumberOfTotalUsers

	self assert: aNumberOfActiveUsers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedUsers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfTotalUsers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'jr 4/4/2019 21:39:08'!
asserts: anAssertionBlock signals: anException whenIsExecuted: aBlock

	aBlock on: anException do: anAssertionBlock ! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'jr 4/4/2019 19:42:57'!
initializeCustomerBookWith: aCustomer
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	^ customerBook.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
