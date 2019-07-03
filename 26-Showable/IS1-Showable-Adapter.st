!classDefinition: #TextFieldTest category: #'IS1-Showable-Adapter'!
TestCase subclass: #TextFieldTest
	instanceVariableNames: 'drawn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 19:16:41'!
test01

	| juanPerez textField |
	
	juanPerez := Customer named: 'Juan' surnamed: 'Perez'.
	textField := TextField showing: (CustomerToShowableAdapter adapting: juanPerez).
	
	textField showUsing: self.
	
	self assert: 'Perez, Juan' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 19:20:12'!
test02

	| paenza textField |
	
	paenza := Professor named: 'Paenza' teaches: 'Analisis I'.
	textField := TextField showing: (ProfessorToShowableAdapter adapting: paenza).
	
	textField showUsing: self.
	
	self assert: 'Paenza -> Analisis I' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 19:21:07'!
test03

	| roque textField |
	
	roque := Student named: 'Roque Sanchez' identifiedAs: '233/19'.
	textField := TextField showing: (StudentToShowableAdapter adapting: roque).
	
	textField showUsing: self.
	
	self assert: '233/19: Roque Sanchez' equals: drawn! !


!TextFieldTest methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:48:56'!
show: aShowable

	drawn := aShowable ! !


!classDefinition: #Customer category: #'IS1-Showable-Adapter'!
Object subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!Customer methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:47:08'!
initializeNamed: aFirstName surnamed: aLastName 

	firstName := aFirstName.
	lastName := aLastName ! !


!Customer methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:10'!
firstName

	^firstName ! !

!Customer methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:15'!
lastName

	^lastName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #'IS1-Showable-Adapter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:45:58'!
named: aFirstName surnamed: aLastName

	^self new initializeNamed: aFirstName surnamed: aLastName ! !


!classDefinition: #Professor category: #'IS1-Showable-Adapter'!
Object subclass: #Professor
	instanceVariableNames: 'name subject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!Professor methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:24'!
name

	^name! !

!Professor methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:31'!
subject

	^subject ! !


!Professor methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:55:22'!
initializeNamed: aName teaches: aSubject

	name := aName.
	subject := aSubject ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Professor class' category: #'IS1-Showable-Adapter'!
Professor class
	instanceVariableNames: ''!

!Professor class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:55:01'!
named: aName teaches: aSubject

	^self new initializeNamed: aName teaches: aSubject

	! !


!classDefinition: #ShowableModel category: #'IS1-Showable-Adapter'!
Object subclass: #ShowableModel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!ShowableModel methodsFor: 'showing' stamp: 'HAW 5/8/2019 19:10:23'!
asShowable

	self subclassResponsibility ! !


!classDefinition: #CustomerToShowableAdapter category: #'IS1-Showable-Adapter'!
ShowableModel subclass: #CustomerToShowableAdapter
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!CustomerToShowableAdapter methodsFor: 'initialization' stamp: 'HAW 5/8/2019 19:18:06'!
initializeAdapting: aCustomer 
	
	adaptee := aCustomer ! !


!CustomerToShowableAdapter methodsFor: 'showing' stamp: 'HAW 5/8/2019 19:11:24'!
asShowable
	
	^adaptee lastName, ', ', adaptee firstName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerToShowableAdapter class' category: #'IS1-Showable-Adapter'!
CustomerToShowableAdapter class
	instanceVariableNames: ''!

!CustomerToShowableAdapter class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 19:17:50'!
adapting: aCustomer 
	
	^self new initializeAdapting: aCustomer ! !


!classDefinition: #ProfessorToShowableAdapter category: #'IS1-Showable-Adapter'!
ShowableModel subclass: #ProfessorToShowableAdapter
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!ProfessorToShowableAdapter methodsFor: 'initialization' stamp: 'HAW 5/8/2019 19:20:43'!
initializeAdapting: aProfessor 
	
	adaptee := aProfessor ! !


!ProfessorToShowableAdapter methodsFor: 'showing' stamp: 'HAW 5/8/2019 19:12:26'!
asShowable
	
	^adaptee name, ' -> ', adaptee subject ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProfessorToShowableAdapter class' category: #'IS1-Showable-Adapter'!
ProfessorToShowableAdapter class
	instanceVariableNames: ''!

!ProfessorToShowableAdapter class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 19:20:28'!
adapting: aProfessor 
	
	^self new initializeAdapting: aProfessor ! !


!classDefinition: #StudentToShowableAdapter category: #'IS1-Showable-Adapter'!
ShowableModel subclass: #StudentToShowableAdapter
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!StudentToShowableAdapter methodsFor: 'initialization' stamp: 'HAW 5/8/2019 19:21:42'!
initializeAdapting: aStudent 
	
	adaptee := aStudent ! !


!StudentToShowableAdapter methodsFor: 'showing' stamp: 'HAW 5/8/2019 19:15:38'!
asShowable
	
	^adaptee lu ,': ', adaptee name ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StudentToShowableAdapter class' category: #'IS1-Showable-Adapter'!
StudentToShowableAdapter class
	instanceVariableNames: ''!

!StudentToShowableAdapter class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 19:21:23'!
adapting: aStudent 
	
	^self new initializeAdapting: aStudent ! !


!classDefinition: #Student category: #'IS1-Showable-Adapter'!
Object subclass: #Student
	instanceVariableNames: 'name lu'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!Student methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:59:31'!
initializeNamed: aName identifiedAs: aLU

	name := aName.
	lu := aLU ! !


!Student methodsFor: 'accessing' stamp: 'HAW 5/8/2019 19:02:21'!
lu

	^lu ! !

!Student methodsFor: 'accessing' stamp: 'HAW 5/8/2019 19:02:15'!
name

	^name ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Student class' category: #'IS1-Showable-Adapter'!
Student class
	instanceVariableNames: ''!

!Student class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:59:07'!
named: aName identifiedAs: aLU

	^self new initializeNamed: aName identifiedAs: aLU! !


!classDefinition: #TextField category: #'IS1-Showable-Adapter'!
Object subclass: #TextField
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-Adapter'!

!TextField methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:37:32'!
showUsing: aCanvas

	aCanvas show: model asShowable! !


!TextField methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:48:04'!
initializeShowing: aModel

	model := aModel ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TextField class' category: #'IS1-Showable-Adapter'!
TextField class
	instanceVariableNames: ''!

!TextField class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:47:46'!
showing: aModel

	^self new initializeShowing: aModel! !
