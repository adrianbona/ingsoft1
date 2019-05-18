!classDefinition: #IntegerReportTest category: #'Ingsoft-IntegerReports'!
TestCase subclass: #IntegerReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:03:16'!
test01

	| lines report  integerToAnalize |
	
	integerToAnalize := 100.
	report := BasicIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:03:37'!
test02

	| lines report integerToAnalize |
	
	integerToAnalize := 200.
	report := IntegerOnDifferentBasesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.
	
! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:05:09'!
test03

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := ComplexIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:06:01'!
test04

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CombinedIntegerPropertiesReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.
		
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:08:26'!
test05

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CompleteIntegerReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.

	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.
	
 ! !


!IntegerReportTest methodsFor: 'assertions' stamp: 'HAW 5/12/2019 19:20:40'!
shouldnt: aClosureToMeasure takeMoreThan: aTimeLimit

	| elapsedTime |
	
	elapsedTime :=  aClosureToMeasure timeToRun * millisecond.
	
	self assert: elapsedTime <= aTimeLimit 
	
! !


!classDefinition: #IntegerReport category: #'Ingsoft-IntegerReports'!
Object subclass: #IntegerReport
	instanceVariableNames: 'integerToAnalize lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerReport methodsFor: 'as yet unclassified' stamp: 'AB 5/17/2019 19:00:07'!
initialize

	self wait.
	lines _ OrderedCollection new.
! !

!IntegerReport methodsFor: 'as yet unclassified' stamp: 'AB 5/17/2019 17:15:53'!
lines

	^ lines! !

!IntegerReport methodsFor: 'as yet unclassified' stamp: 'AB 5/17/2019 17:09:39'!
value

	^ lines! !

!IntegerReport methodsFor: 'as yet unclassified' stamp: 'AB 5/17/2019 17:06:36'!
wait

	(Delay forSeconds: 1) wait! !


!classDefinition: #IntegerReportDecorator category: #'Ingsoft-IntegerReports'!
Object subclass: #IntegerReportDecorator
	instanceVariableNames: 'integerToAnalize decoratee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerReportDecorator methodsFor: 'initialization' stamp: 'AB 5/17/2019 19:01:24'!
initializeFor: anIntegerToAnalize

	self initializeFor: anIntegerToAnalize with: (IntegerReport new initialize)! !

!IntegerReportDecorator methodsFor: 'initialization' stamp: 'AB 5/17/2019 16:39:17'!
initializeFor: anIntegerToAnalize with: anIntegerReport

	integerToAnalize _ anIntegerToAnalize.
	decoratee _ anIntegerReport.! !


!IntegerReportDecorator methodsFor: 'reporting' stamp: 'AB 5/17/2019 17:40:50'!
lines

	^ decoratee lines! !

!IntegerReportDecorator methodsFor: 'reporting' stamp: 'HAW 5/12/2019 19:12:35'!
value

	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegerReportDecorator class' category: #'Ingsoft-IntegerReports'!
IntegerReportDecorator class
	instanceVariableNames: ''!

!IntegerReportDecorator class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:11:34'!
for: anIntegerToAnalize

	^self new initializeFor: anIntegerToAnalize ! !

!IntegerReportDecorator class methodsFor: 'instance creation' stamp: 'AB 5/17/2019 16:38:33'!
for: anIntegerToAnalize with: anIntegerReport

	^self new initializeFor: anIntegerToAnalize with: anIntegerReport! !


!classDefinition: #CombinedIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerReportDecorator subclass: #CombinedIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!CombinedIntegerPropertiesReport methodsFor: 'reporting' stamp: 'AB 5/17/2019 18:32:09'!
value

	^ decoratee value! !


!CombinedIntegerPropertiesReport methodsFor: 'initialization' stamp: 'AB 5/17/2019 19:20:47'!
initializeFor: anIntegerToAnalize

	| complexIntegerPropertiesReport basicAndComplexIntegerPropertiesReport |
	
	complexIntegerPropertiesReport _ ComplexIntegerPropertiesReport for: anIntegerToAnalize.
	basicAndComplexIntegerPropertiesReport _ BasicIntegerPropertiesReport for: anIntegerToAnalize with: complexIntegerPropertiesReport.

	self initializeFor: anIntegerToAnalize with: (basicAndComplexIntegerPropertiesReport)! !


!classDefinition: #CompleteIntegerReport category: #'Ingsoft-IntegerReports'!
IntegerReportDecorator subclass: #CompleteIntegerReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!CompleteIntegerReport methodsFor: 'reporting' stamp: 'AB 5/17/2019 19:12:10'!
value

	^ decoratee value! !


!CompleteIntegerReport methodsFor: 'initialization' stamp: 'AB 5/17/2019 19:24:34'!
initializeFor: anIntegerToAnalize

	| integerOnDifferentBasesReport complexIntegerPropertiesAndDifferentBaseReport basicAndComplexIntegerPropertiesAndDifferentBaseReport |
	
	integerOnDifferentBasesReport _ IntegerOnDifferentBasesReport for: anIntegerToAnalize.
	complexIntegerPropertiesAndDifferentBaseReport _ ComplexIntegerPropertiesReport for: anIntegerToAnalize with: integerOnDifferentBasesReport.
	basicAndComplexIntegerPropertiesAndDifferentBaseReport _ BasicIntegerPropertiesReport for: anIntegerToAnalize with: complexIntegerPropertiesAndDifferentBaseReport.

	self initializeFor: anIntegerToAnalize with: (basicAndComplexIntegerPropertiesAndDifferentBaseReport)! !


!classDefinition: #IntegerOnDifferentBasesReport category: #'Ingsoft-IntegerReports'!
IntegerReportDecorator subclass: #IntegerOnDifferentBasesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerOnDifferentBasesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:04:56'!
addNumberInBase: aBase to: lines title: aTitle

	lines add: aTitle, ': ', (integerToAnalize storeStringBase: aBase).
	
	! !


!IntegerOnDifferentBasesReport methodsFor: 'reporting' stamp: 'AB 5/17/2019 17:29:36'!
value

	self 
		addNumberInBase: 2 to: decoratee lines title: 'Binary';
		addNumberInBase: 8 to: decoratee lines title: 'Octal';
		addNumberInBase: 16 to: decoratee lines title: 'Hexadecimal'.

	^ decoratee value! !


!classDefinition: #IntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerReportDecorator subclass: #IntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerPropertiesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:02:54'!
addLineTo: lines title: aTitle with: anIntegerClosure

	lines add: aTitle, ': ', anIntegerClosure value printString
! !


!classDefinition: #BasicIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerPropertiesReport subclass: #BasicIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!BasicIntegerPropertiesReport methodsFor: 'reporting' stamp: 'AB 5/17/2019 17:29:55'!
value

	self
		addLineTo: decoratee lines title: 'Factorial' with: [ integerToAnalize factorial ];
		addLineTo: decoratee lines title: 'Roman' with: [ integerToAnalize printStringRoman ];
		addLineTo: decoratee lines title: 'Ln' with: [ integerToAnalize ln ].

	^ decoratee value! !


!classDefinition: #ComplexIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerPropertiesReport subclass: #ComplexIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!ComplexIntegerPropertiesReport methodsFor: 'reporting' stamp: 'AB 5/17/2019 17:15:05'!
value

	self
		addLineTo: decoratee lines title: 'Prime?' with: [ integerToAnalize isPrime ];
		addLineTo: decoratee lines title: 'Next Prime' with: [ integerToAnalize nextPrime ];
		addLineTo: decoratee lines title: 'Sqrt' with: [ integerToAnalize sqrt ].

	^ decoratee value! !
