!classDefinition: #FintechTest category: #'ISW1-Fintech'!
TestCase subclass: #FintechTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 11:47:51'!
test01NewWalletHasBalanceOf1

	| walletId fintech |
	
	fintech _ Fintech new.
	
	walletId _ fintech createWallet.
	
	self assert: 1 * (BaseUnit named: 'ISW1COIN') equals: (fintech balanceOfWallet: walletId).! !

!FintechTest methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 11:53:35'!
test02QueryingForBalanceOfAnUnexistingWalletReturnsAnError

	| walletId fintech |
	
	fintech _ Fintech new.

	self should: [ fintech balanceOfWallet: walletId ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Fintech unexistingWalletErrorMessage ]! !


!classDefinition: #Fintech category: #'ISW1-Fintech'!
Object subclass: #Fintech
	instanceVariableNames: 'wallets uniqueWalletId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 12:03:38'!
balanceOfWallet: walletId

	(wallets includes: walletId) ifFalse: [ self error: Fintech unexistingWalletErrorMessage ].
	
	^ 1 * (BaseUnit named: 'ISW1COIN')! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 12:02:05'!
createWallet
	
	| newWalletId |
	newWalletId _ uniqueWalletId.
	wallets add: newWalletId.
	^ newWalletId! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 11:59:50'!
initialize

	wallets _ OrderedCollection new.
	uniqueWalletId _ 0.
	super initialize.! !

!Fintech methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 12:00:22'!
uniqueWallettId

	^ uniqueWalletId _ uniqueWalletId + 1
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fintech class' category: #'ISW1-Fintech'!
Fintech class
	instanceVariableNames: ''!

!Fintech class methodsFor: 'as yet unclassified' stamp: 'JR 6/28/2019 11:56:04'!
unexistingWalletErrorMessage

	^ 'Wallet not found'! !
