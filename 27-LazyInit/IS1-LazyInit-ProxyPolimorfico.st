!classDefinition: #ProviderTest category: #'IS1-LazyInit-ProxyPolimorfico'!
TestCase subclass: #ProviderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyPolimorfico'!

!ProviderTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 20:03:39'!
test01

	| juanPerez |
	
	juanPerez := Provider named: 'Juan' surnamed: 'Perez'.
	
	self assert: (PhoneBook phonesFor: juanPerez) equals: juanPerez phones.
	self assert: juanPerez phones == juanPerez phones! !

!ProviderTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 20:03:24'!
test02

	| juanPerez |
	
	juanPerez := Provider named: 'Juan' surnamed: 'Perez'.
	
	self assert: (AddressBook addressesFor: juanPerez) equals: juanPerez addresses.
	self assert: juanPerez addresses == juanPerez addresses ! !


!classDefinition: #AddressBook category: #'IS1-LazyInit-ProxyPolimorfico'!
Object subclass: #AddressBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyPolimorfico'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddressBook class' category: #'IS1-LazyInit-ProxyPolimorfico'!
AddressBook class
	instanceVariableNames: ''!

!AddressBook class methodsFor: 'querying' stamp: 'HAW 5/8/2019 20:00:45'!
addressesFor: aProvider

	^aProvider name = 'Juan' 
		ifTrue: [ Array with: 'Alem 888' with: 'Maipu 333' ]
		ifFalse: [ #() ]! !


!classDefinition: #PhoneBook category: #'IS1-LazyInit-ProxyPolimorfico'!
Object subclass: #PhoneBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyPolimorfico'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PhoneBook class' category: #'IS1-LazyInit-ProxyPolimorfico'!
PhoneBook class
	instanceVariableNames: ''!

!PhoneBook class methodsFor: 'quering' stamp: 'HAW 5/8/2019 20:01:06'!
phonesFor: aProvider 

	^aProvider name = 'Juan' 
		ifTrue: [Array with: '3434-1111' with: '5555-6666' ]
		ifFalse: [ #() ]! !


!classDefinition: #Provider category: #'IS1-LazyInit-ProxyPolimorfico'!
Object subclass: #Provider
	instanceVariableNames: 'firstName lastName phones addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyPolimorfico'!

!Provider methodsFor: 'initialization' stamp: 'HAW 5/8/2019 20:11:07'!
initializeNamed: aFirstName surnamed: aLastName 

	firstName := aFirstName.
	lastName := aLastName.
	phones := LazyInitProxy instantiatingProxeeWith: [ PhoneBook phonesFor: self ].
	addresses := LazyInitProxy instantiatingProxeeWith: [ AddressBook addressesFor: self ].! !


!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 20:10:40'!
addresses

	^addresses ! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:10'!
firstName

	^firstName ! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:15'!
lastName

	^lastName! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 20:10:46'!
phones

	^phones ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Provider class' category: #'IS1-LazyInit-ProxyPolimorfico'!
Provider class
	instanceVariableNames: ''!

!Provider class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:45:58'!
named: aFirstName surnamed: aLastName

	^self new initializeNamed: aFirstName surnamed: aLastName ! !


!classDefinition: #LazyInitProxy category: #'IS1-LazyInit-ProxyPolimorfico'!
ProtoObject subclass: #LazyInitProxy
	instanceVariableNames: 'initClosure value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyPolimorfico'!

!LazyInitProxy methodsFor: 'proxee' stamp: 'HAW 9/25/2017 18:39:00'!
value

	value isNil ifTrue: [ value := initClosure value].
	^value 
	
	! !


!LazyInitProxy methodsFor: 'initialization' stamp: 'HAW 5/8/2019 20:11:46'!
initializeInstantiatingProxeeWith: anInitClosure

	initClosure := anInitClosure.! !


!LazyInitProxy methodsFor: 'message handling' stamp: 'HAW 9/26/2017 08:17:50'!
doesNotUnderstand: aMessage

	"Implementacion con desproxeo de Proxy
	self value become: self.
	^aMessage sendTo: self
	"
	
	"Implementacion de Proxy generico sin desproxeo"
	^aMessage sendTo: self value! !


!LazyInitProxy methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:44:49'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!LazyInitProxy methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:45:07'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LazyInitProxy class' category: #'IS1-LazyInit-ProxyPolimorfico'!
LazyInitProxy class
	instanceVariableNames: ''!

!LazyInitProxy class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 20:11:38'!
instantiatingProxeeWith: anInitClosure

	^ self new initializeInstantiatingProxeeWith: anInitClosure.! !
