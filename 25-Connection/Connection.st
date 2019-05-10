!classDefinition: #ConnectionTest category: #'IS1-Connection'!
TestCase subclass: #ConnectionTest
	instanceVariableNames: 'logStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 10:57:57'!
test01

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	
	self assert: sentString equals: sent nextLine.
	self assert: sent atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 17:46:16'!
test02

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: sentString equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] ',sentString equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 10:58:42'!
test03

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createZippedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 10:59:43'!
test04

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createEncryptedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'encrypted[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 11:00:51'!
test05

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createZippedEncryptedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[encrypted[',sentString,']]' equals: sent nextLine.
	self assert: sent atEnd.
	
	! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 17:46:39'!
test06

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createZippedEncryptedTracedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[encrypted[',sentString,']]' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] ',sentString equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 18:15:26'!
test07

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedZippedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] zipped[',sentString,']' equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 18:15:32'!
test08

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedEncryptedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'encrypted[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[2019-01-01T10:20:30+00:00] encrypted[',sentString,']' equals: logStream nextLine.
	self assert: logStream atEnd! !


!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:23:34'!
createConnection
	
	^ Connection new! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 20:52:47'!
createEncryptedConnection
	
	| connection |
	
	connection _ self createConnection.
	
	^ EncryptedConnection with: connection! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:21:12'!
createEncryptedZippedConnection
	
	| zippedConnection |
	
	zippedConnection  _ self createZippedConnection.
	
	^ EncryptedConnection with: zippedConnection.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:23:49'!
createLogStream
	
	logStream _ ReadWriteStream on: String new.
	
	^ logStream 
	! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:06:39'!
createTracedConnection
	
	| connection |
	
	connection _ self createConnection.
	
	^ TracedConnection loggingInto: self createLogStream clock: self with: connection! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:17:44'!
createTracedEncryptedConnection
	
	| tracedConnection |
	
	tracedConnection _ self createTracedConnection.
	
	^ EncryptedConnection with: tracedConnection.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:18:21'!
createTracedZippedConnection
	
	| tracedConnection |
	
	tracedConnection _ self createTracedConnection.
	
	^ ZippedConnection with: tracedConnection.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:00:17'!
createZippedConnection

	| connection |
	
	connection _ self createConnection.
	
	^ ZippedConnection with: connection.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:22:08'!
createZippedEncryptedConnection
	
	| zippedConnection |
	
	zippedConnection  _ self createZippedConnection.
	
	^ EncryptedConnection with: zippedConnection.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'AB 5/9/2019 21:20:35'!
createZippedEncryptedTracedConnection
	
	| encryptedZippedConnection |
	
	encryptedZippedConnection  _ self createEncryptedZippedConnection.
	
	^ TracedConnection loggingInto: self createLogStream clock: self with: encryptedZippedConnection ! !


!ConnectionTest methodsFor: 'clock' stamp: 'HAW 5/8/2019 10:14:32'!
now
	
	^DateAndTime year: 2019 day: 1 hour: 10 minute: 20 second: 30
! !


!classDefinition: #Connection category: #'IS1-Connection'!
Object subclass: #Connection
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!Connection methodsFor: 'sending' stamp: 'HAW 5/8/2019 18:06:40'!
send: aPackage

	stream nextPutAll: aPackage! !

!Connection methodsFor: 'sending' stamp: 'HAW 5/8/2019 10:01:21'!
sentContents
	
	^stream contents ! !


!Connection methodsFor: 'initialization' stamp: 'HAW 5/8/2019 09:01:51'!
initialize

	stream := WriteStream on: String new! !


!classDefinition: #ConnectionDecorator category: #'IS1-Connection'!
Object subclass: #ConnectionDecorator
	instanceVariableNames: 'connection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!ConnectionDecorator methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 21:42:55'!
sentContents
	
	^ connection sentContents ! !


!classDefinition: #EncryptedConnection category: #'IS1-Connection'!
ConnectionDecorator subclass: #EncryptedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!EncryptedConnection methodsFor: 'sending' stamp: 'AB 5/9/2019 20:44:23'!
initializeWith: aConnection

	connection _ aConnection ! !

!EncryptedConnection methodsFor: 'sending' stamp: 'AB 5/9/2019 20:50:17'!
send: aPackage

	^ connection send: 'encrypted[', aPackage, ']'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EncryptedConnection class' category: #'IS1-Connection'!
EncryptedConnection class
	instanceVariableNames: ''!

!EncryptedConnection class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 20:44:50'!
with: aConnection

	^ self new initializeWith: aConnection ! !


!classDefinition: #TracedConnection category: #'IS1-Connection'!
ConnectionDecorator subclass: #TracedConnection
	instanceVariableNames: 'logStream clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!TracedConnection methodsFor: 'sending' stamp: 'AB 5/9/2019 20:58:49'!
send: aPackage

	self logSendOf: aPackage.
		
	^connection send: aPackage
! !


!TracedConnection methodsFor: 'initialization' stamp: 'AB 5/9/2019 20:57:08'!
initializeLoggingInto: aLog clock: aClock with: aConnection
	
	clock _ aClock.
	logStream _ aLog.
	connection _ aConnection! !


!TracedConnection methodsFor: 'logging' stamp: 'HAW 5/8/2019 17:55:27'!
logSendOf: aPackage

	logStream 
		nextPut: $[;
		print: clock now;
		nextPutAll: '] ';
		nextPutAll: aPackage;
		newLine.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TracedConnection class' category: #'IS1-Connection'!
TracedConnection class
	instanceVariableNames: ''!

!TracedConnection class methodsFor: 'instance creation' stamp: 'AB 5/9/2019 20:54:19'!
loggingInto: aLog clock: aClock with: aConnection

	^ self new initializeLoggingInto: aLog clock: aClock with: aConnection! !


!classDefinition: #ZippedConnection category: #'IS1-Connection'!
ConnectionDecorator subclass: #ZippedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection'!

!ZippedConnection methodsFor: 'sending' stamp: 'AB 5/9/2019 21:00:48'!
initializeWith: aConnection

	connection _ aConnection ! !

!ZippedConnection methodsFor: 'sending' stamp: 'AB 5/9/2019 21:01:51'!
send: aPackage

	^ connection send: 'zipped[', aPackage, ']'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ZippedConnection class' category: #'IS1-Connection'!
ZippedConnection class
	instanceVariableNames: ''!

!ZippedConnection class methodsFor: 'as yet unclassified' stamp: 'AB 5/9/2019 21:00:35'!
with: aConnection

	^ self new initializeWith: aConnection ! !
