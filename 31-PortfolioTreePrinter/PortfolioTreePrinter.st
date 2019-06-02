!classDefinition: #AccountReportTest category: #PortfolioTreePrinter!
TestCase subclass: #AccountReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!AccountReportTest methodsFor: 'testing' stamp: 'JR 6/2/2019 17:43:42'!
test01PrintAnAccountWithADepositOf50

	| anAccount lines aReport value |
	
	value _ 50.
	anAccount _ ReceptiveAccount new.
	Deposit register: value on: anAccount.
	aReport _ AccountSummary for: anAccount.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Depósito por ', value printString, '.' equals: lines next! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 5/28/2019 20:00:24'!
test02PrintAnAccountWithAWithdrawOf50

	| anAccount lines aReport value |
	
	value _ 50.
	anAccount _ ReceptiveAccount new.
	Deposit register: value on: anAccount.
	Withdraw register: value on: anAccount.
	aReport _ AccountSummary for: anAccount.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Depósito por ', value printString, '.' equals: lines next.
	self assert: 'Extracción por ', value printString, '.' equals: lines next! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 5/28/2019 20:00:35'!
test03PrintAnAccountWithATransferenceDepositOf50

	| anAccount anotherAccount lines aReport value |
	
	value _ 50.
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: value on: anAccount.
	Withdraw register: value on: anAccount.
	Transference register: value from: anotherAccount to: anAccount.
	aReport _ AccountSummary for: anAccount.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Depósito por ', value printString, '.' equals: lines next.
	self assert: 'Extracción por ', value printString, '.' equals: lines next.
	self assert: 'Entrada por transferencia de ', value printString, '.' equals: lines next! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 5/28/2019 20:00:42'!
test04PrintAnAccountWithATransferenceWithdrawOf50

	| anAccount anotherAccount lines aReport value |
	
	value _ 50.
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: value on: anAccount.
	Withdraw register: value on: anAccount.
	Transference register: value from: anAccount to: anotherAccount.
	aReport _ AccountSummary for: anAccount.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Depósito por ', value printString, '.' equals: lines next.
	self assert: 'Extracción por ', value printString, '.' equals: lines next.
	self assert: 'Salida por transferencia de ', value printString, '.' equals: lines next! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 5/28/2019 20:00:50'!
test05PrintBalanceAtTheEndOfTheReport

	| anAccount anotherAccount lines aReport value |
	
	value _ 50.
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: value on: anAccount.
	Withdraw register: value on: anAccount.
	Transference register: value from: anotherAccount to: anAccount.
	aReport _ AccountSummary for: anAccount.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Depósito por ', value printString, '.' equals: lines next.
	self assert: 'Extracción por ', value printString, '.' equals: lines next.
	self assert: 'Entrada por transferencia de ', value printString, '.' equals: lines next.
	self assert: 'Balance = ', value printString equals: lines next.
	self assert: lines atEnd! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 5/28/2019 20:15:13'!
test06PrintsTransferNetWithZeroWhenNoTrasferencesWereMade

	| anAccount lines aReport |
	
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 25 on: anAccount.
	aReport _ TransferNet for: anAccount.

	lines _ ReadStream on: aReport value.
	
	self assert: 0 printString equals: lines next! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 5/28/2019 20:18:16'!
test07PrintsTransferNetWhenHavingATransferenceToTheAccount

	| aValue anAccount anotherAccount lines aReport |
	
	aValue _ 50.
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Deposit register: aValue on: anAccount.
	Transference register: aValue from: anotherAccount to: anAccount.
	aReport _ TransferNet for: anAccount.

	lines _ ReadStream on: aReport value.
	
	self assert: aValue printString equals: lines next! !

!AccountReportTest methodsFor: 'testing' stamp: 'JR 5/31/2019 20:34:39'!
test08PrintsTransferNetWhenHavingATransferenceFromTheAccount

	| aValue anAccount anotherAccount lines aReport |
	
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.

	aValue _ 50.
	Deposit register: aValue on: anAccount.
	Transference register: aValue from: anAccount to: anotherAccount.

	aReport _ TransferNet for: anAccount.
	lines _ ReadStream on: aReport value.
	
	self assert: -50 printString equals: lines next.
	self assert: 0 equals: anAccount balance! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 6/2/2019 12:01:06'!
test09PrintAPortfolioWithADepositOf50

	| anAccount lines aReport value aPortfolio |
	
	value _ 50.
	anAccount _ ReceptiveAccount new.
	Deposit register: value on: anAccount.
	aPortfolio _ Portfolio with: anAccount.
	aReport _ AccountSummary for: aPortfolio.
	
	lines _ ReadStream on: aReport value.
	
	self assert: 'Depósito por ', value printString, '.' equals: lines next.
	self assert: 'Balance = ', aPortfolio balance printString equals: lines next.
	self assert: lines atEnd! !

!AccountReportTest methodsFor: 'testing' stamp: 'JR 6/1/2019 19:12:24'!
test10PrintsTransferNetWhenHavingATransferenceFromTheAccount

	| aValue anAccount anotherAccount lines aReport aPortfolio |
	
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	aValue _ 50.
	Deposit register: aValue on: anAccount.
	Transference register: aValue from: anAccount to: anotherAccount.
	aPortfolio _ Portfolio with: anAccount.
	aReport _ TransferNet for: aPortfolio.
	lines _ ReadStream on: aReport value.
	
	self assert: -50 printString equals: lines next.
	self assert: 0 equals: aPortfolio balance! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 6/2/2019 12:05:47'!
test11PrintsTreeStructureWithOneLevel

	| familyPortfolio aReport lines |

	familyPortfolio _ Portfolio named: 'Portfolio de la familia'.

	aReport _ TreeStructured for: familyPortfolio.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Portfolio de la familia' equals: lines next.
	self assert: lines atEnd! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 6/2/2019 12:05:47'!
test12PrintsTreeStructureWithTwoLevels

	| childrenPortfolio familyPortfolio aReport lines myAccount |
	
	childrenPortfolio _ Portfolio named: 'Portfolio de hijos'.
	myAccount _ ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	aReport _ TreeStructured for: familyPortfolio.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Portfolio de la familia' equals: lines next.
	self assert: '    Cuenta mia' equals: lines next.
	self assert: '    Portfolio de hijos' equals: lines next.
	self assert: lines atEnd! !

!AccountReportTest methodsFor: 'testing' stamp: 'AB 6/2/2019 12:05:47'!
test13PrintsTreeStructureWithThreeLevels

	| childrenPortfolio familyPortfolio aReport lines myAccount angiesAccount johnsAccount |
	
	johnsAccount _ ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount _ ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio _ Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount _ ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.	

	aReport _ TreeStructured for: familyPortfolio.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Portfolio de la familia' equals: lines next.
	self assert: '    Cuenta mia' equals: lines next.
	self assert: '    Portfolio de hijos' equals: lines next.
	self assert: '        Cuenta de Juan' equals: lines next.
	self assert: '        Cuenta de Angeles' equals: lines next.
	self assert: lines atEnd! !

!AccountReportTest methodsFor: 'testing' stamp: 'JR 6/2/2019 18:10:01'!
test14PrintsSpecialAccountSummaryOnePortfolioOneAccountOneDeposit

	| familyPortfolio aReport lines myAccount value|
	
	value _ 50.
	myAccount _ ReceptiveAccount named: 'Cuenta mia'.	
	Deposit register: value on: myAccount.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: myAccount.
	
	aReport _ SpecialAccountSummary for: familyPortfolio.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Portfolio de la familia' equals: lines next.
	self assert: '    Cuenta mia' equals: lines next.
	self assert: '        Depósito por ', value printString, '.' equals: lines next.
	self assert: '        Balance = ', value printString equals: lines next.
	self assert: '    Balance = ', value printString equals: lines next.
	self assert: lines atEnd
	! !

!AccountReportTest methodsFor: 'testing' stamp: 'JR 6/2/2019 18:09:57'!
test15PrintsSpecialAccountSummary

	| childrenPortfolio familyPortfolio aReport lines myAccount angiesAccount johnsAccount nnn qqq xxx yyy zzz georgiesAccount |
	
	johnsAccount _ ReceptiveAccount named: 'Cuenta de Juan'.
	georgiesAccount _ ReceptiveAccount named: 'Cuenta de Angeles'.
	angiesAccount _ ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio _ Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount _ ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio _ Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	xxx _ 50.
	Deposit register: xxx on: myAccount.
	yyy _ 25.
	Withdraw register: yyy on: myAccount.
	zzz _ 100.
	Deposit register: zzz on: johnsAccount.
	nnn _ 75.
	Withdraw register: nnn on: johnsAccount.
	qqq _ 150.
	Transference register: qqq from: angiesAccount to: georgiesAccount.
	
	aReport _ SpecialAccountSummary for: familyPortfolio.

	lines _ ReadStream on: aReport value.
	
	self assert: 'Portfolio de la familia' equals: lines next.
	self assert: '    Cuenta mia' equals: lines next.
	self assert: '        Depósito por ', xxx printString, '.' equals: lines next.
	self assert: '        Extracción por ', yyy printString, '.' equals: lines next.
	self assert: '        Balance = ', (xxx - yyy) printString equals: lines next.
	self assert: '    Portfolio de hijos' equals: lines next.
	self assert: '        Cuenta de Juan' equals: lines next.
	self assert: '            Depósito por ', zzz printString, '.' equals: lines next.
	self assert: '            Extracción por ', nnn printString, '.' equals: lines next.
	self assert: '            Balance = ', (zzz - nnn) printString equals: lines next.
	self assert: '        Cuenta de Angeles' equals: lines next.
	self assert: '            Salida por transferencia de ', qqq printString, '.' equals: lines next.
	self assert: '            Balance = ', (qqq negated) printString equals: lines next.
	self assert: '        Balance = ', (-125) printString equals: lines next.
	self assert: '    Balance = ', (-100) printString equals: lines next.
	self assert: lines atEnd! !


!classDefinition: #PortfolioTest category: #PortfolioTreePrinter!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AB 5/31/2019 10:56:32'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |

	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.

	self
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 6/1/2019 19:18:28'!
test16NewPortfolioHasEmptyStringAsName

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: '' equals: aPortfolio named.! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 6/1/2019 19:20:17'!
test17NewPortfolioHasNameIfGivenAsParameterInInstantiation

	| aPortfolio |
	
	aPortfolio _ Portfolio named: 'Cuenta de Juan'.
	
	self assert: 'Cuenta de Juan' equals: aPortfolio named.! !


!classDefinition: #ReceptiveAccountTest category: #PortfolioTreePrinter!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 16:00:08'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account _ ReceptiveAccount new.

	self assert: 0 equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 16:00:17'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account _ ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 16:00:25'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 16:00:35'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account _ ReceptiveAccount new.
	withdrawValue _ 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 16:00:45'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account _ ReceptiveAccount new.
	deposit _ Deposit register: 100 on: account.
	withdraw _ Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw)! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 16:00:55'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account _ ReceptiveAccount new.
	deposit _  Deposit for: 100.
	withdraw _ Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw)! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 16:01:05'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 _ ReceptiveAccount new.
	
	deposit1 _ Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1)! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 17:03:44'!
test08TransferenceIncreasesBalanceOnDestinationAccount 

	| originAccount destinationAccount |
	
	originAccount _ ReceptiveAccount new.

	destinationAccount _ ReceptiveAccount new.

	self assert: 0 equals: destinationAccount balance.

	Deposit register: 50 on: destinationAccount.

	self assert: 50 equals: destinationAccount balance.

	Transference register: 100 from: originAccount to: destinationAccount.
		
	self assert: 150 equals: destinationAccount balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 17:03:57'!
test09TransferenceDecreasesBalanceOnOriginAccount 

	| originAccount destinationAccount |
	
	originAccount _ ReceptiveAccount new.

	destinationAccount _ ReceptiveAccount new.

	self assert: 0 equals: originAccount balance.

	Deposit register: 75 on: originAccount.

	self assert: 75 equals: originAccount balance.

	Transference register: 100 from: originAccount to: destinationAccount.
		
	self assert: -25 equals: originAccount balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AB 5/28/2019 17:16:52'!
test10CanGoFromATransferenceDepositToATransferenceWithdraw 

	| originAccount destinationAccount transference deposit withdraw |
	
	originAccount _ ReceptiveAccount new.
	destinationAccount _ ReceptiveAccount new.

	transference _ Transference register: 100 from: originAccount to: destinationAccount.
		
	deposit _ transference deposit.
	withdraw _ transference withdraw.

	self assert: deposit equals: withdraw transference deposit.
	self assert: withdraw equals: deposit transference withdraw.! !


!classDefinition: #AccountReport category: #PortfolioTreePrinter!
Object subclass: #AccountReport
	instanceVariableNames: 'asset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!AccountReport methodsFor: 'value' stamp: 'AB 5/28/2019 18:14:33'!
initializeFor: aFinancialAsset

	asset _ aFinancialAsset! !

!AccountReport methodsFor: 'value' stamp: 'AB 5/28/2019 19:48:20'!
value

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: #PortfolioTreePrinter!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 18:13:23'!
for: aFinancialAsset

	^ self new initializeFor: aFinancialAsset! !


!classDefinition: #AccountSummary category: #PortfolioTreePrinter!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!AccountSummary methodsFor: 'value' stamp: 'JR 6/1/2019 18:59:02'!
value

	| lines |

	lines _ OrderedCollection new.

	asset transactions do: [ :aTransaction | lines add: (self descriptionFor: aTransaction) ].

	lines add: 'Balance = ', asset balance printString.
	
	^ lines! !


!AccountSummary methodsFor: 'descriptions' stamp: 'JR 6/1/2019 18:59:02'!
descriptionFor: aTransaction

	^ (TransactionReportDispatcher 
		for: aTransaction
		with: [ self descriptionForADeposit: aTransaction ]
		with: [ self descriptionForAWithdraw: aTransaction ]
		with: [ self descriptionForATransferenceDeposit: aTransaction ]
		with: [ self descriptionForATransferenceWithdraw: aTransaction ]) execute 
	! !

!AccountSummary methodsFor: 'descriptions' stamp: 'JR 6/1/2019 18:54:08'!
descriptionForADeposit: aDeposit

	^ 'Depósito por ', aDeposit value printString, '.'! !

!AccountSummary methodsFor: 'descriptions' stamp: 'JR 6/1/2019 18:54:15'!
descriptionForATransferenceDeposit: aTransferenceDeposit

	^ 'Entrada por transferencia de ', aTransferenceDeposit value printString, '.'! !

!AccountSummary methodsFor: 'descriptions' stamp: 'JR 6/1/2019 18:54:24'!
descriptionForATransferenceWithdraw: aTransferenceWithdraw

	^ 'Salida por transferencia de ', aTransferenceWithdraw value printString, '.'! !

!AccountSummary methodsFor: 'descriptions' stamp: 'JR 6/1/2019 18:54:31'!
descriptionForAWithdraw: aWithdraw
	
	^ 'Extracción por ', aWithdraw value printString, '.'! !


!classDefinition: #SpecialAccountSummary category: #PortfolioTreePrinter!
AccountReport subclass: #SpecialAccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!SpecialAccountSummary methodsFor: 'as yet unclassified' stamp: 'AB 6/2/2019 12:05:10'!
addTreeLevel: aFinancialAsset indentationLevel: anIndentation to: aStream

	(FinancialAssetReportDispatcher
		for: aFinancialAsset 
		with: [ self addTreeLevelReceptiveAccountFor: aFinancialAsset indentationLevel: anIndentation to: aStream ]
		with: [ self addTreeLevelPortfolioFor: aFinancialAsset indentationLevel: anIndentation to: aStream ]) execute
! !

!SpecialAccountSummary methodsFor: 'as yet unclassified' stamp: 'JR 6/2/2019 18:09:45'!
addTreeLevelPortfolioFor: aPortfolio indentationLevel: anIndentation to: aStream

	| tabSpace |
	
	tabSpace _ ''.
	
	anIndentation timesRepeat: [ tabSpace _ tabSpace , '    ' ].

	aStream add: tabSpace, aPortfolio named.
	
	aPortfolio accounts do: [ :anAsset | self addTreeLevel: anAsset indentationLevel: (anIndentation + 1) to: aStream ].
	
	aStream add: tabSpace, '    Balance = ', aPortfolio balance printString.! !

!SpecialAccountSummary methodsFor: 'as yet unclassified' stamp: 'JR 6/2/2019 17:47:38'!
addTreeLevelReceptiveAccountFor: aReceptiveAccount indentationLevel: anIndentation to: aStream

	| tabSpace aReport lines x |
	
	tabSpace _ ''.
	
	anIndentation timesRepeat: [ tabSpace _ tabSpace , '    ' ].

	aStream add: tabSpace, aReceptiveAccount named.
	
	aReport _ AccountSummary for: aReceptiveAccount.
	
	lines _ ReadStream on: aReport value.
	
	[(x _ lines next) notNil]
		whileTrue: [aStream add: tabSpace, '    ', x]! !

!SpecialAccountSummary methodsFor: 'as yet unclassified' stamp: 'AB 6/2/2019 12:05:11'!
value

	| lines |

	lines _ OrderedCollection new.
	
	self addTreeLevel: asset indentationLevel: 0 to: lines.

	^ lines! !


!classDefinition: #TransferNet category: #PortfolioTreePrinter!
AccountReport subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!TransferNet methodsFor: 'value' stamp: 'JR 6/1/2019 19:01:45'!
value

	| lines transferNet |

	lines _ OrderedCollection new.

	transferNet _ asset transactions inject: 0 into: [ :currentNet :aTransaction | self affectTransferNet: currentNet using: aTransaction ].

	lines add: transferNet printString.
	
	^ lines! !


!TransferNet methodsFor: 'affect transfer net' stamp: 'JR 6/1/2019 19:05:22'!
affectTransferNet: aTransferNet using: aTransaction 

	^ (TransactionReportDispatcher 
		for: aTransaction
		with: [ self affectTransferWith: aTransferNet forDeposit: aTransaction ]
		with: [ self affectTransferWith: aTransferNet forWithdraw: aTransaction ]
		with: [ self affectTransferWith: aTransferNet forTransferenceDeposit: aTransaction ]
		with: [ self affectTransferWith: aTransferNet forTransferenceWithdraw: aTransaction ]) execute 
	! !

!TransferNet methodsFor: 'affect transfer net' stamp: 'JR 6/1/2019 19:05:22'!
affectTransferWith: aTransferNet forDeposit: aDeposit
	
	^ aTransferNet! !

!TransferNet methodsFor: 'affect transfer net' stamp: 'JR 6/1/2019 18:05:44'!
affectTransferWith: aTransferNet forTransferenceDeposit: aTransferenceDeposit
	
	^ aTransferNet + aTransferenceDeposit value! !

!TransferNet methodsFor: 'affect transfer net' stamp: 'JR 6/1/2019 18:06:11'!
affectTransferWith: aTransferNet forTransferenceWithdraw: aTransferenceWithdraw
	
	^ aTransferNet - aTransferenceWithdraw value! !

!TransferNet methodsFor: 'affect transfer net' stamp: 'JR 6/1/2019 18:05:02'!
affectTransferWith: aTransferNet forWithdraw: aWithdraw

	^ aTransferNet! !


!classDefinition: #TreeStructured category: #PortfolioTreePrinter!
AccountReport subclass: #TreeStructured
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!TreeStructured methodsFor: 'as yet unclassified' stamp: 'AB 6/2/2019 11:56:39'!
addTreeLevel: aFinancialAsset indentationLevel: anIndentation to: aStream

	(FinancialAssetReportDispatcher
		for: aFinancialAsset 
		with: [ self addTreeLevelReceptiveAccountFor: aFinancialAsset indentationLevel: anIndentation to: aStream ]
		with: [ self addTreeLevelPortfolioFor: aFinancialAsset indentationLevel: anIndentation to: aStream ]) execute
! !

!TreeStructured methodsFor: 'as yet unclassified' stamp: 'AB 6/2/2019 11:37:44'!
addTreeLevelPortfolioFor: aPortfolio indentationLevel: anIndentation to: aStream

	| tabSpace |
	
	tabSpace _ ''.
	
	anIndentation timesRepeat: [ tabSpace _ tabSpace , '    ' ].

	aStream add: tabSpace, aPortfolio named.
	
	aPortfolio accounts do: [ :anAsset | self addTreeLevel: anAsset indentationLevel: (anIndentation + 1) to: aStream ]! !

!TreeStructured methodsFor: 'as yet unclassified' stamp: 'JR 6/2/2019 17:37:28'!
addTreeLevelReceptiveAccountFor: aReceptiveAccount indentationLevel: anIndentation to: aStream

	| tabSpace |
	
	tabSpace _ ''.
	
	anIndentation timesRepeat: [ tabSpace _ tabSpace , '    ' ].

	aStream add: tabSpace, aReceptiveAccount named! !

!TreeStructured methodsFor: 'as yet unclassified' stamp: 'AB 6/2/2019 11:25:41'!
value

	| lines |

	lines _ OrderedCollection new.
	
	self addTreeLevel: asset indentationLevel: 0 to: lines.

	^ lines! !


!classDefinition: #AccountTransaction category: #PortfolioTreePrinter!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:23'!
isDeposit

	^ false! !

!AccountTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:42'!
isTransferenceDeposit

	^ false! !

!AccountTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:49'!
isTransferenceWithdraw

	^ false! !

!AccountTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:30'!
isWithdraw

	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #PortfolioTreePrinter!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #PortfolioTreePrinter!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!Deposit methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:28:23'!
initializeFor: aValue

	value _ aValue! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AB 5/28/2019 16:29:17'!
affectBalance: aBalance

	^ aBalance + value! !


!Deposit methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:38:03'!
isDeposit

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #PortfolioTreePrinter!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceDeposit category: #PortfolioTreePrinter!
AccountTransaction subclass: #TransferenceDeposit
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!TransferenceDeposit methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:41:40'!
initializeFrom: aTransference

	transference _ aTransference! !


!TransferenceDeposit methodsFor: 'balance' stamp: 'AB 5/28/2019 16:43:15'!
affectBalance: aBalance

	^ aBalance + self value! !


!TransferenceDeposit methodsFor: 'value' stamp: 'AB 5/28/2019 16:43:04'!
value

	^ transference value! !


!TransferenceDeposit methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:14:39'!
transference

	^ transference! !


!TransferenceDeposit methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:38:29'!
isTransferenceDeposit

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceDeposit class' category: #PortfolioTreePrinter!
TransferenceDeposit class
	instanceVariableNames: ''!

!TransferenceDeposit class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 16:39:49'!
from: aTransference

	^ self new initializeFrom: aTransference ! !


!classDefinition: #TransferenceWithdraw category: #PortfolioTreePrinter!
AccountTransaction subclass: #TransferenceWithdraw
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!TransferenceWithdraw methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:42:01'!
initializeFrom: aTransference

	transference _ aTransference! !


!TransferenceWithdraw methodsFor: 'balance' stamp: 'AB 5/28/2019 16:43:46'!
affectBalance: aBalance

	^ aBalance - transference value! !


!TransferenceWithdraw methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:15:06'!
transference

	^ transference! !


!TransferenceWithdraw methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:39:22'!
isTransferenceWithdraw

	^ true! !


!TransferenceWithdraw methodsFor: 'value' stamp: 'AB 5/28/2019 16:43:24'!
value

	^ transference value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceWithdraw class' category: #PortfolioTreePrinter!
TransferenceWithdraw class
	instanceVariableNames: ''!

!TransferenceWithdraw class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 16:39:58'!
from: aTransference

	^ self new initializeFrom: aTransference ! !


!classDefinition: #Withdraw category: #PortfolioTreePrinter!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!Withdraw methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:28:30'!
initializeFor: aValue

	value _ aValue! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'AB 5/28/2019 20:06:19'!
affectBalance: aBalance

	^ aBalance - value! !


!Withdraw methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:39:37'!
isWithdraw

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #PortfolioTreePrinter!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: #PortfolioTreePrinter!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!FinancialAsset methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:27:10'!
isPortfolio

	^ false! !

!FinancialAsset methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:27:22'!
isReceptiveAccount

	^ false! !


!classDefinition: #Portfolio category: #PortfolioTreePrinter!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!Portfolio methodsFor: 'accounts management' stamp: 'JR 6/1/2019 19:54:49'!
accounts 

	^ accounts copy! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'AB 5/28/2019 20:12:10'!
rootParents
	
	| rootParents |
	
	rootParents _ Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'JR 6/1/2019 19:25:03'!
initialize

	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.
	name _ ''! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'AB 5/28/2019 20:12:21'!
transactions
	
	| transactions |
	
	transactions _ OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^ transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'AB 5/31/2019 10:57:23'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'naming' stamp: 'JR 6/1/2019 19:24:23'!
named

	^ name! !

!Portfolio methodsFor: 'naming' stamp: 'JR 6/1/2019 19:23:06'!
named: aName

	name _ aName! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:27:51'!
isPortfolio

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #PortfolioTreePrinter!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 19:22:33'!
named: aName

	^self new 
		named: aName;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 19:52:04'!
named: aName with: anAccount

	^ self new
		named: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 19:27:46'!
named: aName with: anAccount with: anotherAccount

	^ self new
		named: aName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #PortfolioTreePrinter!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:28:01'!
isReceptiveAccount

	^ true! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:41:52'!
named

	^ name ! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:41:29'!
named: aName

	name _ aName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #PortfolioTreePrinter!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:41:12'!
named: aName

	^self new 
		named: aName;
		yourself! !


!classDefinition: #FinancialAssetReportDispatcher category: #PortfolioTreePrinter!
Object subclass: #FinancialAssetReportDispatcher
	instanceVariableNames: 'asset block'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!FinancialAssetReportDispatcher methodsFor: 'initialization' stamp: 'JR 6/1/2019 20:13:35'!
initializeWith: aFinancialAsset with: aReceptiveAccountBlock with: aPortfolioBlock

	self subclassResponsibility ! !


!FinancialAssetReportDispatcher methodsFor: 'as yet unclassified' stamp: 'AB 6/2/2019 11:53:14'!
execute

	block value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialAssetReportDispatcher class' category: #PortfolioTreePrinter!
FinancialAssetReportDispatcher class
	instanceVariableNames: ''!

!FinancialAssetReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:12:52'!
for: aFinancialAsset with: aReceptiveAccountBlock with: aPortfolioBlock

	^ (self subclasses
		detect: [ :aFinancialAssetDispatcher |
			aFinancialAssetDispatcher handles: aFinancialAsset ]
		ifNone: [ self error: 'No financial asset available' ]) new initializeWith: aFinancialAsset with: aReceptiveAccountBlock with: aPortfolioBlock! !


!classDefinition: #PortfolioReportDispatcher category: #PortfolioTreePrinter!
FinancialAssetReportDispatcher subclass: #PortfolioReportDispatcher
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!PortfolioReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:14:18'!
initializeWith: aFinancialAsset with: aReceptiveAccountBlock with: aPortfolioBlock

	block _ aPortfolioBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReportDispatcher class' category: #PortfolioTreePrinter!
PortfolioReportDispatcher class
	instanceVariableNames: ''!

!PortfolioReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:26:08'!
handles: aFinancialAsset

	^ aFinancialAsset isPortfolio! !


!classDefinition: #ReceptiveAccountReportDispatcher category: #PortfolioTreePrinter!
FinancialAssetReportDispatcher subclass: #ReceptiveAccountReportDispatcher
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!ReceptiveAccountReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:14:27'!
initializeWith: aFinancialAsset with: aReceptiveAccountBlock with: aPortfolioBlock

	block _ aReceptiveAccountBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccountReportDispatcher class' category: #PortfolioTreePrinter!
ReceptiveAccountReportDispatcher class
	instanceVariableNames: ''!

!ReceptiveAccountReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 20:26:18'!
handles: aFinancialAsset

	^ aFinancialAsset isReceptiveAccount! !


!classDefinition: #TransactionReportDispatcher category: #PortfolioTreePrinter!
Object subclass: #TransactionReportDispatcher
	instanceVariableNames: 'transaction block'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!TransactionReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:38:09'!
execute

	^ block value.! !

!TransactionReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:50:32'!
initializeWith: aTransaction with: aDepositBlock with: aWithdrawBlock with: aTransferenceDepositBlock with: aTransferenceWithdrawBlock

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionReportDispatcher class' category: #PortfolioTreePrinter!
TransactionReportDispatcher class
	instanceVariableNames: ''!

!TransactionReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:50:23'!
for: aTransaction with: aDepositBlock with: aWithdrawBlock with: aTransferenceDepositBlock with: aTransferenceWithdrawBlock

	^ (self subclasses
		detect: [ :aTransactionDispatcher |
			aTransactionDispatcher handles: aTransaction ]
		ifNone: [ self error: 'No transaction transfer net available' ]) new initializeWith: aTransaction with: aDepositBlock with: aWithdrawBlock with: aTransferenceDepositBlock with: aTransferenceWithdrawBlock! !


!classDefinition: #DepositReportDispatcher category: #PortfolioTreePrinter!
TransactionReportDispatcher subclass: #DepositReportDispatcher
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!DepositReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:50:23'!
initializeWith: aTransaction with: aDepositBlock with: aWithdrawBlock with: transferenceDepositBlock with: transferenceWithdrawBlock

	block _ aDepositBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositReportDispatcher class' category: #PortfolioTreePrinter!
DepositReportDispatcher class
	instanceVariableNames: ''!

!DepositReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:47:16'!
handles: aTransaction

	^ aTransaction isDeposit ! !


!classDefinition: #TransferenceDepositReportDispatcher category: #PortfolioTreePrinter!
TransactionReportDispatcher subclass: #TransferenceDepositReportDispatcher
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!TransferenceDepositReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:50:23'!
initializeWith: aTransaction with: aDepositBlock with: aWithdrawBlock with: transferenceDepositBlock with: transferenceWithdrawBlock

	block _ transferenceDepositBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceDepositReportDispatcher class' category: #PortfolioTreePrinter!
TransferenceDepositReportDispatcher class
	instanceVariableNames: ''!

!TransferenceDepositReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:47:16'!
handles: aTransaction

	^ aTransaction isTransferenceDeposit ! !


!classDefinition: #TransferenceWithdrawReportDispatcher category: #PortfolioTreePrinter!
TransactionReportDispatcher subclass: #TransferenceWithdrawReportDispatcher
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!TransferenceWithdrawReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:50:23'!
initializeWith: aTransaction with: aDepositBlock with: aWithdrawBlock with: transferenceDepositBlock with: transferenceWithdrawBlock

	block _ transferenceWithdrawBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceWithdrawReportDispatcher class' category: #PortfolioTreePrinter!
TransferenceWithdrawReportDispatcher class
	instanceVariableNames: ''!

!TransferenceWithdrawReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:47:16'!
handles: aTransaction

	^ aTransaction isTransferenceWithdraw ! !


!classDefinition: #WithdrawReportDispatcher category: #PortfolioTreePrinter!
TransactionReportDispatcher subclass: #WithdrawReportDispatcher
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!WithdrawReportDispatcher methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:50:23'!
initializeWith: aTransaction with: aDepositBlock with: aWithdrawBlock with: transferenceDepositBlock with: transferenceWithdrawBlock

	block _ aWithdrawBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawReportDispatcher class' category: #PortfolioTreePrinter!
WithdrawReportDispatcher class
	instanceVariableNames: ''!

!WithdrawReportDispatcher class methodsFor: 'as yet unclassified' stamp: 'JR 6/1/2019 18:47:16'!
handles: aTransaction

	^ aTransaction isWithdraw! !


!classDefinition: #Transference category: #PortfolioTreePrinter!
Object subclass: #Transference
	instanceVariableNames: 'from to value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter'!

!Transference methodsFor: 'value' stamp: 'AB 5/28/2019 16:45:08'!
value

	^ value! !


!Transference methodsFor: 'initialization' stamp: 'JR 5/31/2019 20:42:50'!
initializeFor: aValue from: originAccount to: destinationAccount

	value _ aValue.

	from _ TransferenceWithdraw from: self.
	originAccount register: from.

	to _ TransferenceDeposit from: self.
	destinationAccount register: to.
! !


!Transference methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:15:41'!
deposit

	^ to! !

!Transference methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:15:37'!
withdraw

	^ from! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #PortfolioTreePrinter!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 16:44:32'!
register: aValue from: originAccount to: destinationAccount
 
	^ self new initializeFor: aValue from: originAccount to:destinationAccount! !
