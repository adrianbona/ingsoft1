!classDefinition: #FintechTest category: #'ISW1-Fintech'!
TestCase subclass: #FintechTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 19:39:23'!
test01CreateWalletReturnsAUniqueId

	| fintech aWalletId anotherWalletId |
	
	fintech _ Fintech new.
	
	aWalletId _ fintech createWallet.
	
	anotherWalletId _ fintech createWallet.
	
	self deny: aWalletId = anotherWalletId! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 19:41:26'!
test02BalanceOfNewWalletIs1ISW1COIN

	| fintech aWalletId |
	
	fintech _ Fintech new.
	
	aWalletId _ fintech createWallet.
		
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintech balanceOf: aWalletId)! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 19:37:01'!
test03CheckingBalanceOfNonExistingWallteIdRaisesError

	| fintech aWalletId |
	
	fintech _ Fintech new.
	
	aWalletId _ 1.
	
	self should: [
			fintech balanceOf: aWalletId
		] raise: Error withExceptionDo: [ :anError |
			self assert: anError messageText equals: Fintech canNotFindWalletId
		] ! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:24:16'!
test04SourceAndTargetWalletIdsMustBeDifferentForSlowTransfers

	| fintech aWalletId anAmount |
	
	fintech _ Fintech new.
	
	aWalletId _ fintech createWallet.
	
	anAmount _ 1.
	
	self should: [
			fintech slowTransfer: anAmount from: aWalletId to: aWalletId.
		] raise: Error withExceptionDo: [ :anError |
			self assert: anError messageText equals: Fintech sourceAndTargetWalletIdsMustBeDifferent
		] ! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:24:23'!
test05TargetWalletIdsMustBelongToAnExistingWalletWhenSlowTransferencing

	| fintech aWalletId anAmount |
	
	fintech _ Fintech new.
	
	aWalletId _ fintech createWallet.
	
	anAmount _ 1.

	self should: [ | anotherWalletId |
			fintech slowTransfer: anAmount from: aWalletId to: anotherWalletId.
		] raise: Error withExceptionDo: [ :anError |
			self assert: anError messageText equals: Fintech canNotFindWalletId
		] ! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:24:32'!
test06SourceWalletIdsMustBelongToAnExistingWalletWhenSlowTransferencing

	| fintech aWalletId anAmount |
	
	fintech _ Fintech new.
	
	aWalletId _ fintech createWallet.
	
	anAmount _ 1.
	
	self should: [ | anotherWalletId |
			fintech slowTransfer: anAmount from: anotherWalletId to: aWalletId.
		] raise: Error withExceptionDo: [ :anError |
			self assert: anError messageText equals: Fintech canNotFindWalletId
		]! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:20:20'!
test06WhenSlowTransferencingAmountMustBeBiggerThan0Point000001

	| fintech aWalletId anAmount anotherWalletId |
	
	fintech _ Fintech new.
	
	aWalletId _ fintech createWallet.

	anotherWalletId _ fintech createWallet.
	
	anAmount _ 0.0000009.
	
	self should: [
			fintech slowTransfer: anAmount from: anotherWalletId to: aWalletId.
		] raise: Error withExceptionDo: [ :anError |
			self assert: anError messageText equals: Fintech minimumAmountToBeTransferedIs0000001
		]! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:02:07'!
test07TransactionsOfNewWalletIsAnEmptyCollection

	| fintech aWalletId |

	fintech _ Fintech new.

	aWalletId _ fintech createWallet.

	self assert: (fintech allTransactionsOf: aWalletId) isEmpty! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:53:56'!
test08TransactionsOfUnexistingWalletThrowsError

	| fintech aWalletId anotherWalletId |

	fintech _ Fintech new.

	aWalletId _ fintech createWallet.

	self should: [
		fintech allTransactionsOf: anotherWalletId.
	] raise: Error withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech canNotFindWalletId
	]! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/26/2019 00:04:19'!
test09SlowTrasnferChargesATwoPercentCommissionToSender

	| fintech aWalletId anotherWalletId |

	fintech _ Fintech new.

	aWalletId _ fintech createWallet.

	anotherWalletId _ fintech createWallet.

	fintech slowTransfer: 0.5 from: aWalletId to: anotherWalletId.
	
	self assert: ((1 - 0.5 - (0.5 * 0.02)) * (BaseUnit named: 'ISW1COIN')) equals: (fintech balanceOf: aWalletId)! !

!FintechTest methodsFor: 'testing' stamp: 'AB 6/26/2019 15:24:00'!
test10FastTrasnferChargesAFourPercentCommissionToSender

	| fintech aWalletId anotherWalletId |

	fintech _ Fintech new.

	aWalletId _ fintech createWallet.

	anotherWalletId _ fintech createWallet.

	fintech fastTransfer: 0.5 from: aWalletId to: anotherWalletId.
	
	self assert: ((1 - 0.5 - (0.5 * 0.04)) * (BaseUnit named: 'ISW1COIN')) equals: (fintech balanceOf: aWalletId)! !


!classDefinition: #WalletTest category: #'ISW1-Fintech'!
TestCase subclass: #WalletTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!WalletTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:48:28'!
test01NewWalletHasABalanceOf1

	| aWallet |
	
	aWallet _ Wallet new.
	
	self assert: (1 * (BaseUnit named: 'ISW1COIN')) equals: aWallet balance ! !

!WalletTest methodsFor: 'testing' stamp: 'AB 6/25/2019 20:49:33'!
test02TransactionsOfNewWalletIsEmptyCollection

	| aWallet |
	
	aWallet _ Wallet new.
	
	self assert: OrderedCollection new equals: aWallet transactions ! !


!classDefinition: #Fintech category: #'ISW1-Fintech'!
Object subclass: #Fintech
	instanceVariableNames: 'uniqueWalletId wallets clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Fintech methodsFor: 'initialization' stamp: 'AB 6/25/2019 23:36:01'!
initialize

	self initializeWith: (DateAndTime now)! !

!Fintech methodsFor: 'initialization' stamp: 'AB 6/25/2019 23:35:29'!
initializeWith: aClock

	uniqueWalletId _ 0.	
	wallets _ Dictionary new.
	clock _ aClock! !


!Fintech methodsFor: 'balance' stamp: 'AB 6/25/2019 19:35:58'!
balanceOf: aWalletId

	^ (self walletFor: aWalletId) balance! !


!Fintech methodsFor: 'wallet' stamp: 'AB 6/25/2019 19:50:06'!
assertSourceAndTargetAreDifferentFor: aSourceWalletId and: aTargetWalletId

	(aSourceWalletId = aTargetWalletId) ifTrue: [ ^ self error: Fintech sourceAndTargetWalletIdsMustBeDifferent ]! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/25/2019 20:26:14'!
assertValueIsBiggerThanMinimum: anAmount
	
	(anAmount < self minimum) ifTrue: [ self error: Fintech minimumAmountToBeTransferedIs0000001 ]! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/25/2019 19:34:19'!
createWallet

	| walletId |
	
	walletId _ self uniqueWalletId.

	wallets at: walletId put: Wallet new.

	^ walletId! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/26/2019 15:26:45'!
fastTransfer: anAmount from: aSourceWalletId to: aTargetWalletId

	| aSourceWallet aTargetWallet |

	self assertValueIsBiggerThanMinimum: anAmount.

	self assertSourceAndTargetAreDifferentFor: aSourceWalletId and: aTargetWalletId.

	aTargetWallet _ self walletFor: aTargetWalletId.
	
	aSourceWallet _ self walletFor: aSourceWalletId.
	
	self recordTransference: anAmount from: aSourceWallet to: aTargetWallet adding: self fastTransferCommissionPercentage taking: self fastTransferDuration! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/26/2019 15:26:12'!
fastTransferCommissionPercentage

	^ 0.04! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/26/2019 15:26:32'!
fastTransferDuration

	^ Duration minutes: 10! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/25/2019 20:23:46'!
minimum

	^ 0.000001! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/26/2019 15:27:28'!
recordTransference: anAmount from: aSourceWalletId to: aTargetWalletId adding: aPercentaje taking: aDuration

	Commission register: (anAmount * aPercentaje) on: aSourceWalletId.

	Transfer register: anAmount from: aSourceWalletId to: aTargetWalletId! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/26/2019 15:26:05'!
slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId

	| aSourceWallet aTargetWallet |

	self assertValueIsBiggerThanMinimum: anAmount.

	self assertSourceAndTargetAreDifferentFor: aSourceWalletId and: aTargetWalletId.

	aTargetWallet _ self walletFor: aTargetWalletId.
	
	aSourceWallet _ self walletFor: aSourceWalletId.
	
	self recordTransference: anAmount from: aSourceWallet to: aTargetWallet adding: self slowTransferCommissionPercentage taking: self slowTransferDuration! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/26/2019 15:26:05'!
slowTransferCommissionPercentage

	^ 0.02! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/25/2019 23:46:42'!
slowTransferDuration

	^ Duration hours: 1! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/25/2019 19:05:38'!
uniqueWalletId

	^ uniqueWalletId _ uniqueWalletId + 1! !

!Fintech methodsFor: 'wallet' stamp: 'AB 6/25/2019 19:50:13'!
walletFor: aWalletId

	| wallet |

	wallet _ wallets at: aWalletId ifAbsent: [ self error: Fintech canNotFindWalletId ].
	
	^ wallet! !


!Fintech methodsFor: 'transactions' stamp: 'AB 6/25/2019 23:22:45'!
allTransactionsOf: aWalletId

	^ (self walletFor: aWalletId) transactions
! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fintech class' category: #'ISW1-Fintech'!
Fintech class
	instanceVariableNames: ''!

!Fintech class methodsFor: 'exceptions' stamp: 'AB 6/25/2019 19:39:01'!
canNotFindWalletId

	^ 'Can not find wallet id'! !

!Fintech class methodsFor: 'exceptions' stamp: 'AB 6/25/2019 20:21:14'!
minimumAmountToBeTransferedIs0000001

	^ 'Minimum amount to be transfered is 0.000001'! !

!Fintech class methodsFor: 'exceptions' stamp: 'AB 6/25/2019 19:49:36'!
sourceAndTargetWalletIdsMustBeDifferent

	^ 'Source and target wallet ids must be different'! !


!Fintech class methodsFor: 'instance creation' stamp: 'AB 6/25/2019 23:34:33'!
measuringWith: aClock

	^ self new initializeWith: aClock! !


!classDefinition: #ManualClock category: #'ISW1-Fintech'!
Object subclass: #ManualClock
	instanceVariableNames: 'creationDateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!ManualClock methodsFor: 'initialization' stamp: 'AB 6/19/2019 18:29:06'!
initialize

	creationDateAndTime _ DateAndTime now! !

!ManualClock methodsFor: 'initialization' stamp: 'AB 6/19/2019 18:29:54'!
initializeStartingOn: aDateAndTime

	creationDateAndTime _ aDateAndTime! !


!ManualClock methodsFor: 'adding' stamp: 'AB 6/19/2019 19:08:47'!
add: aDuration
	
	creationDateAndTime _ creationDateAndTime + aDuration! !


!ManualClock methodsFor: 'accessing' stamp: 'AB 6/19/2019 18:50:42'!
now

	^ creationDateAndTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'ISW1-Fintech'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'as yet unclassified' stamp: 'AB 6/19/2019 18:54:54'!
startingOn: aDateAndTime

	^ self new initializeStartingOn: aDateAndTime! !


!classDefinition: #Transfer category: #'ISW1-Fintech'!
Object subclass: #Transfer
	instanceVariableNames: 'from to value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Transfer methodsFor: 'value' stamp: 'AB 5/28/2019 16:45:08'!
value

	^ value! !


!Transfer methodsFor: 'initialization' stamp: 'AB 6/25/2019 23:30:55'!
initializeFor: aValue from: sourceWallet to: targetWallet

	value _ aValue.

	from _ TransferWithdraw from: self.
	sourceWallet register: from.

	to _ TransferDeposit from: self.
	targetWallet register: to.
! !


!Transfer methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:15:41'!
deposit

	^ to! !

!Transfer methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:15:37'!
withdraw

	^ from! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'ISW1-Fintech'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AB 6/25/2019 23:25:31'!
register: aValue from: sourceWallet to: targetWallet
 
	^ self new initializeFor: aValue from: sourceWallet to: targetWallet! !


!classDefinition: #Wallet category: #'ISW1-Fintech'!
Object subclass: #Wallet
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Wallet methodsFor: 'balance' stamp: 'AB 6/26/2019 00:03:53'!
balance

	^ (transactions inject: 1 into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]) * (BaseUnit named: 'ISW1COIN')! !


!Wallet methodsFor: 'transactions' stamp: 'AB 6/25/2019 23:53:25'!
register: aTransaction

	transactions add: aTransaction! !

!Wallet methodsFor: 'transactions' stamp: 'AB 6/25/2019 23:53:35'!
transactions

	^ transactions! !


!Wallet methodsFor: 'initialization' stamp: 'AB 6/25/2019 23:53:56'!
initialize

	transactions _ OrderedCollection new! !


!classDefinition: #WalletTransaction category: #'ISW1-Fintech'!
Object subclass: #WalletTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!WalletTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!WalletTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!WalletTransaction methodsFor: 'comparing' stamp: 'AB 6/25/2019 23:42:37'!
isCommission

	^ false! !

!WalletTransaction methodsFor: 'comparing' stamp: 'AB 6/25/2019 23:31:19'!
isTransferDeposit

	^ false! !

!WalletTransaction methodsFor: 'comparing' stamp: 'AB 6/25/2019 23:31:10'!
isTransferWithdraw

	^ false! !


!classDefinition: #Commission category: #'ISW1-Fintech'!
WalletTransaction subclass: #Commission
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Commission methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:28:30'!
initializeFor: aValue

	value _ aValue! !


!Commission methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Commission methodsFor: 'balance' stamp: 'AB 5/28/2019 20:06:19'!
affectBalance: aBalance

	^ aBalance - value! !


!Commission methodsFor: 'comparing' stamp: 'AB 6/25/2019 23:42:43'!
isCommission

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Commission class' category: #'ISW1-Fintech'!
Commission class
	instanceVariableNames: ''!

!Commission class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Commission class methodsFor: 'instance creation' stamp: 'AB 6/25/2019 23:51:51'!
register: aValue on: aWallet

	| withdraw |
	
	withdraw := self for: aValue.
	aWallet register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferDeposit category: #'ISW1-Fintech'!
WalletTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!TransferDeposit methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:41:40'!
initializeFrom: aTransference

	transference _ aTransference! !


!TransferDeposit methodsFor: 'balance' stamp: 'AB 5/28/2019 16:43:15'!
affectBalance: aBalance

	^ aBalance + self value! !


!TransferDeposit methodsFor: 'value' stamp: 'AB 5/28/2019 16:43:04'!
value

	^ transference value! !


!TransferDeposit methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:14:39'!
transference

	^ transference! !


!TransferDeposit methodsFor: 'comparing' stamp: 'AB 6/25/2019 23:31:19'!
isTransferDeposit

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'ISW1-Fintech'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 16:39:49'!
from: aTransference

	^ self new initializeFrom: aTransference ! !


!classDefinition: #TransferWithdraw category: #'ISW1-Fintech'!
WalletTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:42:01'!
initializeFrom: aTransference

	transference _ aTransference! !


!TransferWithdraw methodsFor: 'balance' stamp: 'AB 5/28/2019 16:43:46'!
affectBalance: aBalance

	^ aBalance - transference value! !


!TransferWithdraw methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:15:06'!
transference

	^ transference! !


!TransferWithdraw methodsFor: 'comparing' stamp: 'AB 6/25/2019 23:31:10'!
isTransferWithdraw

	^ true! !


!TransferWithdraw methodsFor: 'value' stamp: 'AB 5/28/2019 16:43:24'!
value

	^ transference value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'ISW1-Fintech'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 16:39:58'!
from: aTransference

	^ self new initializeFrom: aTransference ! !
