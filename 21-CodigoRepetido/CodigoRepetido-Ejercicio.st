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

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/5/2019 19:02:30'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	self assertThatExecutionOf: [customerBook addCustomerNamed: 'John Lennon'] inMillisecondsIsLessThan: 50.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/5/2019 19:02:44'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWith: paulMcCartney.
	self assertThatExecutionOf: [customerBook removeCustomerNamed: paulMcCartney] inMillisecondsIsLessThan: 100.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/7/2019 15:10:26'!
test03CanNotAddACustomerWithEmptyName
	| customerBook |
	customerBook := CustomerBook new.
	
	self 
		should: [ 
			customerBook addCustomerNamed: '' 
		]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty
		]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/7/2019 15:22:36'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWith: johnLennon.

	self 
		should: [ 
			customerBook removeCustomerNamed: 'Paul McCartney'
		]
		raise: NotFound
		withExceptionDo: [ :anException |
			self assert: (customerBook includesCustomerNamed: johnLennon).
			self assert: customerBook numberOfCustomers = 1
		]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/5/2019 19:03:03'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWith: paulMcCartney.

	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook activeUsersEquals: 0 suspendedUsersEquals: 1 totalUsersEquals: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/5/2019 19:03:21'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self initializeCustomerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook activeUsersEquals: 0 suspendedUsersEquals: 0 totalUsersEquals: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/5/2019 19:03:49'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWith: johnLennon.
	
	self assertThatCantSuspend: johnLennon in: customerBook whenSuspending: 'Paul McCartney'.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 4/5/2019 19:04:06'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self initializeCustomerBookWith: johnLennon.

	customerBook suspendCustomerNamed: johnLennon.

	self assertThatCantSuspend: johnLennon in: customerBook whenSuspending: johnLennon.! !


!CustomerBookTest methodsFor: 'auxiliares' stamp: 'AB 4/7/2019 15:24:22'!
assertThatCantSuspend: aCustomer in: aCustomerBook whenSuspending: anotherCustomer

	self should: [ 
		aCustomerBook suspendCustomerNamed: anotherCustomer
	]
	raise: CantSuspend
	withExceptionDo:
	[ :anError | 
		self assert: aCustomerBook numberOfCustomers = 1.
		self assert: (aCustomerBook includesCustomerNamed: aCustomer) ]! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'AB 4/7/2019 15:24:42'!
assertThatExecutionOf: aBlock inMillisecondsIsLessThan: aQuantityOfMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < (aQuantityOfMilliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'AB 4/5/2019 19:05:37'!
assertThatIn: aCustomerBook activeUsersEquals: aNumberOfActiveUsers suspendedUsersEquals: aNumberOfSuspendedUsers totalUsersEquals: aNumberOfTotalUsers

	self assert: aNumberOfActiveUsers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedUsers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfTotalUsers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'AB 4/5/2019 19:05:51'!
initializeCustomerBookWith: aCustomer

	| customerBook |

	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	^ customerBook.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'AB 4/5/2019 18:59:04'!
try: aBlock failWith: aSignal  assertThat: anotherBlock
	
	[ aBlock value.
	self fail ]
		on: aSignal 
		do: anotherBlock.! !


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


!CustomerBook methodsFor: 'customer management' stamp: 'JR 4/6/2019 15:34:50'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JR 4/6/2019 15:37:29'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers .! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JR 4/7/2019 20:55:42'!
removeCustomerNamed: aName 
 
	(self removeCustomerNamed: aName from: active) ifTrue: [^ aName ].
	(self removeCustomerNamed: aName from: suspended) ifTrue: [^ aName].
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'JR 4/7/2019 20:55:23'!
removeCustomerNamed: aName from: aCollectionOfCustomers
 
	aCollectionOfCustomers 
		detect: [ :element | 
			element  = aName 
		]
		ifFound: [ :element |
			aCollectionOfCustomers remove: element.
			^ true
		]
		ifNone: [
			^ false
		]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'JR 4/6/2019 15:57:42'!
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
