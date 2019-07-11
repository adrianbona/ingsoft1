'From Cuis 5.0 of 7 November 2016 [latest update: #3813] on 10 July 2019 at 3:30:30 pm'!
!classDefinition: #PolymorphicFuture category: #'Ingsoft-IntegerReports'!
ProtoObject subclass: #PolymorphicFuture
	instanceVariableNames: 'readySemaphore value ready'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!PolymorphicFuture methodsFor: 'initialization' stamp: 'HAW 7/10/2019 15:25:37'!
initializeOf: aBlock

	readySemaphore := Semaphore new.
	ready := false.
	
	[ value := aBlock value.
	ready := true.
	readySemaphore signal ] fork.
	! !


!PolymorphicFuture methodsFor: 'evaluating' stamp: 'HAW 7/10/2019 15:25:49'!
value

	ready ifFalse: [ readySemaphore wait ].
	^value! !


!PolymorphicFuture methodsFor: 'message forwarding' stamp: 'HernanWilkinson 9/13/2016 19:03'!
doesNotUnderstand: aMessage

	^aMessage sendTo: self value ! !


!PolymorphicFuture methodsFor: 'object protocol' stamp: 'HAW 8/13/2017 18:12:56'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!PolymorphicFuture methodsFor: 'object protocol' stamp: 'HAW 5/12/2019 19:41:48'!
instVarAt: index
	"Primitive. Answer a fixed variable in an object. The numbering of the variables
	 corresponds to the named instance variables, followed by the indexed instance
	 variables. Fail if the index is not an Integer or is not the index of a fixed variable.
	 Essential. See Object documentation whatIsAPrimitive."

	<primitive: 173 error: ec>
	"The classic InterpreterVMs don't support primitives 173 and 174.
	See http://forum.world.st/Some-test-where-Spur-more-slow-than-Cog-td4867810.html#a4867888
	Use primitives 73 and 74 in such case."
	Smalltalk isRunningCog ifFalse: [
		^ self instVarAtPrim73: index ].
	self primitiveFailed! !

!PolymorphicFuture methodsFor: 'object protocol' stamp: 'HAW 8/13/2017 18:12:37'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PolymorphicFuture class' category: #'Ingsoft-IntegerReports'!
PolymorphicFuture class
	instanceVariableNames: ''!

!PolymorphicFuture class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:37:15'!
of: aBlock

	 ^self new initializeOf: aBlock! !
