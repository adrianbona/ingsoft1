!classDefinition: #ProviderTest category: #'IS1-LazyInit-ProxyNoPolimorfico'!
TestCase subclass: #ProviderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyNoPolimorfico'!

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


!classDefinition: #AddressBook category: #'IS1-LazyInit-ProxyNoPolimorfico'!
Object subclass: #AddressBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyNoPolimorfico'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddressBook class' category: #'IS1-LazyInit-ProxyNoPolimorfico'!
AddressBook class
	instanceVariableNames: ''!

!AddressBook class methodsFor: 'querying' stamp: 'HAW 5/8/2019 20:00:45'!
addressesFor: aProvider

	^aProvider name = 'Juan' 
		ifTrue: [ Array with: 'Alem 888' with: 'Maipu 333' ]
		ifFalse: [ #() ]! !


!classDefinition: #LazyInitProxyNoPolimorfico category: #'IS1-LazyInit-ProxyNoPolimorfico'!
Object subclass: #LazyInitProxyNoPolimorfico
	instanceVariableNames: 'initClosure value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyNoPolimorfico'!

!LazyInitProxyNoPolimorfico methodsFor: 'initialization' stamp: 'HAW 5/8/2019 20:08:54'!
initializeWith: anInitClosure 

	initClosure := anInitClosure ! !


!LazyInitProxyNoPolimorfico methodsFor: 'value' stamp: 'HAW 5/8/2019 20:09:23'!
value

	value isNil ifTrue: [ value := initClosure value ].
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LazyInitProxyNoPolimorfico class' category: #'IS1-LazyInit-ProxyNoPolimorfico'!
LazyInitProxyNoPolimorfico class
	instanceVariableNames: ''!

!LazyInitProxyNoPolimorfico class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 20:12:33'!
instantiatingProxeeWith: anInitClosure

	^self new initializeWith: anInitClosure ! !


!classDefinition: #PhoneBook category: #'IS1-LazyInit-ProxyNoPolimorfico'!
Object subclass: #PhoneBook
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyNoPolimorfico'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PhoneBook class' category: #'IS1-LazyInit-ProxyNoPolimorfico'!
PhoneBook class
	instanceVariableNames: ''!

!PhoneBook class methodsFor: 'quering' stamp: 'HAW 5/8/2019 20:01:06'!
phonesFor: aProvider 

	^aProvider name = 'Juan' 
		ifTrue: [Array with: '3434-1111' with: '5555-6666' ]
		ifFalse: [ #() ]! !


!classDefinition: #Provider category: #'IS1-LazyInit-ProxyNoPolimorfico'!
Object subclass: #Provider
	instanceVariableNames: 'firstName lastName phones addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-LazyInit-ProxyNoPolimorfico'!

!Provider methodsFor: 'initialization' stamp: 'HAW 5/8/2019 20:12:33'!
initializeNamed: aFirstName surnamed: aLastName 

	firstName := aFirstName.
	lastName := aLastName.
	phones := LazyInitProxyNoPolimorfico instantiatingProxeeWith: [ PhoneBook phonesFor: self ].
	addresses := LazyInitProxyNoPolimorfico instantiatingProxeeWith: [ AddressBook addressesFor: self ].! !


!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 20:07:49'!
addresses

	^addresses value! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:10'!
firstName

	^firstName ! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:15'!
lastName

	^lastName! !

!Provider methodsFor: 'accessing' stamp: 'HAW 5/8/2019 20:07:59'!
phones

	^phones value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Provider class' category: #'IS1-LazyInit-ProxyNoPolimorfico'!
Provider class
	instanceVariableNames: ''!

!Provider class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:45:58'!
named: aFirstName surnamed: aLastName

	^self new initializeNamed: aFirstName surnamed: aLastName ! !
