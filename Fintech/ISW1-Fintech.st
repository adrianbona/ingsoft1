!classDefinition: #FintechTest category: #'ISW1-Fintech'!
TestCase subclass: #FintechTest
	instanceVariableNames: 'aNoonClock fintechAtNoon a22hsClock fintechAt22hs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:18:46'!
setUp

	aNoonClock _ ManualClock startingOn: (DateAndTime noon).
	fintechAtNoon _ Fintech measuringWith: aNoonClock.
	
	a22hsClock _ ManualClock startingOn: (DateAndTime midnight - (Duration hours: 2)).
	fintechAt22hs _ Fintech measuringWith: a22hsClock.! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:19:15'!
test01NewWalletHasBalanceOf1

	| walletId |
	
	walletId _ fintechAtNoon createWallet.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: walletId).! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:19:38'!
test02QueryingForBalanceOfAnUnexistingWalletReturnsAnError

	| walletId |
	
	self should: [ fintechAtNoon balanceOfWallet: walletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech unexistingWalletErrorMessage ]! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:28:34'!
test03SlowTransferMustHaveValidFromWalletId

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	
	self should: [ fintechAtNoon slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech unexistingWalletErrorMessage ]! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:20:10'!
test04SourceAndTargetWalletsIdMustBeDifferentForSlowTransfer

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ aSourceWalletId.
	
	self should: [ fintechAtNoon slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech sourceAndTargetWalletIdsMustBeDifferent ]! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:20:24'!
test05AmountForSlowTransferMustBeBiggerThanRequiredMinimum

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	anAmount _ 0.0000009 * (BaseUnit named: 'ISW1COIN').
	
	self should: [ fintechAtNoon slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech amountIsNotBiggerThanTheRequiredMinimum ]! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:20:37'!
test06CannotMakeASlowTransferWithUnsufficientFunds

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	anAmount _ 1 * (BaseUnit named: 'ISW1COIN').
	
	self should: [ fintechAtNoon slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech unsufficientFunds ]! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:20:53'!
test07SourceBalanceChangesAfterSlowTransfer

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aSourceWalletId).
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	fintechAtNoon slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId.
	
	self assert: 0.49 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aSourceWalletId).! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:21:07'!
test08FastTransferMustHaveValidFromWalletId

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	
	self should: [ fintechAtNoon fastTransfer: anAmount from: aSourceWalletId to: aTargetWalletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech unexistingWalletErrorMessage ]! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:21:20'!
test09SourceBalanceChangesAfterFastTransfer

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aSourceWalletId).
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	fintechAtNoon fastTransfer: anAmount from: aSourceWalletId to: aTargetWalletId.
	
	self assert: 0.48 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aSourceWalletId).! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:21:32'!
test10NewWalletReturnsEmptyCollectionForAllTransactions

	| walletId |

	walletId _ fintechAtNoon createWallet.

	self assert: (fintechAtNoon allTransactionsOf: walletId) isEmpty.! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:21:51'!
test11AllTransactionsIncludesOneTransferAfterFastTransfer

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	
	self assert: (fintechAtNoon allTransactionsOf: aSourceWalletId) size equals: 0.
	self assert: (fintechAtNoon allTransactionsOf: aTargetWalletId) size equals: 0.
	
	fintechAtNoon fastTransfer: anAmount from: aSourceWalletId to: aTargetWalletId.
	
	self assert: (fintechAtNoon allTransactionsOf: aSourceWalletId) size equals: 1.
	self assert: (fintechAtNoon allTransactionsOf: aTargetWalletId) size equals: 1.! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:23:42'!
test12TargetBalanceChangesAfterFastTransferDuration

	| aSourceWalletId aTargetWalletId anAmount |
	
	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aTargetWalletId ).
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	fintechAtNoon fastTransfer: anAmount from: aSourceWalletId to: aTargetWalletId.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aTargetWalletId ).
	
	aNoonClock add: (Duration minutes: 10).
	
	self assert: 0.48 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aSourceWalletId).! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:24:18'!
test13TargetBalanceChangesAfterSlowTransferDuration

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aTargetWalletId ).
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	fintechAtNoon slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aTargetWalletId ).
	
	aNoonClock add: (Duration hours: 1).
	
	self assert: 0.49 * (BaseUnit named: 'ISW1COIN') equals: (fintechAtNoon balanceOfWallet: aSourceWalletId).! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:24:32'!
test14NewWalletReturnsEmptyCollectionForAllPendingTransactions

	| walletId |
	
	walletId _ fintechAtNoon createWallet.

	self assert: (fintechAtNoon allPendingTransactionsOf: walletId) isEmpty.! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:25:05'!
test15PendingTransactionsForSlowTransfers

	| aSourceWalletId aTargetWalletId anAmount |
	
	aSourceWalletId _ fintechAtNoon createWallet.
	aTargetWalletId  _ fintechAtNoon createWallet.
	
	self assert: (fintechAtNoon allPendingTransactionsOf: aTargetWalletId) isEmpty.
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
	fintechAtNoon slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId.
	
	self deny: (fintechAtNoon allPendingTransactionsOf: aTargetWalletId) isEmpty.
	
	aNoonClock add: (Duration hours: 1).
	
	self assert: (fintechAtNoon allPendingTransactionsOf: aTargetWalletId) isEmpty.! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:27:27'!
test16CanNotTransferToInBlockingTimeframe

	| aSourceWalletId aTargetWalletId anAmount |

	aSourceWalletId _ fintechAt22hs createWallet.
	aTargetWalletId  _ fintechAt22hs createWallet.
	
	anAmount _ 0.5 * (BaseUnit named: 'ISW1COIN').
		
	self should: [ fintechAt22hs slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech canNotMakeATransferDuringTimeFrame ].
	
	a22hsClock add: (Duration hours: 1).
	
	fintechAt22hs slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId.
	
	self assert: (fintechAt22hs allTransactionsOf: aSourceWalletId) size equals: 1.
	self assert: (fintechAt22hs allTransactionsOf: aTargetWalletId) size equals: 1.! !


!classDefinition: #Fintech category: #'ISW1-Fintech'!
Object subclass: #Fintech
	instanceVariableNames: 'wallets uniqueWalletId clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:01:02'!
allPendingTransactionsOf: aWalletId

	^ (self allTransactionsOf: aWalletId) select: [:aTransaction | aTransaction creditedOn: clock now]! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:19:53'!
allTransactionsOf: aWalletId

	^ (self walletFor: aWalletId) transfers.! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 13:16:41'!
assertAmountIsGreaterThanMinimum: anAmount

	(anAmount < self minimumAmountForTransfer) ifTrue: [ self error: Fintech amountIsNotBiggerThanTheRequiredMinimum ]! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:34:15'!
assertFundsFor: aWalletId areGreaterThan: anAmount withCommission: aCommission
	
	| totalAmount |
	
	totalAmount _ (anAmount + (anAmount * aCommission)).
	((self balanceOfWallet: aWalletId) > totalAmount) ifFalse: [ self error: Fintech unsufficientFunds ]! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:06:32'!
assertTransferGetsCreditedOutsideTimeFrameWhenTaking: aTransferDuration

	((clock now + aTransferDuration) time between: self timeFrameFrom and: self timeFrameTo) ifTrue: [ self error: Fintech canNotMakeATransferDuringTimeFrame ]! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:22:09'!
assertWalletIdExists: walletId

	wallets at: walletId ifAbsent: [ self error: Fintech unexistingWalletErrorMessage ].! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 12:58:00'!
assertWalletIdsAreDifferentFor: aSourceWalletId and: aTargetWalletId

	(aSourceWalletId = aTargetWalletId) ifTrue: [ self error: Fintech sourceAndTargetWalletIdsMustBeDifferent ]! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:25:03'!
balanceOfWallet: walletId
	
	^ (self walletFor: walletId) balance! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:59:34'!
createWallet
	
	| walletId |
	
	walletId _ self uniqueWalletId.
	
	wallets at: walletId put: (Wallet withClock: clock).
	
	^ walletId! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:43:29'!
fastTransfer: anAmount from: aSourceWalletId to: aTargetWalletId

	self transfer: anAmount from: aSourceWalletId to: aTargetWalletId withCommission: self fastTransferCommission andDelay: self fastTransferDelay.
	! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:04:29'!
fastTransferCommission

	^ 0.04! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:43:51'!
fastTransferDelay

	^ Duration minutes: 10! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:27:52'!
initialize

	wallets _ Dictionary new.
	uniqueWalletId _ 0.
	clock _ ManualClock startingOn: DateAndTime now.
	super initialize.! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:27:21'!
initializeWith: aClock

	self initialize.
	clock _ aClock.! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:32:53'!
minimumAmountForTransfer

	^ 0.000001 * (BaseUnit named: 'ISW1COIN')! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 16:08:44'!
slowTransfer: anAmount from: aSourceWalletId to: aTargetWalletId

	self transfer: anAmount from: aSourceWalletId to: aTargetWalletId withCommission: self slowTransferCommission andDelay: self slowTransferDelay.
	! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:33:14'!
slowTransferCommission

	^ 0.02! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 16:08:54'!
slowTransferDelay

	^ Duration hours: 1! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:07:16'!
timeFrameFrom

	^ Time hour: 23 minute: 00 second: 00! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:07:24'!
timeFrameTo

	^ Time hour: 23 minute: 59 second: 59! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 17:13:02'!
transfer: anAmount from: aSourceWalletId to: aTargetWalletId withCommission: aCommission andDelay: aDelay

	| sourceWallet transferAmountPlusCommision targetWallet |
	
	self assertWalletIdsAreDifferentFor: aSourceWalletId and: aTargetWalletId.
	self assertAmountIsGreaterThanMinimum: anAmount.
	self assertFundsFor: aSourceWalletId areGreaterThan: anAmount withCommission: aCommission.
	self assertTransferGetsCreditedOutsideTimeFrameWhenTaking: aDelay.
	
	sourceWallet _ self walletFor: aSourceWalletId.
	targetWallet _ self walletFor: aTargetWalletId .
	transferAmountPlusCommision _ (anAmount + (anAmount * aCommission)).
	
	Transfer register: transferAmountPlusCommision from: sourceWallet to: targetWallet creditedOn: (clock now + aDelay).
	! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 13:11:54'!
uniqueWalletId

	^ uniqueWalletId _ uniqueWalletId + 1
! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:24:08'!
walletFor: walletId

	^ wallets at: walletId ifAbsent: [ self error: Fintech unexistingWalletErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fintech class' category: #'ISW1-Fintech'!
Fintech class
	instanceVariableNames: ''!

!Fintech class methodsFor: 'error handling' stamp: 'JR 6/28/2019 13:03:53'!
amountIsNotBiggerThanTheRequiredMinimum
	
	^ 'amountIsNotBiggerThanTheRequiredMinimum'! !

!Fintech class methodsFor: 'error handling' stamp: 'JR 6/28/2019 17:06:51'!
canNotMakeATransferDuringTimeFrame

	^ 'Can not make a transfer during time frame'! !

!Fintech class methodsFor: 'error handling' stamp: 'JR 6/28/2019 15:26:08'!
measuringWith: aClock

	^ self new initializeWith: aClock! !

!Fintech class methodsFor: 'error handling' stamp: 'JR 6/28/2019 12:55:19'!
sourceAndTargetWalletIdsMustBeDifferent
	
	^ 'Source And Target Wallet Ids Must Be Different'! !

!Fintech class methodsFor: 'error handling' stamp: 'JR 6/28/2019 11:56:04'!
unexistingWalletErrorMessage

	^ 'Wallet not found'! !

!Fintech class methodsFor: 'error handling' stamp: 'JR 6/28/2019 13:19:02'!
unsufficientFunds
	
	^ 'unsufficientFunds'! !


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


!Transfer methodsFor: 'initialization' stamp: 'JR 6/28/2019 14:52:13'!
initializeFor: anAmount from: sourceWallet to: targetWallet

	value _ anAmount.

	from _ TransferWithdraw from: self.
	sourceWallet register: from.

	to _ TransferDeposit from: self.
	targetWallet register: to.
! !

!Transfer methodsFor: 'initialization' stamp: 'JR 6/28/2019 15:52:50'!
initializeFor: anAmount from: sourceWallet to: targetWallet creditedOn: aDateAndTime

	value _ anAmount.

	from _ TransferWithdraw from: self.
	sourceWallet register: from.

	to _ TransferDeposit from: self creditedOn: aDateAndTime.
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

!Transfer class methodsFor: 'instance creation' stamp: 'JR 6/28/2019 14:51:09'!
register: anAmount from: sourceWallet to: targetWallet
 
	^ self new initializeFor: anAmount from: sourceWallet to: targetWallet! !

!Transfer class methodsFor: 'instance creation' stamp: 'JR 6/28/2019 15:52:20'!
register: anAmount from: sourceWallet to: targetWallet creditedOn: aDateAndTime
 
	^ self new initializeFor: anAmount from: sourceWallet to: targetWallet creditedOn: aDateAndTime! !


!classDefinition: #Wallet category: #'ISW1-Fintech'!
Object subclass: #Wallet
	instanceVariableNames: 'transfers clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Wallet methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 16:02:49'!
balance

	^ (transfers inject: 1 * (BaseUnit named: 'ISW1COIN') into: [ :currentBalance :transaction | transaction affectBalance: currentBalance forDate: clock now ])! !

!Wallet methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 16:00:48'!
initialize

	transfers _ OrderedCollection new.
	clock _ ManualClock new.
	super initialize.! !

!Wallet methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 16:00:16'!
initializeWith: aClock

	self initialize.
	clock _ aClock.
	! !

!Wallet methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:53:20'!
register: aTransfer

	transfers add: aTransfer! !

!Wallet methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:19:08'!
transfers

	^ transfers copy! !

!Wallet methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 14:43:48'!
withdraw: anAmount

	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Wallet class' category: #'ISW1-Fintech'!
Wallet class
	instanceVariableNames: ''!

!Wallet class methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 15:59:56'!
withClock: aClock

	^ self new initializeWith: aClock! !


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

!WalletTransaction methodsFor: 'balance' stamp: 'JR 6/28/2019 16:03:04'!
affectBalance: aBalance forDate: aDateAndTime

	self subclassResponsibility ! !


!WalletTransaction methodsFor: 'comparing' stamp: 'JR 6/28/2019 16:58:07'!
creditedOn: aDateAndTime

	self subclassResponsibility ! !

!WalletTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:23'!
isDeposit

	^ false! !

!WalletTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:42'!
isTransferenceDeposit

	^ false! !

!WalletTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:49'!
isTransferenceWithdraw

	^ false! !

!WalletTransaction methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:37:30'!
isWithdraw

	^ false! !


!classDefinition: #TransferDeposit category: #'ISW1-Fintech'!
WalletTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transference creditedOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!TransferDeposit methodsFor: 'initialization' stamp: 'AB 5/28/2019 16:41:40'!
initializeFrom: aTransference

	transference _ aTransference! !

!TransferDeposit methodsFor: 'initialization' stamp: 'JR 6/28/2019 15:53:02'!
initializeFrom: aTransference creditedOn: dateAndTime

	creditedOn _ dateAndTime.
	transference _ aTransference
	! !


!TransferDeposit methodsFor: 'balance' stamp: 'AB 5/28/2019 16:43:15'!
affectBalance: aBalance

	^ aBalance + self value! !

!TransferDeposit methodsFor: 'balance' stamp: 'JR 6/28/2019 16:06:01'!
affectBalance: aBalance forDate: aDateAndTime

	(aDateAndTime < creditedOn) ifFalse: [^ aBalance + self value].
	
	^ aBalance! !


!TransferDeposit methodsFor: 'value' stamp: 'AB 5/28/2019 16:43:04'!
value

	^ transference value! !


!TransferDeposit methodsFor: 'transaction' stamp: 'JR 6/28/2019 17:01:50'!
creditedOn: aDateAndTime

	^ aDateAndTime < creditedOn ! !

!TransferDeposit methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:14:39'!
transference

	^ transference! !


!TransferDeposit methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:38:29'!
isTransferenceDeposit

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'ISW1-Fintech'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 16:39:49'!
from: aTransference

	^ self new initializeFrom: aTransference ! !

!TransferDeposit class methodsFor: 'instance creation' stamp: 'JR 6/28/2019 15:53:14'!
from: aTransference creditedOn: dateAndTime

	^ self new initializeFrom: aTransference creditedOn: dateAndTime! !


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

!TransferWithdraw methodsFor: 'balance' stamp: 'JR 6/28/2019 16:03:48'!
affectBalance: aBalance forDate: aDateAndTime

	^ self affectBalance: aBalance ! !


!TransferWithdraw methodsFor: 'transaction' stamp: 'AB 5/28/2019 17:15:06'!
transference

	^ transference! !


!TransferWithdraw methodsFor: 'comparing' stamp: 'AB 6/1/2019 16:39:22'!
isTransferenceWithdraw

	^ true! !


!TransferWithdraw methodsFor: 'value' stamp: 'AB 5/28/2019 16:43:24'!
value

	^ transference value! !


!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 16:58:28'!
creditedOn: aDateAndTime

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'ISW1-Fintech'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'AB 5/28/2019 16:39:58'!
from: aTransference

	^ self new initializeFrom: aTransference ! !
