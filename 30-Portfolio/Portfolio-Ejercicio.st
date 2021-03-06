!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 22:52:27'!
test01NewPortfolioHasBalanceOfZero

	| aPortfolio |
	
	aPortfolio _ Portfolio new.

	self assert: (aPortfolio balance = 0)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 22:53:05'!
test02PortfolioBalanceChangesWhenAddingAnAccount

	| aPortfolio anAccount |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	
	aPortfolio register: anAccount.
	
	self assert: (aPortfolio balance = anAccount balance)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 22:55:30'!
test03CanNotAddTheSameAccountMoreThanOnce

	| aPortfolio anAccount |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	aPortfolio register: anAccount.
	
	self
		should: [ aPortfolio register: anAccount ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same asset more than once'.
			self assert: (aPortfolio balance = anAccount balance).
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 23:17:21'!
test04AddingAPortfolioAddsUpItsBalance

	| aPortfolio anotherPortfolio anAccount anotherAccount |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	
	anotherPortfolio _ Portfolio new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: 100 on: anotherAccount.

	aPortfolio register: anAccount.
	self assert: (aPortfolio balance = anAccount balance).
	
	anotherPortfolio register: anotherAccount.
	self assert: (anotherPortfolio balance = anotherAccount balance).
		
	aPortfolio register: anotherPortfolio.
	self assert: (aPortfolio balance = (anAccount balance + anotherPortfolio balance))! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 20:09:51'!
test05RegistersATransactionRegisteredInAnAccount

	| aPortfolio anAccount aDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anAccount.

	aPortfolio register: anAccount.

	self assert: (aPortfolio hasRegistered: aDeposit)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 23:22:38'!
test06RegistersATransactionRegisteredInAnAccountInARegisteredPortfolio

	| aPortfolio anotherPortfolio anAccount anotherAccount a50Deposit a100Deposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	a50Deposit _ Deposit register: 50 on: anAccount.
	aPortfolio register: anAccount.
	
	anotherPortfolio _ Portfolio new.
	anotherAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anotherAccount.
	anotherPortfolio register: anotherAccount.

	self assert: (aPortfolio hasRegistered: a50Deposit).
	self deny: (aPortfolio hasRegistered: a100Deposit).

	self assert: (anotherPortfolio hasRegistered: a100Deposit).
	self deny: (anotherPortfolio hasRegistered: a50Deposit).

	aPortfolio register: anotherPortfolio.

	self assert: (aPortfolio hasRegistered: a50Deposit).
	self assert: (aPortfolio hasRegistered: a100Deposit).

	self assert: (anotherPortfolio hasRegistered: a100Deposit).
	self deny: (anotherPortfolio hasRegistered: a50Deposit).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 20:07:53'!
test07GetsTransactionsFromRegisteredAccounts

	| aPortfolio anAccount a50Deposit a100Deposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	a50Deposit _ Deposit register: 50 on: anAccount.
	a100Deposit _ Deposit register: 100 on: anAccount.
	
	aPortfolio register: anAccount.

	self assert: (aPortfolio balance = anAccount balance).
	self assert: (aPortfolio transactions includes: a50Deposit).
	self assert: (aPortfolio transactions includes: a100Deposit).
	self assert: (aPortfolio transactions size = 2)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 20:01:26'!
test08GetsTransactionsFromRegisteredAccountsAndPortfolios

	| aPortfolio anotherPortfolio anAccount anotherAccount a50Deposit a100Deposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	a50Deposit _ Deposit register: 50 on: anAccount.
	aPortfolio register: anAccount.

	anotherPortfolio _ Portfolio new.
	anotherAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anotherAccount.
	anotherPortfolio register: anotherAccount.

	self assert: (aPortfolio transactions size = 1).

	aPortfolio register: anotherPortfolio.

	self assert: (aPortfolio transactions includes: a50Deposit).
	self assert: (anotherPortfolio transactions includes: a100Deposit).
	
	self assert: (aPortfolio transactions includes: a100Deposit).
	self assert: (aPortfolio transactions size = 2)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 20:05:38'!
test09CanNotAddSameAccountWhenComingFromAnotherPortfolio

	| aPortfolio anotherPortfolio anAccount |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	aPortfolio register: anAccount.

	anotherPortfolio _ Portfolio new.
	anotherPortfolio register: anAccount .

	self
		should: [ aPortfolio register: anotherPortfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same asset more than once'.
			self assert: (aPortfolio balance = anAccount balance).
			self assert: (anotherPortfolio balance = anAccount balance).
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 20:06:17'!
test10CanNotCreateACircularReferenceWithTwoPortfolios

	| aPortfolio anotherPortfolio |
	
	aPortfolio _ Portfolio new.
	anotherPortfolio _ Portfolio new.
	aPortfolio register: anotherPortfolio.
	
	self
		should: [ anotherPortfolio register: aPortfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same asset more than once'.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 00:14:11'!
test11CanNotCreateACircularReferenceWithThreePortfolios

	| aPortfolio anotherPortfolio aThirdPortfolio |
	
	aPortfolio _ Portfolio new.
	anotherPortfolio _ Portfolio new.
	aThirdPortfolio _ Portfolio new.

	anotherPortfolio register:aThirdPortfolio. 
	aPortfolio register: anotherPortfolio.

	self
		should: [ aThirdPortfolio register: aPortfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same asset more than once'.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 20:22:52'!
test12CanNotRegisterAnAccountInAPortfolioWithAnotherPortfolioThatHasAlreadyRegisteredSameAccount

	| aPortfolio anotherPortfolio anAccount |
	
	aPortfolio _ Portfolio new.
	anotherPortfolio _ Portfolio new.
	aPortfolio register: anotherPortfolio.

	anAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	anotherPortfolio register: anAccount.

	self
		should: [ aPortfolio register: anAccount. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same asset more than once'.
			self assert: (aPortfolio balance = anAccount balance).
			self assert: (anotherPortfolio balance = anAccount balance).
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/25/2019 21:11:53'!
test13CanNotAddPortfolioToItself

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self
		should: [ aPortfolio register: aPortfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same asset more than once'.
		].! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'AB 5/24/2019 22:44:19'!
affectBalance: aBalance

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'AB 5/24/2019 22:45:50'!
initializeFor: aValue

	value _ aValue! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AB 5/24/2019 22:44:59'!
affectBalance: aBalance

	^ aBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'AB 5/24/2019 22:45:39'!
initializeFor: aValue

	value _ aValue! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'AB 5/24/2019 22:45:20'!
affectBalance: aBalance

	^ aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'transactions' stamp: 'AB 5/25/2019 00:30:47'!
hasRegistered: aTtransaction

	self subclassResponsibility
! !

!FinancialAsset methodsFor: 'transactions' stamp: 'AB 5/25/2019 00:31:36'!
transactions 

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'assets' stamp: 'AB 5/25/2019 00:31:17'!
register: anAsset

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'balance' stamp: 'AB 5/25/2019 00:30:27'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'assets holders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'AB 5/27/2019 12:44:16'!
initialize

	super initialize.
	assets _ OrderedCollection new.
	holders _ OrderedCollection new! !


!Portfolio methodsFor: 'balance' stamp: 'AB 5/24/2019 22:51:55'!
balance

	^ assets inject: 0 into: [ :currentBalance :anAsset | currentBalance + anAsset balance ]! !


!Portfolio methodsFor: 'assets' stamp: 'AB 5/27/2019 12:44:16'!
register: anAsset

	(anAsset = self) ifTrue: [ self error: 'Can not add the same asset more than once' ].

	(anAsset isHeldBy: self) ifTrue: [ self error: 'Can not add the same asset more than once' ].

	anAsset holdBy: self.
	
	holders do: [ :aPortfolio | anAsset holdBy: aPortfolio ].
	
	assets add: anAsset! !


!Portfolio methodsFor: 'portfolios' stamp: 'AB 5/27/2019 12:44:16'!
holdBy: aPortfolio

	holders add: aPortfolio.
	
	assets do: [ :anAsset | anAsset holdBy: aPortfolio ]! !

!Portfolio methodsFor: 'portfolios' stamp: 'AB 5/27/2019 12:44:16'!
isHeldBy: aPortfolio

	^ (holders includes: aPortfolio) 
		or: (assets inject: false into: [ :includes :anAsset | includes or: (anAsset = aPortfolio) or: (anAsset isHeldBy: aPortfolio) ])! !


!Portfolio methodsFor: 'transactions' stamp: 'AB 5/25/2019 19:56:49'!
hasRegistered: aTransaction

	^ assets inject: false into: [ :hasRegistered :anAsset | hasRegistered or: (anAsset hasRegistered: aTransaction) ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'AB 5/24/2019 23:35:14'!
transactions 

	| transactions |

	transactions _ OrderedCollection new.

	assets do: [ :anAsset | transactions addAll: (anAsset transactions) ].
	
	^ transactions ! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions holders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AB 5/27/2019 12:43:57'!
initialize

	super initialize.
	transactions _ OrderedCollection new.
	holders _ OrderedCollection new! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AB 5/24/2019 22:50:55'!
balance

	^ transactions inject: 0 into: [ :currentBalance :aTransaction | aTransaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'portfolios' stamp: 'AB 5/27/2019 12:43:57'!
holdBy: aPortfolio

	holders add: aPortfolio! !

!ReceptiveAccount methodsFor: 'portfolios' stamp: 'AB 5/27/2019 12:43:57'!
isHeldBy: aPortfolio

	^ holders includes: aPortfolio! !
