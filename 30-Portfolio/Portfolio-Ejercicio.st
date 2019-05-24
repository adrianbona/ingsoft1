!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 02:00:21'!
test01NewPortfolioHasBalanceOfZero

	| aPortfolio |
	
	aPortfolio _ Portfolio new.

	self assert: (aPortfolio balance = 0).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 01:54:24'!
test02PortfolioBalanceChangesWhenAddingAnAccount

	| aPortfolio anAccount aDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anAccount.
	
	aPortfolio register: anAccount.
	
	self assert: (aPortfolio balance = aDeposit value)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 02:01:03'!
test03CanNotAddTheSameAccountMoreThanOnce

	| aPortfolio anAccount aDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anAccount.
	aPortfolio register: anAccount.
	
	self
		should: [ aPortfolio register: anAccount ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same financial asset more than once'.
			self assert: (aPortfolio balance = aDeposit value).
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 00:00:03'!
test04AddingAPortfolioAddsUpItsBalance

	| aPortfolio anotherPortfolio anAccount anotherAccount |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	
	anotherPortfolio _ Portfolio new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anotherAccount.

	aPortfolio register: anAccount.
	anotherPortfolio register: anotherAccount.
	aPortfolio register: anotherPortfolio.

	self assert: (aPortfolio balance = (anAccount balance + anotherPortfolio balance))! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 00:31:36'!
test05RegistersATransactionRegisteredInAnAccount

	| aPortfolio anAccount aDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anAccount.

	self deny: (aPortfolio hasRegistered: aDeposit).
	
	aPortfolio register: anAccount.

	self assert: (aPortfolio hasRegistered: aDeposit)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 00:35:59'!
test06RegistersATransactionRegisteredInAnAccountInARegisteredPortfolio

	| aPortfolio anotherPortfolio anAccount anotherAccount aDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	
	anotherPortfolio _ Portfolio new.
	anotherAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anotherAccount.

	aPortfolio register: anAccount.
	anotherPortfolio register: anotherAccount.

	self deny: (aPortfolio hasRegistered: aDeposit).
	self assert: (anotherPortfolio hasRegistered: aDeposit).

	aPortfolio register: anotherPortfolio.

	self assert: (aPortfolio hasRegistered: aDeposit).
	self assert: (anotherPortfolio hasRegistered: aDeposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 01:23:46'!
test07GetsTransactionsFromRegisteredAccounts

	| aPortfolio anAccount aDeposit anotherDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anAccount.
	anotherDeposit _ Deposit register: 50 on: anAccount.
	
	aPortfolio register: anAccount.

	self assert: (aPortfolio transactions includes: aDeposit).
	self assert: (aPortfolio transactions includes: anotherDeposit).
	self assert: (aPortfolio transactions size = 2)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 01:23:51'!
test08GetsTransactionsFromRegisteredAccountsAndPortfolios

	| aPortfolio anotherPortfolio anAccount anotherAccount aDeposit anotherDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anAccount.
	aPortfolio register: anAccount.

	anotherPortfolio _ Portfolio new.
	anotherAccount _ ReceptiveAccount new.
	anotherDeposit _ Deposit register: 100 on: anotherAccount.
	anotherPortfolio register: anotherAccount.

	aPortfolio register: anotherPortfolio.

	self assert: (aPortfolio transactions includes: aDeposit).
	self assert: (anotherPortfolio transactions includes: anotherDeposit).
	
	self assert: (aPortfolio transactions includes: anotherDeposit).
	self assert: (aPortfolio transactions size = 2)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'AB 5/24/2019 18:42:36'!
test09CanNotAddSameAccountWhenComingFromAnotherPortfolio

	| aPortfolio anotherPortfolio anAccount aDeposit |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit register: 50 on: anAccount.
	aPortfolio register: anAccount.

	anotherPortfolio _ Portfolio new.
	anotherPortfolio register: anAccount .

	self
		should: [ aPortfolio register: anotherPortfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not add the same financial asset more than once'.
			self assert: (aPortfolio balance = aDeposit value).
			
			self assert: (aPortfolio isRegisteredIn: anotherPortfolio).
			self assert: (anotherPortfolio isRegisteredIn: aPortfolio).
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


!AccountTransaction methodsFor: 'balance' stamp: 'AB 5/23/2019 20:53:40'!
affectBalance: aBalance

	self subclassResponsibility ! !

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

!Deposit methodsFor: 'initialization' stamp: 'AB 5/23/2019 23:21:28'!
initializeFor: aValue

	value _ aValue! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AB 5/23/2019 20:54:15'!
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

!Withdraw methodsFor: 'initialization' stamp: 'AB 5/23/2019 20:18:47'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'AB 5/23/2019 20:15:58'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'AB 5/23/2019 20:54:34'!
affectBalance: aBalance

	^ aBalance - value ! !

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

!FinancialAsset methodsFor: 'balance' stamp: 'AB 5/23/2019 21:55:56'!
balance

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'assets' stamp: 'AB 5/24/2019 00:06:34'!
hasRegistered: aRegistrableAsset

	self subclassResponsibility! !

!FinancialAsset methodsFor: 'assets' stamp: 'AB 5/24/2019 00:03:20'!
register: aRegistrableAsset

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'transactions' stamp: 'AB 5/24/2019 00:36:51'!
transactions

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'portfolios' stamp: 'AB 5/24/2019 18:43:28'!
isRegisteredIn: aPortfolio

	self subclassResponsibility! !

!FinancialAsset methodsFor: 'portfolios' stamp: 'AB 5/24/2019 18:44:25'!
registerIn: aPortfolio

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets registeredIn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!
!Portfolio commentStamp: '<historical>' prior: 0!
Un portfolio es una agrupación de cuentas o portfolios, y se puede hacer con ellos lo mismo que con una cuenta salvo registrar transacciones.!


!Portfolio methodsFor: 'initialization' stamp: 'AB 5/24/2019 18:29:45'!
initialize

	super initialize.
	financialAssets _ OrderedCollection new.
	registeredIn _ OrderedCollection new! !


!Portfolio methodsFor: 'transactions' stamp: 'AB 5/24/2019 01:05:58'!
hasRegistered: aTransaction

	^ financialAssets inject: false into: [ :transactionFound :aFinancialAsset | transactionFound or: (aFinancialAsset hasRegistered: aTransaction) ]! !

!Portfolio methodsFor: 'transactions' stamp: 'AB 5/24/2019 01:22:50'!
transactions 

	| transactions |

	transactions _ OrderedCollection new.

	financialAssets do: [ :aFinancialAsset | transactions addAll: (aFinancialAsset transactions) ].
	
	^ transactions! !


!Portfolio methodsFor: 'balance' stamp: 'AB 5/23/2019 23:57:46'!
balance
	
	^ financialAssets sum: [:aFinancialAsset | aFinancialAsset balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'assets' stamp: 'AB 5/24/2019 17:48:19'!
register: aFinancialAsset
	
	(financialAssets includes: aFinancialAsset) ifTrue: [^ self error: 'Can not add the same financial asset more than once'].
	(aFinancialAsset isRegisteredIn: self) ifTrue: [^ self error: 'Can not add the same financial asset more than once'].
	
	aFinancialAsset registerIn: self.
	financialAssets add: aFinancialAsset.! !


!Portfolio methodsFor: 'portfolios' stamp: 'AB 5/24/2019 18:04:34'!
isRegisteredIn: aPortfolio

	^ (registeredIn includes: aPortfolio) or: (financialAssets inject: false into: [ :isRegistered :aFinancialAsset | isRegistered or: (aFinancialAsset isRegisteredIn: aPortfolio) ])! !

!Portfolio methodsFor: 'portfolios' stamp: 'AB 5/24/2019 18:35:41'!
registerIn: aPortfolio

	registeredIn add: aPortfolio.
	financialAssets do: [ :anAsset | anAsset registerIn: aPortfolio ]! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions registeredIn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AB 5/24/2019 18:29:54'!
initialize

	super initialize.
	transactions _ OrderedCollection new.
	registeredIn _ OrderedCollection new! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AB 5/24/2019 00:01:54'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AB 5/23/2019 21:33:27'!
balance

	^ transactions inject: 0 into: [ :currentBalance :aTransaction | aTransaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'portfolios' stamp: 'AB 5/24/2019 17:47:26'!
isRegisteredIn: aPortfolio

	^ registeredIn includes: aPortfolio! !

!ReceptiveAccount methodsFor: 'portfolios' stamp: 'AB 5/24/2019 18:02:47'!
registerIn: aPortfolio

	registeredIn add: aPortfolio! !
