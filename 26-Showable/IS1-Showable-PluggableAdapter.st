!classDefinition: #TextFieldTest category: #'IS1-Showable-PluggableAdapter'!
TestCase subclass: #TextFieldTest
	instanceVariableNames: 'drawn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-PluggableAdapter'!

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 19:33:10'!
test01

	| juanPerez textField |
	
	juanPerez := Customer named: 'Juan' surnamed: 'Perez'.
	textField := TextField showing: (PluggableAdapter adapting: #asShowable with: [ juanPerez lastName, ', ', juanPerez firstName ]).
	
	textField showUsing: self.
	
	self assert: 'Perez, Juan' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 19:34:04'!
test02

	| paenza textField |
	
	paenza := Professor named: 'Paenza' teaches: 'Analisis I'.
	textField := TextField showing: (PluggableAdapter adapting: #asShowable with: [ paenza name, ' -> ', paenza subject ]).
	
	textField showUsing: self.
	
	self assert: 'Paenza -> Analisis I' equals: drawn! !

!TextFieldTest methodsFor: 'tests' stamp: 'HAW 5/8/2019 19:34:35'!
test03

	| roque textField |
	
	roque := Student named: 'Roque Sanchez' identifiedAs: '233/19'.
	textField := TextField showing: (PluggableAdapter adapting: #asShowable with: [ roque lu ,': ', roque name ]).
	
	textField showUsing: self.
	
	self assert: '233/19: Roque Sanchez' equals: drawn! !


!TextFieldTest methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:48:56'!
show: aShowable

	drawn := aShowable ! !


!classDefinition: #Customer category: #'IS1-Showable-PluggableAdapter'!
Object subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-PluggableAdapter'!

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

!classDefinition: 'Customer class' category: #'IS1-Showable-PluggableAdapter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:45:58'!
named: aFirstName surnamed: aLastName

	^self new initializeNamed: aFirstName surnamed: aLastName ! !


!classDefinition: #Professor category: #'IS1-Showable-PluggableAdapter'!
Object subclass: #Professor
	instanceVariableNames: 'name subject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-PluggableAdapter'!

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

!classDefinition: 'Professor class' category: #'IS1-Showable-PluggableAdapter'!
Professor class
	instanceVariableNames: ''!

!Professor class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:55:01'!
named: aName teaches: aSubject

	^self new initializeNamed: aName teaches: aSubject

	! !


!classDefinition: #Student category: #'IS1-Showable-PluggableAdapter'!
Object subclass: #Student
	instanceVariableNames: 'name lu'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-PluggableAdapter'!

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

!classDefinition: 'Student class' category: #'IS1-Showable-PluggableAdapter'!
Student class
	instanceVariableNames: ''!

!Student class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:59:07'!
named: aName identifiedAs: aLU

	^self new initializeNamed: aName identifiedAs: aLU! !


!classDefinition: #TextField category: #'IS1-Showable-PluggableAdapter'!
Object subclass: #TextField
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-PluggableAdapter'!

!TextField methodsFor: 'showing' stamp: 'HAW 5/8/2019 18:37:32'!
showUsing: aCanvas

	aCanvas show: model asShowable! !


!TextField methodsFor: 'initialization' stamp: 'HAW 5/8/2019 18:48:04'!
initializeShowing: aModel

	model := aModel ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TextField class' category: #'IS1-Showable-PluggableAdapter'!
TextField class
	instanceVariableNames: ''!

!TextField class methodsFor: 'instance creation' stamp: 'HAW 5/8/2019 18:47:46'!
showing: aModel

	^self new initializeShowing: aModel! !


!classDefinition: #PluggableAdapter category: #'IS1-Showable-PluggableAdapter'!
ProtoObject subclass: #PluggableAdapter
	instanceVariableNames: 'closureBySelectors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Showable-PluggableAdapter'!

!PluggableAdapter methodsFor: 'initialization' stamp: 'HAW 9/19/2017 08:40:10'!
initializeAdaptingAll: aClosureBySelectors

	closureBySelectors := aClosureBySelectors ! !


!PluggableAdapter methodsFor: 'message handling' stamp: 'HAW 9/19/2017 08:41:36'!
doesNotUnderstand: aMessage

	| adaptingClosure |
	
	adaptingClosure := closureBySelectors at: aMessage selector ifAbsent: [ ^ super doesNotUnderstand: aMessage ].
	^adaptingClosure value! !


!PluggableAdapter methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:47:06'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!PluggableAdapter methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:47:20'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PluggableAdapter class' category: #'IS1-Showable-PluggableAdapter'!
PluggableAdapter class
	instanceVariableNames: ''!

!PluggableAdapter class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 08:38:30'!
adapting: aSelector with: aClosure

	^self adaptingAll: (Dictionary new
		at: aSelector put: aClosure;
		yourself)! !

!PluggableAdapter class methodsFor: 'instance creation' stamp: 'HAW 9/19/2017 08:39:26'!
adaptingAll: aClosuresBySelectors

	^self new initializeAdaptingAll: aClosuresBySelectors ! !
