!classDefinition: #ConnectionTest category: #'IS1-Connection-Decorator'!
TestCase subclass: #ConnectionTest
	instanceVariableNames: 'logStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection-Decorator'!

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 10:57:57'!
test01

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	
	self assert: sentString equals: sent nextLine.
	self assert: sent atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/9/2019 11:59:51'!
test02

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: sentString equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[January 1, 2019 at 10:20:30] ',sentString equals: logStream nextLine.
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

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/9/2019 12:00:00'!
test06

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createZippedEncryptedTracedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[encrypted[',sentString,']]' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[January 1, 2019 at 10:20:30] ',sentString equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/9/2019 12:00:07'!
test07

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedZippedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'zipped[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[January 1, 2019 at 10:20:30] zipped[',sentString,']' equals: logStream nextLine.
	self assert: logStream atEnd! !

!ConnectionTest methodsFor: 'tests' stamp: 'HAW 5/9/2019 12:00:16'!
test08

	| connection sent sentString | 
	
	sentString := 'hello!!'.
	connection := self createTracedEncryptedConnection.
	connection send: sentString.
	
	sent := ReadStream on: connection sentContents.
	self assert: 'encrypted[',sentString,']' equals: sent nextLine.
	self assert: sent atEnd.
	
	logStream reset.
	self assert: '[January 1, 2019 at 10:20:30] encrypted[',sentString,']' equals: logStream nextLine.
	self assert: logStream atEnd! !


!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 11:26:44'!
createConnection
	
	^TCPConnection new! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:50:16'!
createEncryptedConnection
	
	^self createEncryptedConnectionDecoratting: self createConnection ! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:50:41'!
createEncryptedConnectionDecoratting: aDecoratee

	^EncryptedConnection decoratting: aDecoratee ! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:50:56'!
createLogStream
	
	logStream := ReadWriteStream on: String new.
	^logStream 
	! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:51:30'!
createTracedConnection
	
	^self createTracedConnectionDecorating: self createConnection 
	! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:51:46'!
createTracedConnectionDecorating: aDecoratee

	^TracedConnection decoratting: aDecoratee loggingInto: self createLogStream clock: self.! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:54:19'!
createTracedEncryptedConnection
	
	^self createEncryptedConnectionDecoratting: self createTracedConnection ! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:52:03'!
createTracedZippedConnection
	
	^self createZippedConnectionDecoratting: (self createTracedConnectionDecorating: self createConnection)! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 11:13:10'!
createZippedConnection
	
	^ZippedConnection decoratting: self createConnection .! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:52:19'!
createZippedConnectionDecoratting: aDecoratee

	^ZippedConnection decoratting: aDecoratee ! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:52:43'!
createZippedEncryptedConnection
	
	^ self createEncryptedConnectionDecoratting: (self createZippedConnectionDecoratting: self createConnection).! !

!ConnectionTest methodsFor: 'connection creation' stamp: 'HAW 5/8/2019 17:52:57'!
createZippedEncryptedTracedConnection
	
	^self createTracedConnectionDecorating: (self createEncryptedConnectionDecoratting: (self createZippedConnectionDecoratting: self createConnection))! !


!ConnectionTest methodsFor: 'clock' stamp: 'HAW 5/9/2019 11:59:26'!
now
	
	^GregorianDateTime date: (January/1/2019) timeOfDay: (TimeOfDay hours: 10 minutes: 20 seconds: 30).
	! !


!classDefinition: #Connection category: #'IS1-Connection-Decorator'!
Object subclass: #Connection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection-Decorator'!

!Connection methodsFor: 'sending' stamp: 'HAW 5/8/2019 11:28:00'!
send: aPackage

	self subclassResponsibility ! !

!Connection methodsFor: 'sending' stamp: 'HAW 5/8/2019 11:27:29'!
sentContents

	self subclassResponsibility ! !


!classDefinition: #ConnectionDecorator category: #'IS1-Connection-Decorator'!
Connection subclass: #ConnectionDecorator
	instanceVariableNames: 'decoratee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection-Decorator'!

!ConnectionDecorator methodsFor: 'initialization' stamp: 'HAW 5/8/2019 11:13:30'!
initializeDecoratting: aDecoratee 

	decoratee := aDecoratee ! !


!ConnectionDecorator methodsFor: 'sending' stamp: 'HAW 5/8/2019 11:28:25'!
send: aPackage

	^decoratee send: aPackage ! !

!ConnectionDecorator methodsFor: 'sending' stamp: 'HAW 5/8/2019 11:12:52'!
sentContents
	
	^decoratee sentContents ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConnectionDecorator class' category: #'IS1-Connection-Decorator'!
ConnectionDecorator class
	instanceVariableNames: ''!

!ConnectionDecorator class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 11:12:24'!
decoratting: aDecoratee

	^self new initializeDecoratting: aDecoratee ! !


!classDefinition: #EncryptedConnection category: #'IS1-Connection-Decorator'!
ConnectionDecorator subclass: #EncryptedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection-Decorator'!

!EncryptedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 11:28:45'!
send: aPackage

	^decoratee send: 'encrypted[', aPackage, ']'! !


!classDefinition: #TracedConnection category: #'IS1-Connection-Decorator'!
ConnectionDecorator subclass: #TracedConnection
	instanceVariableNames: 'logStream clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection-Decorator'!

!TracedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 17:55:17'!
send: aPackage

	self logSendOf: aPackage.
		
	^decoratee send: aPackage
! !


!TracedConnection methodsFor: 'initialization' stamp: 'HAW 5/8/2019 17:38:57'!
initializeLoggingInto: aLog Clock: aClock 

	clock := aClock.
	logStream := aLog ! !


!TracedConnection methodsFor: 'logging' stamp: 'HAW 5/8/2019 17:55:27'!
logSendOf: aPackage

	logStream 
		nextPut: $[;
		print: clock now;
		nextPutAll: '] ';
		nextPutAll: aPackage;
		newLine.! !


!TracedConnection methodsFor: 'become' stamp: 'HAW 5/9/2019 12:05:41'!
becomeDecoratee
	
	self shouldBeImplemented ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TracedConnection class' category: #'IS1-Connection-Decorator'!
TracedConnection class
	instanceVariableNames: ''!

!TracedConnection class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 17:38:43'!
decoratting: aDecoratee loggingInto: aLog clock: aClock

	^(self decoratting: aDecoratee) initializeLoggingInto: aLog Clock: aClock ! !


!classDefinition: #ZippedConnection category: #'IS1-Connection-Decorator'!
ConnectionDecorator subclass: #ZippedConnection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection-Decorator'!

!ZippedConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 11:29:21'!
send: aPackage

	^decoratee send: 'zipped[', aPackage, ']'! !


!classDefinition: #TCPConnection category: #'IS1-Connection-Decorator'!
Connection subclass: #TCPConnection
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Connection-Decorator'!

!TCPConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 11:29:37'!
send: aPackage

	stream 
		nextPutAll: aPackage;
		newLine ! !

!TCPConnection methodsFor: 'sending' stamp: 'HAW 5/8/2019 10:01:21'!
sentContents
	
	^stream contents ! !


!TCPConnection methodsFor: 'initialization' stamp: 'HAW 5/8/2019 09:01:51'!
initialize

	stream := WriteStream on: String new! !
