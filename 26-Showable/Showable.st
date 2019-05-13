!classDefinition: #TextFieldTest category: #'IS1-Showable'!
TestCase subclass: #TextFieldTest
	instanceVariableNames: 'drawn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!TextFieldTest methodsFor: 'tests' stamp: 'AB 5/13/2019 19:33:32'!
test01

	| juanPerez textField |
	
	juanPerez := Customer named: 'Juan' surnamed: 'Perez'.
	textField := TextField showing: (ShowableCustomer with: juanPerez).
	
	textField showUsing: self.
	
	self assert: 'Perez, Juan' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'AB 5/13/2019 19:39:00'!
test02

	| paenza textField |
	
	paenza := Professor named: 'Paenza' teaches: 'Analisis I'.
	textField := TextField showing: (ShowableProfessor with: paenza).
	
	textField showUsing: self.
	
	self assert: 'Paenza -> Analisis I' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'AB 5/13/2019 19:41:23'!
test03

	| roque textField |
	
	roque := Student named: 'Roque Sanchez' identifiedAs: '233/19'.
	textField := TextField showing: (ShowableStudent with: roque).
	
	textField showUsing: self.
	
	self assert: '233/19: Roque Sanchez' equals: drawn! !


!TextFieldTest methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:48:56'!
show: aShowable

	drawn := aShowable ! !


!classDefinition: #Customer category: #'IS1-Showable'!
Object subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!


!Customer methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:47:08'!
initializeNamed: aFirstName surnamed: aLastName 

	firstName := aFirstName.
	lastName := aLastName ! !

!Customer methodsFor: 'initialization' stamp: 'HAW 12/24/2018 10:38:48'!
initializeNamed: aFirstName with: aLastName bornOn: aDateOfBirth
	
	firstName := aFirstName. 
	lastName := aLastName.
	dateOfBirth := aDateOfBirth! !







!Customer methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:10'!
firstName

	^firstName ! !

!Customer methodsFor: 'accessing' stamp: 'HAW 5/8/2019 18:56:15'!
lastName

	^lastName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #'IS1-Showable'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:45:58'!
named: aFirstName surnamed: aLastName

	^self new initializeNamed: aFirstName surnamed: aLastName ! !

!Customer class methodsFor: 'instance creation' stamp: 'HAW 9/17/2018 12:09'!
named: aFirstName with: aLastName bornOn: aDateOfBirth	^self new initializeNamed: aFirstName with: aLastName bornOn: aDateOfBirth	! !


!classDefinition: #Professor category: #'IS1-Showable'!
Object subclass: #Professor
	instanceVariableNames: 'name subject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

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

!classDefinition: 'Professor class' category: #'IS1-Showable'!
Professor class
	instanceVariableNames: ''!

!Professor class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:55:01'!
named: aName teaches: aSubject

	^self new initializeNamed: aName teaches: aSubject

	! !


!classDefinition: #Showable category: #'IS1-Showable'!
Object subclass: #Showable
	instanceVariableNames: 'proxy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!Showable methodsFor: 'as yet unclassified' stamp: 'AB 5/13/2019 19:42:46'!
asShowable

	self subclassResponsibility ! !

!Showable methodsFor: 'as yet unclassified' stamp: 'AB 5/13/2019 19:46:23'!
initializeWith: somethingShowable

	proxy _ somethingShowable! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Showable class' category: #'IS1-Showable'!
Showable class
	instanceVariableNames: ''!

!Showable class methodsFor: 'as yet unclassified' stamp: 'AB 5/13/2019 19:48:57'!
with: aShowableSomething

	^ self new initializeWith: aShowableSomething ! !


!classDefinition: #ShowableCustomer category: #'IS1-Showable'!
Showable subclass: #ShowableCustomer
	instanceVariableNames: 'customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!ShowableCustomer methodsFor: 'as yet unclassified' stamp: 'AB 5/13/2019 19:46:48'!
asShowable

	^ proxy lastName , ', ' , proxy firstName ! !


!classDefinition: #ShowableProfessor category: #'IS1-Showable'!
Showable subclass: #ShowableProfessor
	instanceVariableNames: 'professor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!ShowableProfessor methodsFor: 'as yet unclassified' stamp: 'AB 5/13/2019 19:46:59'!
asShowable

	^ proxy name , ' -> ' , proxy subject! !


!classDefinition: #ShowableStudent category: #'IS1-Showable'!
Showable subclass: #ShowableStudent
	instanceVariableNames: 'student'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!ShowableStudent methodsFor: 'as yet unclassified' stamp: 'AB 5/13/2019 19:47:14'!
asShowable

	^ proxy lu , ': ' , proxy name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShowableStudent class' category: #'IS1-Showable'!
ShowableStudent class
	instanceVariableNames: 'student'!


!classDefinition: #Student category: #'IS1-Showable'!
Object subclass: #Student
	instanceVariableNames: 'name lu'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

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

!classDefinition: 'Student class' category: #'IS1-Showable'!
Student class
	instanceVariableNames: ''!

!Student class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:59:07'!
named: aName identifiedAs: aLU

	^self new initializeNamed: aName identifiedAs: aLU! !


!classDefinition: #TextField category: #'IS1-Showable'!
Object subclass: #TextField
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable'!

!TextField methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:37:32'!
showUsing: aCanvas

	aCanvas show: model asShowable! !


!TextField methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:48:04'!
initializeShowing: aModel

	model := aModel ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TextField class' category: #'IS1-Showable'!
TextField class
	instanceVariableNames: ''!

!TextField class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:47:46'!
showing: aModel

	^self new initializeShowing: aModel! !
