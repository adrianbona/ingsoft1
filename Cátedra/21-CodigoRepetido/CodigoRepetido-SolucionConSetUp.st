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
	instanceVariableNames: 'customerBook paulMcCartney johnLennon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'assertions' stamp: 'HAW 9/20/2018 09:33:40'!
assertNumberOfActiveCustomersIn: aCustomerBook is: aNumberOfActiveCustomers andSuspendedIs: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfActiveCustomers + aNumberOfSuspendedCustomers equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'HAW 9/19/2018 08:46:51'!
should: aBlock notTakeMoreThan: aLimit
	
	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aLimit.
	
	
	"Solucion Alternativa:"
	"
	|millisecondsRunning|
	
	millisecondsRunning := aBlock timeToRun * millisecond.
	
	self assert: millisecondsRunning < aLimit.
	"
	

! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'NR 9/18/2018 19:50:45'!
should: aBlockToRun raise: anExceptionType asserting: aVerificationBlock

	[ aBlockToRun value.
	self fail ]
		on: anExceptionType 
		do: aVerificationBlock 
	
	"Ver should:raise:withExceptionDo: de TestCase..."
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:39:25'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self 
		should: [ customerBook addCustomerNamed: johnLennon ]
		notTakeMoreThan: 50 * millisecond
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:36:37'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self 
		should: [ customerBook removeCustomerNamed: paulMcCartney ]
		notTakeMoreThan: 100 * millisecond

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:36:43'!
test03CanNotAddACustomerWithEmptyName 

	self 
		should: [ customerBook addCustomerNamed: '' ]
		raise: Error
		asserting: [ :anError |  
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:39:39'!
test04CanNotRemoveAnInvalidCustomer
	
	customerBook addCustomerNamed: johnLennon.
	
	self 
		should: [ customerBook removeCustomerNamed: paulMcCartney]
		raise: NotFound 
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:38:26'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertNumberOfActiveCustomersIn: customerBook is: 0 andSuspendedIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:38:33'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertNumberOfActiveCustomersIn: customerBook is: 0 andSuspendedIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:39:55'!
test07CanNotSuspendAnInvalidCustomer

	customerBook addCustomerNamed: johnLennon.
	
	self
		should: [ customerBook suspendCustomerNamed: paulMcCartney]
		raise: CantSuspend 
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/24/2018 02:39:06'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
		should: [ customerBook suspendCustomerNamed: johnLennon ]
		raise: CantSuspend 
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'setUp' stamp: 'NR 9/24/2018 02:44:57'!
setUp
		
		"Atención: Analizar pros y cons de utilizar este mensaje cuando los objetos son mutables. Probar hacer el debug de un test (por ej. el 06) y darle restart antes de que termine. ¿Qué ocurre con las colecciones?"
		
		customerBook := CustomerBook  new.
		paulMcCartney := 'Paul McCartney'.
		johnLennon := 'John Lennon'.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 9/24/2018 02:27:53'!
includesCustomerNamed: aName

	^(active includes: aName) or: [suspended includes: aName]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 9/24/2018 02:27:53'!
isEmpty
	
	^active isEmpty and: [suspended isEmpty]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/24/2018 02:27:53'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/24/2018 02:27:53'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/24/2018 02:27:53'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:55:16'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 18:05:35'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/24/2018 02:27:53'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [ ^ NotFound signal ]].
	
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/24/2018 02:27:53'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent:[ ^ CantSuspend signal ].
			
	suspended add: aName


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
