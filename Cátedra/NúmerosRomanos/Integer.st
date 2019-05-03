'From Cuis 5.0 of 7 November 2016 [latest update: #3690] on 3 May 2019 at 10:16:34 am'!
!classDefinition: #Integer category: #'Kernel-Numbers'!
Number subclass: #Integer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Kernel-Numbers'!
!Integer commentStamp: '<historical>' prior: 0!
I am a common abstract superclass for all Integer implementations. My implementation subclasses are SmallInteger, LargePositiveInteger, and LargeNegativeInteger.
	
Integer division consists of:
	/	exact division, answers a fraction if result is not a whole integer
	//	answers an Integer, rounded towards negative infinity
	\\	is modulo rounded towards negative infinity
	quo: truncated division, rounded towards zero!


!Integer methodsFor: 'arithmetic' stamp: 'jmv 12/24/2011 08:43'!
* aNumber
	"Refer to the comment in Number * " 
	aNumber isInteger ifTrue: [
		^ self
			digitMultiply: aNumber
			neg: (self negative xor: aNumber negative) ].
	^ aNumber adaptToInteger: self andSend: #*! !

!Integer methodsFor: 'arithmetic' stamp: 'di 11/6/1998 13:59'!
+ aNumber
	"Refer to the comment in Number + "
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [^ (self digitAdd: aNumber) normalize]
			ifFalse: [^ self digitSubtract: aNumber]].
	^ aNumber adaptToInteger: self andSend: #+! !

!Integer methodsFor: 'arithmetic' stamp: 'di 11/6/1998 13:59'!
- aNumber
	"Refer to the comment in Number - "
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [^ self digitSubtract: aNumber]
			ifFalse: [^ (self digitAdd: aNumber) normalize]].
	^ aNumber adaptToInteger: self andSend: #-! !

!Integer methodsFor: 'arithmetic' stamp: 'di 11/6/1998 14:00'!
/ aNumber
	"Refer to the comment in Number / "
	| quoRem |
	aNumber isInteger ifTrue:
		[quoRem _ self digitDiv: aNumber abs	"*****I've added abs here*****"
						neg: self negative ~~ aNumber negative.
		(quoRem at: 2) = 0
			ifTrue: [^ (quoRem at: 1) normalize]
			ifFalse: [^ (Fraction numerator: self denominator: aNumber) reduced]].
	^ aNumber adaptToInteger: self andSend: #/! !

!Integer methodsFor: 'arithmetic' stamp: 'jmv 11/10/2014 23:22'!
// aNumber 
	| q |
	aNumber = 0 ifTrue: [^ (ZeroDivide dividend: self) signal].
	self = 0 ifTrue: [^ 0].
	q _ self quo: aNumber.
	"Refer to the comment in Number>>#//."
	^(q negative
		ifTrue: [q * aNumber ~= self]
		ifFalse: [q = 0 and: [self negative ~= aNumber negative]])
			ifTrue: [q - 1"Truncate towards minus infinity."]
			ifFalse: [q]! !

!Integer methodsFor: 'arithmetic' stamp: 'bf 9/25/2008 15:13'!
\\\ anInteger 
	"a modulo method for use in DSA. Be careful if you try to use this elsewhere."

	^self \\ anInteger! !

!Integer methodsFor: 'arithmetic'!
alignedTo: anInteger
	"Answer the smallest number not less than receiver that is a multiple of anInteger."

	^(self+anInteger-1//anInteger)*anInteger

"5 alignedTo: 2"
"12 alignedTo: 3"! !

!Integer methodsFor: 'arithmetic' stamp: 'mga 5/11/2006 15:42'!
crossSumBase: aBase
	|aResult|
	"Precondition"
	self assert:[aBase isInteger and: [aBase >=2]].

	self < 0 ifTrue: [^self negated crossSumBase: aBase].
	self < aBase ifTrue: [^ self].
	aResult := self \\ aBase + (self // aBase crossSumBase: aBase).

	"Postcondition
	E.g. 18 crossSumBase: 10 -> 9 => 18\\(10-1) = 0"
	self assert: [((aResult \\ (aBase - 1) = 0)) = ((self \\ (aBase - 1)) =0)].
	^aResult! !

!Integer methodsFor: 'arithmetic' stamp: 'LC 6/17/1998 19:22'!
gcd: anInteger
	"See Knuth, Vol 2, 4.5.2, Algorithm L"
	"Initialize"
	| higher u v k uHat vHat a b c d vPrime vPrimePrime q t |
	higher _ SmallInteger maxVal highBit.
	u _ self abs max: (v _ anInteger abs).
	v _ self abs min: v.
	[v class == SmallInteger]
		whileFalse: 
			[(uHat _ u bitShift: (k _ higher - u highBit)) class == SmallInteger
				ifFalse: 
					[k _ k - 1.
					uHat _ uHat bitShift: -1].
			vHat _ v bitShift: k.
			a _ 1.
			b _ 0.
			c _ 0.
			d _ 1.
			"Test quotient"
			[(vPrime _ vHat + d) ~= 0
				and: [(vPrimePrime _ vHat + c) ~= 0 and: [(q _ uHat + a // vPrimePrime) = (uHat + b // vPrime)]]]
				whileTrue: 
					["Emulate Euclid"
					c _ a - (q * (a _ c)).
					d _ b - (q * (b _ d)).
					vHat _ uHat - (q * (uHat _ vHat))].
			"Multiprecision step"
			b = 0
				ifTrue: 
					[v _ u rem: (u _ v)]
				ifFalse: 
					[t _ u * a + (v * b).
					v _ u * c + (v * d).
					u _ t]].
	^ v gcd: u! !

!Integer methodsFor: 'arithmetic' stamp: 'di 11/6/1998 14:00'!
quo: aNumber 
	"Refer to the comment in Number quo: "
	| ng quo |
	aNumber isInteger ifTrue: 
		[ng _ self negative == aNumber negative == false.
		quo _ (self digitDiv:
			(aNumber class == SmallInteger
				ifTrue: [aNumber abs]
				ifFalse: [aNumber])
			neg: ng) at: 1.
		^ quo normalize].
	^ aNumber adaptToInteger: self andSend: #quo:! !

!Integer methodsFor: 'arithmetic' stamp: 'len 12/4/2016 13:11:44'!
reciprocalModulo2: n
	"Answer an integer x such that self * x \\ n = 1, with 0 < x < n, or nil if it doesn't exist."
	| xgcd |
	self == 0 ifTrue: [^ nil].
	self == 1 ifTrue: [^ 1].
	xgcd _ self xgcd: n.
	^ (xgcd at: 1) == 1 ifTrue: [^ (xgcd at: 2) \\ n]! !

!Integer methodsFor: 'arithmetic' stamp: 'sqr 1/14/2014 01:30'!
reciprocalModulo: mod
	"Answer an integer x such that self * x \\ n = 1, with 0 < x < n, or nil if x does not exist.
	The algorithm is a non extended euclidean modular inversion called NINV.
	It is described in this article:
		'Using an RSA Accelerator for Modular Inversion'
	by Martin Seysen. See http://www.iacr.org/archive/ches2005/017.pdf"

	| receiver u v f fPlusN b result result2 |
	mod > 1 ifFalse: [^nil].
	receiver := (self >= mod or: [self < 0])
		ifTrue: [self \\ mod] ifFalse: [self].
	b := mod highBit + 1.
	f := 1 bitShift: b.
	v := (receiver bitShift: b) + 1.
	u := mod bitShift: b.
	fPlusN := f + mod.
	[v >= fPlusN] whileTrue:
		[v := u \\\ (u := v)].
	result := v - f.
	result2 := result + mod.
	result2 > 0 ifFalse: [^nil].
	^result positive
		ifTrue: [result]
		ifFalse: [result2]! !

!Integer methodsFor: 'arithmetic' stamp: 'len 12/4/2016 13:07:08'!
xgcd: anInteger
	"Extended Euclidean algorithm.
	Answer an array {x. u. v} where self * u + (anInteger * v) = x, and x = (self gcd: anInteger)."
	| a b s t sp tp r rp |
	a _ self. b _ anInteger.
	s _ 0. sp _ 1.
	t _ 1. tp _ 0.
	r _ a abs. rp _ b abs.
	[r == 0]
		whileFalse:
			[ | q temp |
			q _ rp // r.
			temp _ r. r _ rp - (q * r). rp _ temp.
			temp _ s. s _ sp - (q * s). sp _ temp.
			temp _ t. t _ tp - (q * t). tp _ temp].
	sp _ sp * b sign. tp _ tp * a sign.
	^ {rp. tp. sp}! !


!Integer methodsFor: 'benchmarks' stamp: 'jm 11/20/1998 07:06'!
benchFib  "Handy send-heavy benchmark"
	"(result // seconds to run) = approx calls per second"
	" | r t |
	  t _ Time millisecondsToRun: [r _ 26 benchFib].
	  (r * 1000) // t"
	"138000 on a Mac 8100/100"
	^ self < 2
		ifTrue: [1] 
		ifFalse: [(self-1) benchFib + (self-2) benchFib + 1]
! !

!Integer methodsFor: 'benchmarks' stamp: 'di 4/11/1999 11:20'!
benchmark  "Handy bytecode-heavy benchmark"
	"(500000 // time to run) = approx bytecodes per second"
	"5000000 // (Time millisecondsToRun: [10 benchmark]) * 1000"
	"3059000 on a Mac 8100/100"
    | size flags prime k count |
    size _ 8190.
    1 to: self do:
        [:iter |
        count _ 0.
        flags _ (Array new: size) atAllPut: true.
        1 to: size do:
            [:i | (flags at: i) ifTrue:
                [prime _ i+1.
                k _ i + prime.
                [k <= size] whileTrue:
                    [flags at: k put: false.
                    k _ k + prime].
                count _ count + 1]]].
    ^ count! !

!Integer methodsFor: 'benchmarks' stamp: 'jmv 3/4/2018 12:44:36'!
tinyBenchmarks
	"Report the results of running the two tiny Squeak benchmarks.
	ar 9/10/1999: Adjusted to run at least 1 sec to get more stable results


	Performance of early 80's experimental Smalltalk systems.
	Estimations from
		http://wiki.c2.com/?GreenBook
		http://www.wirfs-brock.com/allen/things/smalltalk-things/tektronix-smalltalk-document-archive/1982-qtr4-magnolia-perf-graph.pdf
		http://www.wirfs-brock.com/allen/things/smalltalk-things/tektronix-smalltalk-document-archive/1983-Magnolia-st-perf.pdf

		DEC PDP-11/23 											  5,000 bytecodes/sec (Green Book, p.128)
		Apple 5MHz 68000 							   9,000 to 11,000 bytecodes/sec (Green Book, p.187, awb) 							5000 clocks/bytecode
		VAX-11/780 5MHz C HP Smalltalk 		  5,000 to 25,000 bytecodes/sec (Green Book, p.235) 								  330 clocks/bytecode
		VAX-11/780 5MHz C Berkeley Smalltalk 	 12,000 to 23000 bytecodes/sec (Green Book, p.203, awb) 							  300 clocks/bytecode
		DEC VAX-11/780 5MHz assembly 			20,000 to 25,000 bytecodes/sec (Green Book, p.149, awb) 				 			  200 clocks/bytecode
		Xerox Dolphin  µcode 					 	20,000 to 40,000 bytecodes/sec (Green Book, p.44, p.203, awb)
		TEK Magnolia 10MHz 68000 						      50,000 bytecodes/sec (awb) 												  200 clocks/bytecode
		Xerox Dorado 14MHz µcode			 400,000 to 500,000 bytecodes/sec (Green book, p.44, p.203, awb) 					    28 clocks/bytecode


	0 tinyBenchmarks
		
		292 MHz G3 Mac: 				        			 22,727,272 bytecodes/sec; 			    984,169 sends/sec 					12.8 clocks/bytecode
		400 MHz PII/Win98:  			        			 18,028,169 bytecodes/sec; 			1,081,272 sends/sec 					22.2 clocks/bytecode

		900MHz RasPi2 - StackVM: 						 37,758,112 bytecodes/sec; 		       2,412,667 sends/sec 					16.2 clocks/bytecode
		900MHz RasPi2- CogSSpur: 				     157,441,574 bytecodes/sec; 		     10,946,039 sends/sec 					   5.7 clocks/bytecode
		
		1GHz C.H.I.P. (*1) - StackVM: 					55,315,471 bytecodes/sec;  			3,348,667 sends/sec  					18.1 clocks/bytecode
		1GHz C.H.I.P. (*1) - CogSpur: 			 	    253,716,551 bytecodes/sec; 		    16,853,816 sends/sec 					   3.9 clocks/bytecode
		
		1.2GHz RasPi3B - StackSpur 					44,107,512 bytecodes/sec; 			2,767,863 sends/sec 					27.2 clocks/bytecode
		1.2GHz RasPi3B - CogSpur 					    281,783,159 bytecodes/sec; 		    16,404,381 sends/sec 					   6.6 clocks/bytecode

		1.66GHz Atom N450 - Cog: 					     244,274,809 bytecodes/sec; 		    28,795,277 sends/sec 					   6.8 clocks/bytecode
		1.66GHz Atom N450 - CogSpur: 			     469,724,770 bytecodes/sec; 		    30,754,699 sends/sec 					   3.5 clocks/bytecode
 
		1.33GHz Atom 3735G - Cog: 				     326,114,649 bytecodes/sec; 		    34,985,976 sends/sec 					   4.1 clocks/bytecode
		1.33GHz Atom 3735G - CogSpur: 			     632,098,765 bytecodes/sec; 		    33,692,910 sends/sec 					   2.1 clocks/bytecode

		1.5GHz AMD A4-5000 APU - Cog: 			    390,243,902 bytecodes/sec; 		    47,507,997 sends/sec 					   3.8 clocks/bytecode
		1.5GHz AMD A4-5000 APU - CogSpur: 		    675,907,590 bytecodes/sec; 		    40,669,724 sends/sec 					   2.2 clocks/bytecode
		1.5GHz AMD A4-5000 APU - CogSpur64:	    659,368,963 bytecodes/sec; 		    50,338,916 sends/sec 					   2.2 clocks/bytecode

		2.3GHz Tegra (*2) - StackVM: 				    258,847,320 bytecodes/sec; 		    13,014,759 sends/sec					   8.9 clocks/bytecode
		2.3GHz Tegra (*2) - CogSpur: 				1,083,024,854 bytecodes/sec; 		    64,289,750 sends/sec 					   2.1 clocks/bytecode

		3.1GHz Core i3-2100 - Cog:  				1,203,290,246 bytecodes/sec; 		165,723,327 sends/sec 					   2.6 clocks/bytecode
		3.1GHz Core i3-2100 - CogSpur:  			2,042,892,768 bytecodes/sec; 		127,837,794 sends/sec 					   1.5 clocks/bytecode

		2.70GHz Core i5-6400 -CogSpur64 		3,162,934,362 bytecodes/sec; 		243,321,293 sends/sec 					   0.85 clocks/bytecode
	
		(*1) C.H.I.P. $9 Computer [Next Thing Co], Allwinner R8 Single-Core ARM Cortex-A8 - 1 GHz
		(*2) ACER Chromebook CB5-311 - NVIDIA Tegra K1 Quad-Core ARM Cortex-A15 'r3'  - 2.3 GHz
		
	It is interesting to note that Spur for the first time brings ARM hardware (RasPi and C.H.I.P.) into a 'Morphic is confortable and nice to use' level of performance.
	"
	| t1 t2 r n1 n2 |
	n1 _ 1.
	[
		t1 _ Time millisecondsToRun: [n1 benchmark].
		t1 < 1000] 
			whileTrue: [n1 _ n1 * 2]. "Note: #benchmark's runtime is about O(n)"

	n2 _ 28.
	[
		t2 _ Time millisecondsToRun: [r _ n2 benchFib].
		t2 < 1000] 
			whileTrue: [n2 _ n2 + 1]. 
	"Note: #benchFib's runtime is about O(k^n),
		where k is the golden number = (1 + 5 sqrt) / 2 = 1.618...."

	^String streamContents: [ :strm |
		(n1 * 500000 * 1000) // t1 withDecimalUnitPrefixAndValue: [ :value  :unitPrefixSymbol :unitPrefixName |
			value printOn: strm fractionDigits: 2.
			strm
				space;
				nextPutAll: unitPrefixName;
				nextPutAll: 'Bytecodes/second; ' ].
		(r * 1000) // t2 withDecimalUnitPrefixAndValue: [ :value  :unitPrefixSymbol :unitPrefixName |
			value printOn: strm fractionDigits: 2.
			strm
				space;
				nextPutAll: unitPrefixName;
				nextPutAll: 'Sends/second' ]]! !


!Integer methodsFor: 'bit manipulation'!
<< shiftAmount  "left shift"
	shiftAmount < 0 ifTrue: [self error: 'negative arg'].
	^ self bitShift: shiftAmount! !

!Integer methodsFor: 'bit manipulation' stamp: 'jmv 5/7/2012 15:09'!
>> shiftAmount  "right shift"
	shiftAmount < 0 ifTrue: [self error: 'negative arg'].
	^ self bitShift: shiftAmount negated! !

!Integer methodsFor: 'bit manipulation'!
allMask: mask 
	"Treat the argument as a bit mask. Answer whether all of the bits that 
	are 1 in the argument are 1 in the receiver."

	^mask = (self bitAnd: mask)! !

!Integer methodsFor: 'bit manipulation' stamp: 'sr 11/29/2000 14:32'!
anyBitOfMagnitudeFrom: start to: stopArg 
	"Tests for any magnitude bits in the interval from start to stopArg."
	"Primitive fixed in LargeIntegers v1.2. If you have an earlier version 
	comment out the primitive call (using this ST method then)."
	| magnitude firstDigitIx lastDigitIx rightShift leftShift stop |
	<primitive: 'primAnyBitFromTo' module:'LargeIntegers'>
	start < 1 | (stopArg < 1)
		ifTrue: [^ self error: 'out of range'].
	magnitude _ self abs.
	stop _ stopArg min: magnitude highBit.
	start > stop
		ifTrue: [^ false].
	firstDigitIx _ start - 1 // 8 + 1.
	lastDigitIx _ stop - 1 // 8 + 1.
	rightShift _ (start - 1 \\ 8) negated.
	leftShift _ 7 - (stop - 1 \\ 8).
	firstDigitIx = lastDigitIx
		ifTrue: [| digit mask | 
			mask _ (255 bitShift: rightShift negated)
						bitAnd: (255 bitShift: leftShift negated).
			digit _ magnitude digitAt: firstDigitIx.
			^ (digit bitAnd: mask)
				~= 0].
	((magnitude digitAt: firstDigitIx)
			bitShift: rightShift)
			~= 0
		ifTrue: [^ true].
	firstDigitIx + 1
		to: lastDigitIx - 1
		do: [:ix | (magnitude digitAt: ix)
					~= 0
				ifTrue: [^ true]].
	(((magnitude digitAt: lastDigitIx)
			bitShift: leftShift)
			bitAnd: 255)
			~= 0
		ifTrue: [^ true].
	^ false! !

!Integer methodsFor: 'bit manipulation'!
anyMask: mask 
	"Treat the argument as a bit mask. Answer whether any of the bits that 
	are 1 in the argument are 1 in the receiver."

	^0 ~= (self bitAnd: mask)! !

!Integer methodsFor: 'bit manipulation' stamp: 'sr 3/13/2000 17:47'!
bitAnd: n 
	"Answer an Integer whose bits are the logical AND of the receiver's bits  
	and those of the argument, n."
	| norm |
	<primitive: 'primDigitBitAnd' module:'LargeIntegers'>
	norm _ n normalize.
	^ self
		digitLogic: norm
		op: #bitAnd:
		length: (self digitLength max: norm digitLength)! !

!Integer methodsFor: 'bit manipulation' stamp: 'nice 3/21/2008 21:47'!
bitAt: anInteger
	"Answer 1 if the bit at position anInteger is set to 1, 0 otherwise.
	self is considered an infinite sequence of bits, so anInteger can be any strictly positive integer.
	Bit at position 1 is the least significant bit.
	Negative numbers are in two-complements.
	
	This is a naive implementation that can be refined in subclass for speed"
	
	^(self bitShift: 1 - anInteger) bitAnd: 1! !

!Integer methodsFor: 'bit manipulation' stamp: 'nice 2/16/2010 10:07'!
bitAt: anInteger put: value
	"Answer a new Integer that has the bit of rank anInteger set to value.
	The bit value should be 0 or 1, otherwise raise an Error.
	The bits are indexed starting at 1 for the least significant bit.
	For negative integers, operate on 2-complement representation."
	
	| b |
	b := self bitAt: anInteger.
	b = value ifTrue: [^self].
	0 = value ifTrue: [^self bitAnd: (1 bitShift: anInteger - 1) bitInvert].
	1 = value ifTrue: [^self bitOr: (1 bitShift: anInteger - 1)].
	self error: 'bit value should be 0 or 1'! !

!Integer methodsFor: 'bit manipulation' stamp: 'di 4/30/1998 10:32'!
bitClear: aMask 
	"Answer an Integer equal to the receiver, except with all bits cleared that are set in aMask."

	^ (self bitOr: aMask) - aMask! !

!Integer methodsFor: 'bit manipulation' stamp: 'tak 9/25/2008 15:17'!
bitInvert
	"Answer an Integer whose bits are the logical negation of the receiver's bits.
	Numbers are interpreted as having 2's-complement representation."

	^ -1 - self.! !

!Integer methodsFor: 'bit manipulation' stamp: 'jmv 2/22/2013 22:48'!
bitInvert16
	"Answer the 16-bit complement of the receiver."

	^ self bitXor: 16rFFFF! !

!Integer methodsFor: 'bit manipulation'!
bitInvert32
	"Answer the 32-bit complement of the receiver."

	^ self bitXor: 16rFFFFFFFF! !

!Integer methodsFor: 'bit manipulation' stamp: 'sr 3/13/2000 17:47'!
bitOr: n 
	"Answer an Integer whose bits are the logical OR of the receiver's bits  
	and those of the argument, n."
	| norm |
	<primitive: 'primDigitBitOr' module:'LargeIntegers'>
	norm _ n normalize.
	^ self
		digitLogic: norm
		op: #bitOr:
		length: (self digitLength max: norm digitLength)! !

!Integer methodsFor: 'bit manipulation' stamp: 'jmv 8/6/2011 23:40'!
bitReverse: highBit 
	"Reverse the bits of the receiver so that the lsb is the highBit'th bit of the answer.  Translated from C code at:  http://graphics.stanford.edu/~seander/bithacks.html#BitReverseObvious."
	| v r s |
	highBit < self highBit ifTrue: [ self error: 'Not enough bits.' ].
	v := self.
	r := v bitAnd: 1.
	s := highBit - 1.
	[ v := v bitShift: -1.
	v = 0 ] whileFalse:
		[ r := r bitShift: 1.
		r := r bitOr: (v bitAnd: 1).
		s := s - 1 ].
	^ r bitShift: s! !

!Integer methodsFor: 'bit manipulation' stamp: 'sr 6/9/2000 10:09'!
bitShift: shiftCount 
	"Answer an Integer whose value (in twos-complement representation) is  
	the receiver's value (in twos-complement representation) shifted left by 
	the number of bits indicated by the argument. Negative arguments  
	shift right. Zeros are shifted in from the right in left shifts."
	| magnitudeShift |
	magnitudeShift _ self bitShiftMagnitude: shiftCount.
	^ ((self negative and: [shiftCount negative])
		and: [self anyBitOfMagnitudeFrom: 1 to: shiftCount negated])
		ifTrue: [magnitudeShift - 1]
		ifFalse: [magnitudeShift]! !

!Integer methodsFor: 'bit manipulation' stamp: 'sr 6/9/2000 14:02'!
bitShiftMagnitude: shiftCount 
	"Answer an Integer whose value (in magnitude representation) is  
	the receiver's value (in magnitude representation) shifted left by  
	the number of bits indicated by the argument. Negative arguments
	shift right. Zeros are shifted in from the right in left shifts."
	| rShift |
	<primitive: 'primDigitBitShiftMagnitude' module:'LargeIntegers'>
	shiftCount >= 0 ifTrue: [^ self digitLshift: shiftCount].
	rShift _ 0 - shiftCount.
	^ (self
		digitRshift: (rShift bitAnd: 7)
		bytes: (rShift bitShift: -3)
		lookfirst: self digitLength) normalize! !

!Integer methodsFor: 'bit manipulation' stamp: 'sr 3/13/2000 17:47'!
bitXor: n 
	"Answer an Integer whose bits are the logical XOR of the receiver's bits  
	and those of the argument, n."
	| norm |
	<primitive: 'primDigitBitXor' module:'LargeIntegers'>
	norm _ n normalize.
	^ self
		digitLogic: norm
		op: #bitXor:
		length: (self digitLength max: norm digitLength)! !

!Integer methodsFor: 'bit manipulation' stamp: 'sqr 1/26/2014 13:38'!
highBit
	"Answer the index of the high order bit of the receiver, or zero if the  
	receiver is zero. Raise an error if the receiver is negative, since  
	negative integers are defined to have an infinite number of leading 1's 
	in 2's-complement arithmetic. Use >>highBitOfMagnitude if you want to 
	get the highest bit of the magnitude."
	self < 0 ifTrue: [^ self error: 'highBit is not defined for negative integers'].
	^ self highBitOfMagnitude! !

!Integer methodsFor: 'bit manipulation' stamp: 'jmv 12/4/2018 11:59:58'!
highBitOfMagnitude
	"Answer the position of the leading bit or zero if the  
	receiver is zero. Receiver has to be positive!!"

	| shifted bitNo |
	shifted := self < 0 ifTrue: [0 - self] ifFalse: [self].
	bitNo := 0.
	[shifted < 65536]
		whileFalse: 
			[shifted := shifted bitShift: -16.
			bitNo := bitNo + 16].
	shifted < 256
		ifFalse: 
			[shifted := shifted bitShift: -8.
			bitNo := bitNo + 8].
		
	"The high bits table can be obtained with:
	(1 to: 8) inject: #[0] into: [:highBits :rank | highBits , (highBits collect: [:e | rank])]."
	^bitNo + ( #[0 1 2 2 3 3 3 3 4 4 4 4 4 4 4 4 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8] at: shifted + 1)! !

!Integer methodsFor: 'bit manipulation' stamp: 'jmv 12/10/2018 18:36:21'!
lowBit
	"Answer the index of the low order bit of this number"

	| byte byteIndex byteSize |
	byteIndex _ 1.
	byteSize _ self digitLength.
	[ byteIndex <= byteSize ] whileTrue: [
		byte _ self at: byteIndex.
		byte > 0 ifTrue: [ ^ byteIndex - 1 * 8 + byte lowBit ].
		byteIndex _ byteIndex + 1 ].
	^ 0.! !

!Integer methodsFor: 'bit manipulation'!
noMask: mask 
	"Treat the argument as a bit mask. Answer whether none of the bits that 
	are 1 in the argument are 1 in the receiver."

	^0 = (self bitAnd: mask)! !


!Integer methodsFor: 'comparing' stamp: 'di 11/6/1998 14:00'!
< aNumber
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [self negative
						ifTrue: [^ (self digitCompare: aNumber) > 0]
						ifFalse: [^ (self digitCompare: aNumber) < 0]]
			ifFalse: [^ self negative]].
	^ aNumber adaptToInteger: self andSend: #<! !

!Integer methodsFor: 'comparing' stamp: 'jmv 9/1/2010 10:19'!
<= aNumber
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [self negative
						ifTrue: [^ (self digitCompare: aNumber) >= 0]
						ifFalse: [^ (self digitCompare: aNumber) <= 0]]
			ifFalse: [^ self negative]].
	^ aNumber adaptToInteger: self andSend: #<=! !

!Integer methodsFor: 'comparing' stamp: 'jmv 5/27/2014 11:04'!
= aNumber

	"Any object is equal to itself"
	self == aNumber ifTrue: [ ^ true ].

	aNumber isNumber ifFalse: [^ false].
	aNumber isInteger ifTrue: [
		aNumber class == self class ifFalse: [ ^false ].
		^ (self digitCompare: aNumber) = 0].
	^ aNumber adaptToInteger: self andSend: #=! !

!Integer methodsFor: 'comparing' stamp: 'di 11/6/1998 14:00'!
> aNumber
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [self negative
						ifTrue: [^(self digitCompare: aNumber) < 0]
						ifFalse: [^(self digitCompare: aNumber) > 0]]
			ifFalse: [^ aNumber negative]].
	^ aNumber adaptToInteger: self andSend: #>! !

!Integer methodsFor: 'comparing' stamp: 'jmv 9/1/2010 10:19'!
>= aNumber
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [self negative
						ifTrue: [^(self digitCompare: aNumber) <= 0]
						ifFalse: [^(self digitCompare: aNumber) >= 0]]
			ifFalse: [^ aNumber negative]].
	^ aNumber adaptToInteger: self andSend: #>=! !

!Integer methodsFor: 'comparing' stamp: 'jmv 10/18/2018 09:48:12'!
hash
	"Hash is reimplemented because = is implemented.
	| s |
	s _ (1 to: 10000) asSet.
	[s includes: 123456] bench
	"

	"Can only happen in 64 bits images...
	See Float>>#hash, LargePositiveInteger>>#hash and LargeNegativeInteger>>#hash"
	self abs < Float maxExactInteger ifFalse: [
		^ self asFloat hash ].

	"In 32 bit image it will always go this way"
	^self hashMultiply! !


!Integer methodsFor: 'converting' stamp: 'di 11/6/1998 13:43'!
adaptToFraction: rcvr andSend: selector
	"If I am involved in arithmetic with a Fraction, convert me to a Fraction."
	^ rcvr perform: selector with: self asFraction! !

!Integer methodsFor: 'converting' stamp: 'jmv 8/11/2016 10:04:41'!
asCharacter
	"Answer the Character whose value is the receiver."

	^Character numericValue: self! !

!Integer methodsFor: 'converting' stamp: 'ar 10/31/1998 23:04'!
asColorOfDepth: d
	"Return a color value representing the receiver as color of the given depth"
	^Color colorFromPixelValue: self depth: d! !

!Integer methodsFor: 'converting' stamp: 'nice 9/22/2011 01:39'!
asFloat
	"Answer a Float that best approximates the value of the receiver."
	
	self subclassResponsibility! !

!Integer methodsFor: 'converting' stamp: 'MarcusDenker 12/2/2009 12:54'!
asFraction
	"Answer a Fraction that represents the value of the receiver."

	^Fraction numerator: self denominator: 1! !

!Integer methodsFor: 'converting' stamp: 'ls 5/26/1998 20:53'!
asHexDigit
	^'0123456789ABCDEF' at: self+1! !

!Integer methodsFor: 'converting'!
asInteger
	"Answer with the receiver itself."

	^self

! !

!Integer methodsFor: 'converting' stamp: 'jmv 9/1/2010 10:43'!
asIntegerOrFloat
	"Convert to integer if integer, or to Float otherwhise."

	^self! !


!Integer methodsFor: 'enumerating'!
timesRepeat: aBlock 
	"Evaluate the argument, aBlock, the number of times represented by the 
	receiver."

	| count |
	count _ 1.
	[count <= self]
		whileTrue: 
			[aBlock value.
			count _ count + 1]! !


!Integer methodsFor: 'inspecting' stamp: 'jmv 11/1/2011 23:08'!
explorerContents

	^#(
		('hexadecimal' 16)
		('octal' 8)
		('binary' 2)) collect: [ :each |
			ObjectExplorerWrapper
				with: each first
				name: (self printStringBase: each second)
				model: self ]! !

!Integer methodsFor: 'inspecting' stamp: 'jmv 11/1/2011 23:10'!
hasContentsInExplorer
	^true! !


!Integer methodsFor: 'intervals' stamp: 'jmv 10/13/2007 08:55'!
integersTo: stop count: n
	"Answer an interval, up to stop, with n elements. All the elements will be integers."
	
	^Interval integersFrom: self to: stop count: n! !


!Integer methodsFor: 'mathematical functions' stamp: 'sqr 12/12/2013 10:37'!
factorial

	self < 0 ifTrue: [self error: 'Undefined for negative integers'].
	^1 productTo: self! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 8/30/2016 09:47:35'!
floatLog
	"Float, even if Integer result possible"
	| res h |
	res := super log.
	res isFinite ifTrue: [^res].
	h := self highBit.
	^2 log * h + (self / (1 << h)) asFloat log! !

!Integer methodsFor: 'mathematical functions' stamp: 'nice 4/25/2018 09:43'!
floorLog: radix
	"Unlike super, this version is exact when radix is integer"
	
	radix isInteger ifFalse: [^super floorLog: radix].
	self <= 0 ifTrue: [^DomainError signal: 'floorLog: is only defined for x > 0.0'].
	^(self numberOfDigitsInBase: radix) - 1! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 8/8/2014 19:36'!
ifMultipleOf2And5Do: aBlock otherwise: anotherBlock
	"If our prime factorization consists only of 2's and 5's, evaluata aBlock with the exponents.
	Otherwise evaluate anotherBlock.
	Be fast!!"

	| exponent2 exponent5 without2Factors |
	exponent2 _ self lowBit-1.
	without2Factors _ self bitShift: exponent2 negated.
	exponent5 _ ( 0.430676558073393 "2 ln / 5 ln" * without2Factors highBit) truncated.
	(5 raisedToInteger: exponent5) = without2Factors
		ifTrue: [
			aBlock value: exponent2 value: exponent5 ]
		ifFalse: [
			anotherBlock value ]! !

!Integer methodsFor: 'mathematical functions'!
lcm: n 
	"Answer the least common multiple of the receiver and n."

	^self // (self gcd: n) * n! !

!Integer methodsFor: 'mathematical functions' stamp: 'nice 4/22/2011 02:33'!
ln
	"This function is defined because super ln might overflow."
	| res h |
	self <= 0 ifTrue: [DomainError signal: 'ln is only defined for x > 0'].
	res := super ln.
	res isFinite ifTrue: [^res].
	h := self highBit.
	^2 ln * h + (self / (1 << h)) asFloat ln! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 8/30/2016 10:22:52'!
log
	"This function is defined because super log might overflow.
	(10 raisedTo: 215) log
	((10 raisedTo: 215)+(10 raisedTo: 213)) log
	Answers an integer number if appropriate. Doing this is somewhat expensive. If you care about performance and not about using Floats, do 'aNumber asFloat log: another'.
	"
	| floatAnswer roundedAnswer |
	self <= 0 ifTrue: [DomainError signal: 'log is only defined for x > 0'].
	floatAnswer _ self floatLog.
	roundedAnswer _ floatAnswer rounded.
	(10 raisedToInteger: roundedAnswer) = self
		ifTrue: [ ^roundedAnswer ].
	^floatAnswer! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 9/18/2016 20:42:20'!
log2
	"
	(2 raisedTo: 215) log2
	((2 raisedTo: 215)+(2 raisedTo: 213)) log2
	It would be cool to be able to give integer answers for other bases when appropriate...
	"
	^self isPowerOfTwo
		ifTrue: [ self highBitOfMagnitude-1 ]
		ifFalse: [ super log2 ]! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 8/30/2016 10:22:29'!
log: aNumber
	"Answer the log base aNumber of the receiver.
	(3 raisedTo: 215) log: 3
	((3 raisedTo: 215)+(3 raisedTo: 213)) log: 3
	Answers an integer number if appropriate. Doing this is somewhat expensive. If you care about performance and not about using Floats, do 'aNumber asFloat log: another'.
	"
	| floatAnswer roundedAnswer |
	self <= 0 ifTrue: [DomainError signal: 'log is only defined for x > 0'].
	floatAnswer _ self asFloat log: aNumber.
	roundedAnswer _ floatAnswer rounded.
	(aNumber raisedToInteger: roundedAnswer) = self
		ifTrue: [ ^roundedAnswer ].
	^floatAnswer! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 5/26/2018 22:57:47'!
nthRoot: aPositiveInteger
          "Answer the nth root of the receiver.
          Answer an Integer if root is exactly this Integer, else answer the Float nearest the exact root."
  
	| guess excess scaled nBits |
	self = 0 ifTrue: [ ^0 ].

	aPositiveInteger = 2 ifTrue: [
		^ self sqrt ].

	(aPositiveInteger isInteger not or: [ aPositiveInteger negative ])
		ifTrue: [^ ArithmeticError signal: 'nth root only defined for positive Integer n.'].

	(self negative and: [ aPositiveInteger even ]) ifTrue: [
		^ (Complex basicReal: self imaginary: 0) nthRoot: aPositiveInteger ].

	guess _ self nthRootRounded: aPositiveInteger.
	excess _ (guess raisedTo: aPositiveInteger) - self.
	excess = 0 ifTrue: [ ^ guess ].

	nBits _ Float precision - guess highBitOfMagnitude.
	nBits <= 0 ifTrue: [ ^(Fraction numerator: guess * 4 - excess sign denominator: 4) asFloat].

	scaled _ self << (nBits * aPositiveInteger).
	guess _ scaled nthRootRounded: aPositiveInteger.
	excess _ (guess raisedTo: aPositiveInteger) - scaled.
	^(Fraction numerator: guess * 4 - excess sign denominator: 1 << (nBits + 2)) asFloat! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 10/15/2016 10:57:07'!
nthRootRounded: aPositiveInteger
    "Answer the integer nearest the nth root of the receiver.
http://stackoverflow.com/questions/39794338/precise-nth-root

http://smallissimo.blogspot.com.ar/2011/09/clarifying-and-optimizing.html
Ojo 32/64!!

Tambien
http://smallissimo.blogspot.com.ar/2011/09/reviewing-fraction-asfloat.html
"
    | guess |
    self = 0 ifTrue: [^0].
    self negative
        ifTrue:
            [aPositiveInteger even ifTrue: [ ArithmeticError signal: 'Negative numbers don''t have even roots.' ].
            ^(self negated nthRootRounded: aPositiveInteger) negated].
    guess := self nthRootTruncated: aPositiveInteger.
    ^self * 2 > ((guess + 1 raisedTo: aPositiveInteger) + (guess raisedTo: aPositiveInteger))
        ifTrue: [guess + 1]
        ifFalse: [guess]! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 10/15/2016 10:39:29'!
nthRootTruncated: aPositiveInteger
          "Answer the integer part of the nth root of the receiver."
          | guess guessToTheNthMinusOne nextGuess |
          self = 0 ifTrue: [^0].
          self negative
                  ifTrue:
                          [aPositiveInteger even ifTrue: [ ArithmeticError signal: 'Negative numbers don''t have even roots.' ].
                          ^(self negated nthRootTruncated: aPositiveInteger) negated].
          guess := 1 bitShift: self highBitOfMagnitude + aPositiveInteger - 1 // aPositiveInteger.
          [
                  guessToTheNthMinusOne := guess raisedTo: aPositiveInteger - 1.
                  nextGuess := (aPositiveInteger - 1 * guess * guessToTheNthMinusOne + self) // (guessToTheNthMinusOne * aPositiveInteger).
                 nextGuess >= guess ] whileFalse:
                          [ guess := nextGuess ].
          ( guess raisedTo: aPositiveInteger) > self  ifTrue:
                          [ guess := guess - 1 ].
          ^guess! !

!Integer methodsFor: 'mathematical functions' stamp: 'sqr 12/12/2013 10:50'!
productTo: anInteger
	"Answer self * (self + 1) * ... * anInteger"
	
	| integers answer |
	integers := anInteger - self + 1.
	integers < 1 ifTrue: [^1].
	integers > 7 ifTrue:
		[
			| half |
			half := integers bitShift: -1.
			^(self productTo: self + half)
				* (self + half + 1 productTo: anInteger)
		].
	answer := self.
	self + 1 to: anInteger do:
		[:each | answer := answer * each].
	^answer! !

!Integer methodsFor: 'mathematical functions' stamp: 'nice 1/16/2013 18:38'!
raisedTo: n modulo: m
	"Answer the modular exponential.
	Note: this implementation is optimized for case of large integers raised to large powers."
	| a s mInv |
	n = 0 ifTrue: [^1].
	(self >= m or: [self < 0]) ifTrue: [^self \\ m raisedTo: n modulo: m].
	n < 0 ifTrue: [^(self reciprocalModulo: m) raisedTo: n negated modulo: m].
	(n < 4096 or: [m even])
		ifTrue:
			["Overhead of Montgomery method might cost more than naive divisions, use naive"
			^self slidingLeftRightRaisedTo: n modulo: m].
	
	mInv := self montgomeryDigitBase - ((m bitAnd: self montgomeryDigitMax) reciprocalModulo: self montgomeryDigitBase).
 
	"Initialize the result to R=self montgomeryDigitModulo raisedTo: m montgomeryNumberOfDigits"
	a := (1 bitShift: m montgomeryNumberOfDigits * m montgomeryDigitLength) \\ m.
	
	"Montgomerize self (multiply by R)"
	(s := self montgomeryTimes: (a*a \\ m) modulo: m mInvModB: mInv)
		ifNil:
			["No Montgomery primitive available ? fallback to naive divisions"
			^self slidingLeftRightRaisedTo: n modulo: m].

	"Exponentiate self*R"
	a := s montgomeryRaisedTo: n times: a modulo: m mInvModB: mInv.

	"Demontgomerize the result (divide by R)"
	^a montgomeryTimes: 1 modulo: m mInvModB: mInv! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 5/26/2018 22:19:10'!
raisedToFraction: aFraction
	| root |
	self = 0 ifTrue: [ ^0 ].
	aFraction denominator = 2 ifTrue: [
		^ self sqrt raisedToInteger: aFraction numerator ].
	(self negative and: [ aFraction denominator even ]) ifTrue: [
		^ (Complex basicReal: self imaginary: 0) raisedToFraction: aFraction].
	root _ self nthRootTruncated: aFraction denominator.
	(root raisedToInteger: aFraction denominator) = self ifTrue: [
		^ root raisedToInteger: aFraction numerator ].
	^ super raisedToFraction: aFraction! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 8/26/2011 19:38'!
raisedToInteger: exp modulo: m
	"
	self deprecated: 'rather use #raisedTo:modulo: for efficiency'.
	"
	(exp = 0) ifTrue: [^ 1].
	exp even
		ifTrue: [^ (self raisedToInteger: (exp // 2) modulo: m) squared \\ m]
		ifFalse: [^ (self * (self raisedToInteger: (exp - 1) modulo: m)) \\ m].! !

!Integer methodsFor: 'mathematical functions' stamp: 'jmv 11/27/2018 10:30:26'!
sqrt
	"Answer the square root of the receiver."

	| selfAsFloat floatResult guess |
	selfAsFloat _ self asFloat.
	floatResult _ selfAsFloat sqrt.

	floatResult isInfinite ifFalse: [
		guess _ floatResult truncated.

		"If got an exact answer, answer it. Otherwise answer float approximate answer."
		guess squared = self
			ifTrue: [ ^ guess ]].

	"In this case, maybe it failed because we are such a big integer that the Float method becomes
	inexact, even if we are a whole square number. So, try the slower but more general method."
	selfAsFloat >= Float maxExactInteger asFloat squared
		ifTrue: [
			guess _ self sqrtFloor.
			guess squared = self
				ifTrue: [ ^guess ].
			
			"Nothing else can be done. No exact answer means answer must be a Float.
			Answer the best we can which is the rounded sqrt."
			^ self sqrtRounded asFloat ].

	"We need an approximate result"
	^floatResult! !

!Integer methodsFor: 'mathematical functions' stamp: 'nice 10/17/2011 22:53'!
sqrtFloor
	"Return the integer part of the square root of self"

	| guess delta |
	guess := 1 bitShift: self highBit + 1 // 2.
	[
		delta := guess squared - self // (guess bitShift: 1).
		delta = 0 ] whileFalse: [
			guess := guess - delta ].
	^guess - 1! !

!Integer methodsFor: 'mathematical functions' stamp: 'sqr 12/12/2013 10:59'!
sqrtRounded

	| sqrtFloor |
	sqrtFloor := (self bitShift: 2) sqrtFloor.
	^(sqrtFloor bitShift: -1) + (sqrtFloor bitAnd: 1)! !

!Integer methodsFor: 'mathematical functions' stamp: 'sqr 11/28/2015 15:15'!
sumTo: anInteger
	"Answer self + self + 1 + ... + anInteger"
	
	| integers |
	integers := anInteger - self + 1.
	integers < 1 ifTrue: [^0].
	^self + anInteger * integers bitShift: -1! !

!Integer methodsFor: 'mathematical functions' stamp: 'sqr 12/12/2013 10:40'!
take: anInteger
	"Answer the binomial coefficient (self anInteger)"
	" 6 take: 3  "

	(anInteger < 0 or: [anInteger > self]) ifTrue: [^0].
	^(self - anInteger + 1 productTo: self) // anInteger factorial! !


!Integer methodsFor: 'printing' stamp: 'jmv 1/7/2014 01:13'!
hex
	"Print the receiver as hex, prefixed with 16r.  DO NOT CHANGE THIS!!  The Cog VMMaker depends on this.
	 Consider using any of
		printStringBase: 16
		printStringBase: 16 length: 8 padded: true
		storeStringBase: 16
		storeStringBase: 16 length: 11 padded: true"

	^ String streamContents: [ :strm | self storeOn: strm base: 16 ]! !

!Integer methodsFor: 'printing' stamp: 'eem 5/21/2010 11:09'!
hex8
	"Print the receiver in base 16 with prefixed base, using at least 8 digits.
	 DO NOT CHANGE THIS!!  The Cog VMMaker depends on this.
	 Consider using storeStringBase: 16 length: 11 padded: true instead."
	  "16r3333 hex8"
	| hex |
	hex := self hex.  "16rNNN"
	^hex size < 11
		ifTrue: [hex copyReplaceFrom: 4 to: 3
						 with: ('00000000' copyFrom: 1 to: 11-hex size)]
		ifFalse: [hex]! !

!Integer methodsFor: 'printing'!
isLiteral

	^true! !

!Integer methodsFor: 'printing' stamp: 'nice 6/17/2011 04:10'!
numberOfDigitsInBase: b 
	"Return how many digits are necessary to print this number in base b.
	This does not count any place for minus sign, radix prefix or whatever.
	Note that this algorithm may cost a few operations on LargeInteger."

	| nDigits q total |
	self negative ifTrue: [^self negated numberOfDigitsInBase: b].
	self < b ifTrue: [^1].
	b isPowerOfTwo ifTrue: [^self highBit + b highBit - 2 quo: b highBit - 1].
	
	"A conversion from base 2 to base b has to be performed.
	This algorithm avoids Float computations like (self log: b) floor + 1,
	1) because they are inexact
	2) because LargeInteger might overflow
	3) because this algorithm might be cheaper than conversion"

	q := self.
	total := 0.
	["Make an initial nDigits guess that is lower than or equal to required number of digits"
	nDigits := b = 10
		ifTrue: [((q highBit - 1) * 1233 >> 12) + 1. "This is because (2 log)/(10 log)*4096 is slightly greater than 1233"]
		ifFalse: [q highBit quo: b highBit].
	total := total + nDigits.
	
	"See how many digits remains above these first nDigits guess"
	(q := q quo: (b raisedToInteger: nDigits)) < b] whileFalse.
	^q = 0
		ifTrue: [total]
		ifFalse: [total + 1]! !

!Integer methodsFor: 'printing' stamp: 'laza 3/29/2004 18:13'!
printOn: aStream base: base length: minimum padded: zeroFlag
	| prefix |
	prefix := self negative ifTrue: ['-'] ifFalse: [String new].
	self print: (self abs printStringBase: base) on: aStream prefix: prefix length: minimum padded: zeroFlag
! !

!Integer methodsFor: 'printing' stamp: 'nice 2/15/2008 21:44'!
printOn: aStream base: b nDigits: n 
	"Append a representation of this number in base b on aStream using nDigits.
	self must be positive."

	self subclassResponsibility! !

!Integer methodsFor: 'printing' stamp: 'jmv 12/20/2018 17:54:47'!
printOn: aStream fractionDigits: placesDesired
	"Same as super, but provides a faster implementation because fraction part and rounding are trivial."
	
	self printOn: aStream base: 10.

	placesDesired > 0
		ifTrue: [
			aStream nextPut: $..
			placesDesired timesRepeat: [
				aStream nextPut: $0 ]]! !

!Integer methodsFor: 'printing' stamp: 'jmv 5/9/2017 19:45:38'!
printOn: aStream length: minimum zeroPadded: zeroFlag
	"
	7 printOn: Transcript length: 4 padded: true. Transcript newLine.
	"
	self printOn: aStream base: 10 length: minimum padded: zeroFlag! !

!Integer methodsFor: 'printing' stamp: 'jmv 1/7/2014 00:49'!
printOn: aStream thousandSeparator: aString includePlusSign: aBoolean
	"
	String streamContents: [ :strm | 123456789 printOn: strm thousandSeparator: ',' includePlusSign: false ]
	String streamContents: [ :strm | -123456789 printOn: strm thousandSeparator: ',' includePlusSign: false ]
	"
	| digits |
	digits _ self abs printString.
	self sign = -1
		ifTrue: [ aStream nextPut: $- ]
		ifFalse: [
			aBoolean ifTrue: [ aStream nextPut: $+ ]].
	1 to: digits size do: [ :i |
		aStream nextPut: (digits at: i).
		(i < digits size and: [ i - digits size \\ 3 = 0 ]) ifTrue: [
			aStream nextPutAll: aString ]]! !

!Integer methodsFor: 'printing' stamp: 'jmv 9/19/2017 21:42:27'!
printStringAsBytes
	"Answer a terse, easily-readable representation of this Integer reprsenting a number of bytes.  Useful for file-browsers.
	123 printStringAsBytes
	1024 printStringAsBytes
	(12*1024) printStringAsBytes
	(1024*1024) printStringAsBytes
	(1024*1024*1024) printStringAsBytes
	(1024*1024*1024*1024) printStringAsBytes
	(30 factorial) printStringAsBytes
	
	See https://en.wikipedia.org/wiki/Kibibyte
	See #printStringAsBytesDecimal
	"
	self withBinaryUnitPrefixAndValue: [ :value  :unitPrefixSymbol :unitPrefixName |
		^String streamContents: [ :strm |
			value printOn: strm fractionDigits: 2.
			strm
				space;
				nextPutAll: unitPrefixSymbol;
				nextPut: $B]]! !

!Integer methodsFor: 'printing' stamp: 'jmv 9/19/2017 21:48:23'!
printStringAsBytesDecimal
	"Answer a terse, easily-readable representation of this Integer reprsenting a number of bytes.  Useful for file-browsers.
	123 printStringAsBytesDecimal
	(12*1000) printStringAsBytesDecimal
	(1000*1000) printStringAsBytesDecimal
	
	1024 printStringAsBytesDecimal
	(12*1024) printStringAsBytesDecimal
	(1024*1024) printStringAsBytesDecimal
	(1024*1024*1024) printStringAsBytesDecimal
	(1024*1024*1024*1024) printStringAsBytesDecimal
	(30 factorial) printStringAsBytesDecimal
	
	See https://en.wikipedia.org/wiki/Kibibyte
	See #printStringAsBytes
	"
	self withDecimalUnitPrefixAndValue: [ :value  :unitPrefixSymbol :unitPrefixName |
		^String streamContents: [ :strm |
			value printOn: strm fractionDigits: 2.
			strm
				space;
				nextPutAll: unitPrefixSymbol;
				nextPut: $B]]! !

!Integer methodsFor: 'printing' stamp: 'laza 3/29/2004 18:14'!
printStringBase: base length: minimum padded: zeroFlag
	^String streamContents: [:s| self printOn: s base: base length: minimum padded: zeroFlag]! !

!Integer methodsFor: 'printing' stamp: 'laza 3/29/2004 10:58'!
printStringHex
	^self printStringBase: 16! !

!Integer methodsFor: 'printing' stamp: 'sqr 12/6/2015 17:48'!
printStringRadix: anInteger

	^anInteger printString, 'r', (self printStringBase: anInteger)! !

!Integer methodsFor: 'printing' stamp: 'nice 12/13/2009 17:59'!
printStringRoman
	^String streamContents: [:stream | | integer |
		integer := self negative ifTrue: [stream nextPut: $-. self negated] ifFalse: [self].
		integer // 1000 timesRepeat: [stream nextPut: $M].
		integer
			romanDigits: 'MDC' for: 100 on: stream;
			romanDigits: 'CLX' for: 10 on: stream;
			romanDigits: 'XVI' for: 1 on: stream]! !

!Integer methodsFor: 'printing' stamp: 'jmv 1/7/2014 21:42'!
printStringWithCommas
	"
	123456789 printStringWithCommas
	-123456789 printStringWithCommas
	"
	^String streamContents: [ :strm |
		self printOn: strm thousandSeparator: ',' includePlusSign: false ]! !

!Integer methodsFor: 'printing' stamp: 'jmv 1/7/2014 00:45'!
printStringWords
	"
	SmallInteger maxVal printStringWords
	"
	| mils minus three num answer milCount |
	self = 0 ifTrue: [^'zero'].
	mils _ #('' ' thousand' ' million' ' billion' ' trillion' ' quadrillion' ' quintillion' ' sextillion' ' septillion' ' octillion' ' nonillion' ' decillion' ' undecillion' ' duodecillion' ' tredecillion' ' quattuordecillion' ' quindecillion' ' sexdecillion' ' septendecillion' ' octodecillion' ' novemdecillion' ' vigintillion').
	num _ self.
	minus _ ''.
	self < 0 ifTrue: [
		minus _ 'negative '.
		num _ num negated.
	].
	answer _ String new.
	milCount _ 1.
	[num > 0] whileTrue: [
		three _ (num \\ 1000) threeDigitName.
		num _ num // 1000.
		three isEmpty ifFalse: [
			answer isEmpty ifFalse: [
				answer _ ', ',answer
			].
			answer _ three,(mils at: milCount),answer.
		].
		milCount _ milCount + 1.
	].
	^minus,answer! !

!Integer methodsFor: 'printing' stamp: 'jmv 1/7/2014 01:04'!
storeOn: aStream base: base
	"Print a representation of the receiver on the stream
	<aStream> in base <base> where
	2 <= <baseInteger> <= 16. If <base> is other than 10
	it is written first separated by $r followed by the number
	like for example: 16rFCE2"

	| integer |
	integer := self negative
		ifTrue: [ aStream nextPut: $-. self negated ]
		ifFalse: [ self ].
	base = 10 ifFalse: [ aStream nextPutAll: base printString; nextPut: $r ].
	integer printOn: aStream base: base! !

!Integer methodsFor: 'printing' stamp: 'laza 3/29/2004 10:58'!
storeStringHex
	^self storeStringBase: 16! !


!Integer methodsFor: 'system primitives' stamp: 'tk 3/24/1999 20:26'!
lastDigit
	"Answer the last digit of the integer base 256.  LargePositiveInteger uses bytes of base two number, and each is a 'digit'."

	^self digitAt: self digitLength! !

!Integer methodsFor: 'system primitives'!
replaceFrom: start to: stop with: replacement startingAt: repStart
	| j |  "Catches failure if LgInt replace primitive fails"
	j _ repStart.
	start to: stop do:
		[:i |
		self digitAt: i put: (replacement digitAt: j).
		j _ j+1]! !


!Integer methodsFor: 'testing'!
even 
	"Refer to the comment in Number|even."

	^((self digitAt: 1) bitAnd: 1) = 0! !

!Integer methodsFor: 'testing'!
isInteger
	"True for all subclasses of Integer."

	^ true! !

!Integer methodsFor: 'testing' stamp: 'ar 6/9/2000 18:56'!
isPowerOfTwo
	"Return true if the receiver is an integral power of two."
	^ (self bitAnd: self-1) = 0! !

!Integer methodsFor: 'testing' stamp: 'dtl 1/23/2010 14:16'!
isPrime
	"Answer true if the receiver is a prime number. See isProbablyPrime for a probabilistic
	implementation that is much faster for large integers, and that is correct to an extremely
	high statistical level of confidence (effectively deterministic)."
	
	self <= 1 ifTrue: [ ^false ].
	self even ifTrue: [ ^self = 2].
	3 to: self sqrtFloor by: 2 do: [ :each |
		self \\ each = 0 ifTrue: [ ^false ] ].
	^true! !

!Integer methodsFor: 'testing' stamp: 'nice 11/14/2011 21:59'!
isProbablyPrime
	"See isProbablyPrimeWithK:andQ: for the algoritm description."
	
	| k q |
	self <= 1 ifTrue: [ ^false ].
	self even ifTrue: [ ^self = 2 ].
	"Factor self into (2 raisedTo: k) * q + 1, where q odd"
	q := self bitShift: -1.
	k := q lowBit.
	q := q bitShift: 1 - k.
	"Repeat the probabilistic until false (the probability of false negative is null) or until probability is very low."
	25 timesRepeat: [ (self isProbablyPrimeWithK: k andQ: q) ifFalse: [ ^false ] ].
	"The probability of false positive after 25 iterations is less than (1/4 raisedTo: 25) < 1.0e-15"
	^true! !

!Integer methodsFor: 'testing' stamp: 'sqr 12/14/2013 16:07'!
nextPrime

	| pivot |
	self < 2 ifTrue: [^2].
	pivot := self + 1 bitOr: 1.
	[pivot isPrime] whileFalse: [pivot := pivot + 2].
	^pivot! !


!Integer methodsFor: 'truncation and round off' stamp: 'jmv 4/4/2015 20:25'!
atRandom
	"Answer a random integer from 1 to self.  This implementation uses a
	shared generator. Heavy users should their own implementation or use
	Interval>atRandom: directly."
	"
	7 atRandom
	"

	self = 0 ifTrue: [ ^0 ].
	self < 0 ifTrue: [ ^self negated atRandom negated ].
	^ Random withDefaultDo: [ :random |
		self atRandom: random ]! !

!Integer methodsFor: 'truncation and round off' stamp: 'len 2/16/2016 17:11'!
atRandom: aGenerator
	"Answer a random integer from 1 to self picked from aGenerator."

	^ aGenerator nextInteger: self! !

!Integer methodsFor: 'truncation and round off' stamp: 'sqr 12/21/2013 17:55'!
ceiling 
	"Refer to the comment in Number|ceiling."

	^self! !

!Integer methodsFor: 'truncation and round off' stamp: 'sqr 12/21/2013 17:56'!
floor 
	"Refer to the comment in Number|floor."

	^self! !

!Integer methodsFor: 'truncation and round off'!
normalize 
	"SmallInts OK; LgInts override"
	^ self! !

!Integer methodsFor: 'truncation and round off' stamp: 'sqr 12/21/2013 17:56'!
rounded 
	"Refer to the comment in Number|rounded."

	^self! !

!Integer methodsFor: 'truncation and round off' stamp: 'sqr 12/21/2013 17:56'!
truncated 
	"Refer to the comment in Number|truncated."

	^self! !


!Integer methodsFor: 'private'!
copyto: x
	| stop |
	stop _ self digitLength min: x digitLength.
	^ x replaceFrom: 1 to: stop with: self startingAt: 1! !

!Integer methodsFor: 'private' stamp: 'sr 1/23/2000 05:41'!
digitAdd: arg 
	| len arglen accum sum |
	<primitive: 'primDigitAdd' module:'LargeIntegers'>
	accum _ 0.
	(len _ self digitLength) < (arglen _ arg digitLength) ifTrue: [len _ arglen].
	"Open code max: for speed"
	sum _ Integer new: len neg: self negative.
	1 to: len do: 
		[:i | 
		accum _ (accum bitShift: -8)
					+ (self digitAt: i) + (arg digitAt: i).
		sum digitAt: i put: (accum bitAnd: 255)].
	accum > 255
		ifTrue: 
			[sum _ sum growby: 1.
			sum at: sum digitLength put: (accum bitShift: -8)].
	^ sum! !

!Integer methodsFor: 'private' stamp: 'sr 1/23/2000 05:43'!
digitCompare: arg 
	"Compare the magnitude of self with that of arg.   
	Return a code of 1, 0, -1 for self >, = , < arg"
	| len arglen argDigit selfDigit |
	<primitive: 'primDigitCompare' module:'LargeIntegers'>
	len _ self digitLength.
	(arglen _ arg digitLength) ~= len
		ifTrue: [arglen > len
				ifTrue: [^ -1]
				ifFalse: [^ 1]].
	[len > 0]
		whileTrue: 
			[(argDigit _ arg digitAt: len) ~= (selfDigit _ self digitAt: len)
				ifTrue: [argDigit < selfDigit
						ifTrue: [^ 1]
						ifFalse: [^ -1]].
			len _ len - 1].
	^ 0! !

!Integer methodsFor: 'private' stamp: 'sqr 1/26/2014 13:38'!
digitDiv: arg neg: ng 
	"Answer with an array of (quotient, remainder)."
	| quo rem ql d div dh dnh dl qhi qlo j l hi lo r3 a t |
	<primitive: 'primDigitDivNegative' module:'LargeIntegers'>
	arg = 0 ifTrue: [^ (ZeroDivide dividend: self) signal].
	"TFEI added this line"
	l _ self digitLength - arg digitLength + 1.
	l <= 0 ifTrue: [^ Array with: 0 with: self].
	"shortcut against #highBit"
	d _ 8 - arg lastDigit highBitOfMagnitude.
	div _ arg digitLshift: d.
	div _ div growto: div digitLength + 1.
	"shifts so high order word is >=128"
	rem _ self digitLshift: d.
	rem digitLength = self digitLength ifTrue: [rem _ rem growto: self digitLength + 1].
	"makes a copy and shifts"
	quo _ Integer new: l neg: ng.
	dl _ div digitLength - 1.
	"Last actual byte of data"
	ql _ l.
	dh _ div digitAt: dl.
	dnh _ dl = 1
				ifTrue: [0]
				ifFalse: [div digitAt: dl - 1].
	1 to: ql do: 
		[:k | 
		"maintain quo*arg+rem=self"
		"Estimate rem/div by dividing the leading to bytes of rem by dh."
		"The estimate is q = qhi*16+qlo, where qhi and qlo are nibbles."
		j _ rem digitLength + 1 - k.
		"r1 _ rem digitAt: j."
		(rem digitAt: j)
			= dh
			ifTrue: [qhi _ qlo _ 15
				"i.e. q=255"]
			ifFalse: 
				["Compute q = (r1,r2)//dh, t = (r1,r2)\\dh.  
				Note that r1,r2 are bytes, not nibbles.  
				Be careful not to generate intermediate results exceeding 13  
				bits."
				"r2 _ (rem digitAt: j - 1)."
				t _ ((rem digitAt: j)
							bitShift: 4)
							+ ((rem digitAt: j - 1)
									bitShift: -4).
				qhi _ t // dh.
				t _ (t \\ dh bitShift: 4)
							+ ((rem digitAt: j - 1)
									bitAnd: 15).
				qlo _ t // dh.
				t _ t \\ dh.
				"Next compute (hi,lo) _ q*dnh"
				hi _ qhi * dnh.
				lo _ qlo * dnh + ((hi bitAnd: 15)
								bitShift: 4).
				hi _ (hi bitShift: -4)
							+ (lo bitShift: -8).
				lo _ lo bitAnd: 255.
				"Correct overestimate of q.  
				Max of 2 iterations through loop -- see Knuth vol. 2"
				r3 _ j < 3
							ifTrue: [0]
							ifFalse: [rem digitAt: j - 2].
				[(t < hi
					or: [t = hi and: [r3 < lo]])
					and: 
						["i.e. (t,r3) < (hi,lo)"
						qlo _ qlo - 1.
						lo _ lo - dnh.
						lo < 0
							ifTrue: 
								[hi _ hi - 1.
								lo _ lo + 256].
						hi >= dh]]
					whileTrue: [hi _ hi - dh].
				qlo < 0
					ifTrue: 
						[qhi _ qhi - 1.
						qlo _ qlo + 16]].
		"Subtract q*div from rem"
		l _ j - dl.
		a _ 0.
		1 to: div digitLength do: 
			[:i | 
			hi _ (div digitAt: i)
						* qhi.
			lo _ a + (rem digitAt: l) - ((hi bitAnd: 15)
							bitShift: 4) - ((div digitAt: i)
							* qlo).
			rem digitAt: l put: lo - (lo // 256 * 256).
			"sign-tolerant form of (lo bitAnd: 255)"
			a _ lo // 256 - (hi bitShift: -4).
			l _ l + 1].
		a < 0
			ifTrue: 
				["Add div back into rem, decrease q by 1"
				qlo _ qlo - 1.
				l _ j - dl.
				a _ 0.
				1 to: div digitLength do: 
					[:i | 
					a _ (a bitShift: -8)
								+ (rem digitAt: l) + (div digitAt: i).
					rem digitAt: l put: (a bitAnd: 255).
					l _ l + 1]].
		quo digitAt: quo digitLength + 1 - k put: (qhi bitShift: 4)
				+ qlo].
	rem _ rem
				digitRshift: d
				bytes: 0
				lookfirst: dl.
	^ Array with: quo with: rem! !

!Integer methodsFor: 'private' stamp: 'nice 1/26/2008 02:12'!
digitLogic: arg op: op length: len 
	| i result neg1 neg2 rneg z1 z2 rz b1 b2 b |
	neg1 := self negative.
	neg2 := arg negative.
	rneg := ((neg1
				ifTrue: [-1]
				ifFalse: [0])
				perform: op
				with: (neg2
						ifTrue: [-1]
						ifFalse: [0]))
				< 0.
	result := Integer new: len neg: rneg.
	rz := z1 := z2 := true.
	i := 0.
	[(i := i + 1) <= len
		or: ["mind a carry on result that might go past len digits"
			rneg and: [rz
				and: [result := result growby: 1.
					true]]]]
		whileTrue: [b1 := self digitAt: i.
			neg1
				ifTrue: [b1 := z1
								ifTrue: [b1 = 0
										ifTrue: [0]
										ifFalse: [z1 := false.
											256 - b1]]
								ifFalse: [255 - b1]].
			b2 := arg digitAt: i.
			neg2
				ifTrue: [b2 := z2
								ifTrue: [b2 = 0
										ifTrue: [0]
										ifFalse: [z2 := false.
											256 - b2]]
								ifFalse: [255 - b2]].
			b := b1 perform: op with: b2.
			result
				digitAt: i
				put: (rneg
						ifTrue: [rz
								ifTrue: [b = 0
										ifTrue: [0]
										ifFalse: [rz := false.
											256 - b]]
								ifFalse: [255 - b]]
						ifFalse: [b])].
	^ result normalize! !

!Integer methodsFor: 'private' stamp: 'sr 6/8/2000 01:30'!
digitLshift: shiftCount 
	| carry rShift mask len result digit byteShift bitShift highBit |
	(highBit _ self highBitOfMagnitude) = 0 ifTrue: [^ 0].
	len _ highBit + shiftCount + 7 // 8.
	result _ Integer new: len neg: self negative.
	byteShift _ shiftCount // 8.
	bitShift _ shiftCount \\ 8.
	bitShift = 0 ifTrue: ["Fast version for byte-aligned shifts"
		^ result
			replaceFrom: byteShift + 1
			to: len
			with: self
			startingAt: 1].
	carry _ 0.
	rShift _ bitShift - 8.
	mask _ 255 bitShift: 0 - bitShift.
	1 to: byteShift do: [:i | result digitAt: i put: 0].
	1 to: len - byteShift do: 
		[:i | 
		digit _ self digitAt: i.
		result digitAt: i + byteShift put: (((digit bitAnd: mask)
				bitShift: bitShift)
				bitOr: carry).
		carry _ digit bitShift: rShift].
	^ result! !

!Integer methodsFor: 'private' stamp: 'sr 1/23/2000 05:46'!
digitMultiply: arg neg: ng 
	| prod prodLen carry digit k ab |
	<primitive: 'primDigitMultiplyNegative' module:'LargeIntegers'>
	(arg digitLength = 1 and: [(arg digitAt: 1)
			= 0])
		ifTrue: [^ 0].
	(self digitLength = 1 and: [(self digitAt: 1)
			= 0])
		ifTrue: [^ 0].
	prodLen _ self digitLength + arg digitLength.
	prod _ Integer new: prodLen neg: ng.
	"prod starts out all zero"
	1 to: self digitLength do: [:i | (digit _ self digitAt: i) ~= 0
			ifTrue: 
				[k _ i.
				carry _ 0.
				"Loop invariant: 0<=carry<=0377, k=i+j-1"
				1 to: arg digitLength do: 
					[:j | 
					ab _ (arg digitAt: j)
								* digit + carry + (prod digitAt: k).
					carry _ ab bitShift: -8.
					prod digitAt: k put: (ab bitAnd: 255).
					k _ k + 1].
				prod digitAt: k put: carry]].
	^ prod normalize! !

!Integer methodsFor: 'private'!
digitRshift: anInteger bytes: b lookfirst: a 
	 "Shift right 8*b+anInteger bits, 0<=n<8.
	Discard all digits beyond a, and all zeroes at or below a."
	| n x r f m digit count i |
	n _ 0 - anInteger.
	x _ 0.
	f _ n + 8.
	i _ a.
	m _ 255 bitShift: 0 - f.
	digit _ self digitAt: i.
	[((digit bitShift: n) bitOr: x) = 0 and: [i ~= 1]] whileTrue:
		[x _ digit bitShift: f "Can't exceed 8 bits".
		i _ i - 1.
		digit _ self digitAt: i].
	i <= b ifTrue: [^Integer new: 0 neg: self negative].  "All bits lost"
	r _ Integer new: i - b neg: self negative.
	count _ i.
	x _ (self digitAt: b + 1) bitShift: n.
	b + 1 to: count do:
		[:j | digit _ self digitAt: j + 1.
		r digitAt: j - b put: (((digit bitAnd: m) bitShift: f) bitOr: x) 
			"Avoid values > 8 bits".
		x _ digit bitShift: n].
	^r! !

!Integer methodsFor: 'private' stamp: 'sr 1/23/2000 05:46'!
digitSubtract: arg 
	| smaller larger z sum sl al ng |
	<primitive: 'primDigitSubtract' module:'LargeIntegers'>
	sl _ self digitLength.
	al _ arg digitLength.
	(sl = al
		ifTrue: 
			[[(self digitAt: sl)
				= (arg digitAt: sl) and: [sl > 1]]
				whileTrue: [sl _ sl - 1].
			al _ sl.
			(self digitAt: sl)
				< (arg digitAt: sl)]
		ifFalse: [sl < al])
		ifTrue: 
			[larger _ arg.
			smaller _ self.
			ng _ self negative == false.
			sl _ al]
		ifFalse: 
			[larger _ self.
			smaller _ arg.
			ng _ self negative].
	sum _ Integer new: sl neg: ng.
	z _ 0.
	"Loop invariant is -1<=z<=1"
	1 to: sl do: 
		[:i | 
		z _ z + (larger digitAt: i) - (smaller digitAt: i).
		sum digitAt: i put: z - (z // 256 * 256).
		"sign-tolerant form of (z bitAnd: 255)"
		z _ z // 256].
	^ sum normalize! !

!Integer methodsFor: 'private'!
growby: n

	^self growto: self digitLength + n! !

!Integer methodsFor: 'private'!
growto: n

	^self copyto: (self species new: n)! !

!Integer methodsFor: 'private' stamp: 'nice 11/15/2011 23:13'!
isProbablyPrimeWithK: k andQ: q 
	"Algorithm P, probabilistic primality test, from
	Knuth, Donald E. 'The Art of Computer Programming', Vol 2,
	Third Edition, section 4.5.4, page 395, P1-P5 refer to Knuth description..
	Note that this is a Miller Rabin test which may answer false positives (known as pseudoprimes) for at most 1/4 of the possible bases x."

	| x j y minusOne |
	"P1"
	x := (self - 2) atRandom + 1.
	"P2"
	j := 0.
	y := x raisedTo: q modulo: self.
	minusOne := self - 1.
	
	["P3"
	y = 1 ifTrue: [^j = 0].
	y = minusOne ifTrue: [^true].
	"P4"
	(j := j + 1) < k]
		whileTrue:
			[y := y squared \\ self].
	"P5"
	^false! !

!Integer methodsFor: 'private' stamp: 'nice 1/19/2013 03:13'!
montgomeryDigitBase
	"Answer the base used by Montgomery algorithm."
	^1 << self montgomeryDigitLength! !

!Integer methodsFor: 'private' stamp: 'nice 1/19/2013 03:27'!
montgomeryDigitLength
	"Answer the number of bits composing a digit in Montgomery algorithm.
	Primitive use either 8 or 32 bits digits"
	<primitive: 'primMontgomeryDigitLength' module:'LargeIntegers'>
	^8 "Legacy plugin which did not have this primitive did use 8 bits digits"! !

!Integer methodsFor: 'private' stamp: 'nice 1/19/2013 03:14'!
montgomeryDigitMax
	"Answer the maximum value of a digit used in Montgomery algorithm."
	
	^1 << self montgomeryDigitLength - 1! !

!Integer methodsFor: 'private' stamp: 'nice 1/19/2013 03:16'!
montgomeryNumberOfDigits
	"Answer the number of montgomery digits required to represent the receiver."
	^self digitLength * 8 + (self montgomeryDigitLength - 1) // self montgomeryDigitLength! !

!Integer methodsFor: 'private' stamp: 'nice 5/19/2011 02:08'!
montgomeryRaisedTo: n times: y modulo: m mInvModB: mInv
	"Private - do a Montgomery exponentiation of self modulo m.
	The operation is equivalent to (self/y raisedTo: n)*y \\ m,
	with y is (256 raisedTo: m digitLength),
	with (m bitAnd: 255) * mInv \\ 256 = 255."
	
	| pow j k w index oddPowersOfSelf square |
	
	"Precompute powers of self for odd bit patterns xxxx1 up to length w + 1.
	The width w is chosen with respect to the total bit length of n,
	such that each bit pattern will on average be encoutered P times in the whole bit sequence of n.
	This costs (2 raisedTo: w) multiplications, but more will be saved later (see below)."
	k := n highBit.
	w := (k highBit - 1 >> 1 min: 16) max: 1.
	oddPowersOfSelf := Array new: 1 << w.
	oddPowersOfSelf at: 1 put: (pow := self).
	square := self montgomeryTimes: self modulo: m mInvModB: mInv.
	2 to: oddPowersOfSelf size do: [:i | pow := oddPowersOfSelf at: i put: (pow montgomeryTimes: square modulo: m mInvModB: mInv)].
	
	"Now exponentiate by searching precomputed bit patterns with a sliding window"
	pow := y.
	[k > 0]
		whileTrue:
			[pow := pow montgomeryTimes: pow modulo: m mInvModB: mInv.
			"Skip bits set to zero (the sliding window)"
			(n bitAt: k) = 0
				ifFalse:
					["Find longest odd bit pattern up to window length (w + 1)"
					j := k - w max: 1.
					[j < k and: [(n bitAt: j) = 0]] whileTrue: [j := j + 1].
					"We found a bit pattern of length k-j+1;
					perform the square powers for each bit
					(same cost as bitwise algorithm);
					compute the index of this bit pattern in the precomputed powers."
					index := 0.
					[k > j] whileTrue:
						[pow := pow montgomeryTimes: pow modulo: m mInvModB: mInv.
						index := index << 1 + (n bitAt: k).
						k := k - 1].
					"Perform a single multiplication for the whole bit pattern.
					This saves up to (k-j) multiplications versus a naive algorithm operating bit by bit"
					pow := pow montgomeryTimes: (oddPowersOfSelf at: index + 1) modulo: m mInvModB: mInv].
			k := k - 1].
	^pow! !

!Integer methodsFor: 'private' stamp: 'nice 1/16/2013 18:40'!
montgomeryTimes: a modulo: m mInvModB: mInv
	"Answer the result of a Montgomery multiplication
	self * a * (b raisedTo: m montgomeryNumberOfDigits) inv \\ m
	NOTE: it is assumed that:
	self montgomeryNumberOfDigits <= m montgomeryNumberOfDigits
	a montgomeryNumberOfDigits <= m montgomeryNumberOfDigits
	mInv * m \\ b = (-1 \\ b) = (b-1) (this implies m odd)
	where b = self montgomeryDigitBase
	
	Answer nil in case of absent plugin or other failure."
	
	<primitive: 'primMontgomeryTimesModulo' module:'LargeIntegers'>
	^nil! !

!Integer methodsFor: 'private' stamp: 'laza 3/29/2004 18:16'!
print: positiveNumberString on: aStream prefix: prefix length: minimum padded: zeroFlag
	| padLength |
	padLength := minimum - positiveNumberString size - prefix size.
	padLength > 0
		ifTrue: [zeroFlag
				ifTrue: [aStream nextPutAll: prefix; nextPutAll: (String new: padLength withAll: $0)]
				ifFalse: [aStream nextPutAll: (String new: padLength withAll: Character space); nextPutAll: prefix]]
		ifFalse: [aStream nextPutAll: prefix].
	aStream nextPutAll: positiveNumberString
	! !

!Integer methodsFor: 'private' stamp: 'sma 5/20/2000 17:00'!
romanDigits: digits for: base on: aStream
	| n |
	n _ self \\ (base * 10) // base.
	n = 9 ifTrue: [^ aStream nextPut: digits last; nextPut: digits first].
	n = 4 ifTrue: [^ aStream nextPut: digits last; nextPut: digits second].
	n > 4 ifTrue: [aStream nextPut: digits second].
	n \\ 5 timesRepeat: [aStream nextPut: digits last]! !

!Integer methodsFor: 'private' stamp: 'nice 5/19/2011 02:00'!
slidingLeftRightRaisedTo: n modulo: m
	"Private - compute (self raisedTo: n) \\ m,
	Note: this method has to be fast because it is generally used with large integers in cryptography.
	It thus operate on exponent bits from left to right by packets with a sliding window rather than bit by bit (see below)."
	
	| pow j k w index oddPowersOfSelf square |
	
	"Precompute powers of self for odd bit patterns xxxx1 up to length w + 1.
	The width w is chosen with respect to the total bit length of n,
	such that each bit pattern will on average be encoutered P times in the whole bit sequence of n.
	This costs (2 raisedTo: w) multiplications, but more will be saved later (see below)."
	k := n highBit.
	w := (k highBit - 1 >> 1 min: 16) max: 1.
	oddPowersOfSelf := Array new: 1 << w.
	oddPowersOfSelf at: 1 put: (pow := self).
	square := self * self \\\ m.
	2 to: oddPowersOfSelf size do: [:i | pow := oddPowersOfSelf at: i put: pow * square \\\ m].
	
	"Now exponentiate by searching precomputed bit patterns with a sliding window"
	pow := 1.
	[k > 0]
		whileTrue:
			[pow := pow * pow \\\ m.
			"Skip bits set to zero (the sliding window)"
			(n bitAt: k) = 0
				ifFalse:
					["Find longest odd bit pattern up to window length (w + 1)"
					j := k - w max: 1.
					[j < k and: [(n bitAt: j) = 0]] whileTrue: [j := j + 1].
					"We found an odd bit pattern of length k-j+1;
					perform the square powers for each bit
					(same cost as bitwise algorithm);
					compute the index of this bit pattern in the precomputed powers."
					index := 0.
					[k > j] whileTrue:
						[pow := pow * pow \\\ m.
						index := index << 1 + (n bitAt: k).
						k := k - 1].
					"Perform a single multiplication for the whole bit pattern.
					This saves up to (k-j) multiplications versus a naive algorithm operating bit by bit"
					pow := pow * (oddPowersOfSelf at: index + 1) \\\ m].
			k := k - 1].
	^pow normalize! !


!Integer methodsFor: 'Romanos' stamp: 'AB 5/3/2019 10:08:40'!
appendAsRomanStringUnit: aStream
	
	(self between: 1 and: 3) ifTrue: [
		self timesRepeat: [ aStream nextPut: $I ]
	].

	(self = 4)  ifTrue: [ aStream nextPutAll: 'IV' ].

	(self between: 5 and: 8) ifTrue: [ 
		aStream nextPut: $V. 
		(self - 5) timesRepeat: [ aStream nextPut: $I ]
	].

	(self = 9)  ifTrue: [ aStream nextPutAll: 'IX' ].
	! !

!Integer methodsFor: 'Romanos' stamp: 'AB 5/3/2019 10:12:33'!
asRomanString

	self = 0 ifTrue: [ self error ].
	
	^String streamContents: [: stream |

		self appendAsRomanStringUnit: stream.
		
		(self between: 10 and:39) ifTrue: [
			(self // 10 ) timesRepeat: [ stream nextPut: $X].
			(self \\ 10 ) appendAsRomanStringUnit: stream.
		].

		(self between: 50 and:89) ifTrue: [
			stream nextPut: $L.
			((self-50) // 10 ) timesRepeat: [ stream nextPut: $X].
			((self-50) \\ 10 ) appendAsRomanStringUnit: stream.
		].
	
		(self between: 40 and: 49) ifTrue: [
			stream nextPutAll: 'XL'.
			(self - 40) appendAsRomanStringUnit: stream.
		].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Integer class' category: #'Kernel-Numbers'!
Integer class
	instanceVariableNames: ''!

!Integer class methodsFor: 'instance creation' stamp: 'tk 4/20/1999 14:18'!
basicNew

	self == Integer ifTrue: [
		^ self error: 'Integer is an abstract class.  Make a concrete subclass.'].
	^ super basicNew! !

!Integer class methodsFor: 'instance creation' stamp: 'sw 5/8/2000 11:05'!
initializedInstance
	^ 2468! !

!Integer class methodsFor: 'instance creation' stamp: 'tk 4/18/1999 22:01'!
new

	self == Integer ifTrue: [
		^ self error: 'Integer is an abstract class.  Make a concrete subclass.'].
	^ super new! !

!Integer class methodsFor: 'instance creation'!
new: length neg: neg
	"Answer an instance of a large integer whose size is length. neg is a flag 
	determining whether the integer is negative or not."

	neg 
		ifTrue: [^LargeNegativeInteger new: length]
		ifFalse: [^LargePositiveInteger new: length]! !

!Integer class methodsFor: 'instance creation' stamp: 'jmv 2/12/2010 10:38'!
readBaseOneFrom: aStream
	"Unary numeral system
	Supports positive and negative integers.
	See http://en.wikipedia.org/wiki/Unary_numeral_system
	Non-standard features of this system include:
		- The value of a digit does not depend on its position. Thus, one can easily argue that unary is not a positional system at all.
		- Introducing a radix point in this system will not enable representation of non-integer values.
		- The single numeral represents the value 1, not the value 0=b-1.
		- The value 0 cannot be represented (or is implicitly represented by an empty digit string).
	Examples (and equivalent decimal notation)
		1r1 = 10r1
		1r11 = 10r2
		1r111 = 10r3
		1r = 10r0
	"

	| digit value neg |
	neg _ aStream peekFor: $-.
	neg ifFalse: [aStream peekFor: $+].
	value _ 0.
	[ aStream atEnd ]
		whileFalse: [ 
			digit _ aStream next digitValue.
			digit = 1
				ifTrue: [value _ value + digit]
				ifFalse: [
					aStream skip: -1.
					neg ifTrue: [^ value negated].
					^ value]].
	neg ifTrue: [ ^ value negated ].
	^ value! !

!Integer class methodsFor: 'instance creation'!
readFrom: aStream 
	"Answer a new Integer as described on the stream, aStream.
	Embedded radix specifiers not allowed - use Number readFrom: for that."
	^self readFrom: aStream base: 10! !

!Integer class methodsFor: 'instance creation' stamp: 'GC 9/10/2018 00:18:57'!
readFrom: aStream base: base
	"Answer an instance of one of my concrete subclasses. Initial minus sign
	accepted, and bases > 10 use letters A-Z. Embedded radix specifiers not
	allowed--use Number readFrom: for that. Raises an error if
	there are no digits."

	| digit value neg cc atLeastOneDigitRead |
	
	(aStream atEnd) ifTrue: [ self error: 'At least one digit expected here' ].
	
	neg _ aStream peekFor: $-.
	neg ifFalse: [aStream peekFor: $+].
	value _ 0.
	atLeastOneDigitRead _ false.
	[ aStream atEnd ]
		whileFalse: [
			cc _ aStream next.
			digit _ cc digitValue.
			(digit < 0 or: [digit >= base])
				ifTrue: [
					aStream skip: -1.
					atLeastOneDigitRead ifFalse: [self error: 'At least one digit expected here'].
					^neg
						ifTrue: [value negated]
						ifFalse: [value]].
			value _ value * base + digit.
			atLeastOneDigitRead _ true ].
	neg ifTrue: [^ value negated].
	^ value! !


!Integer class methodsFor: 'prime numbers' stamp: 'ar 10/6/2001 19:34'!
largePrimesUpTo: maxValue
	"Compute and return all the prime numbers up to maxValue"
	^Array streamContents:[:s| self largePrimesUpTo: maxValue do:[:prime| s nextPut: prime]]! !

!Integer class methodsFor: 'prime numbers' stamp: 'nice 6/15/2011 00:21'!
largePrimesUpTo: max do: aBlock
	"Evaluate aBlock with all primes up to maxValue.
	The Algorithm is adapted from http://www.rsok.com/~jrm/printprimes.html
	It encodes prime numbers much more compactly than #primesUpTo: 
	38.5 integer per byte (2310 numbers per 60 byte) allow for some fun large primes.
	(all primes up to SmallInteger maxVal can be computed within ~27MB of memory;
	the regular #primesUpTo: would require 4 *GIGA*bytes).
	Note: The algorithm could be re-written to produce the first primes (which require
	the longest time to sieve) faster but only at the cost of clarity."

	| limit flags maskBitIndex bitIndex maskBit byteIndex index primesUpTo2310 indexLimit |
	limit := max asInteger - 1.
	indexLimit := max asInteger sqrtFloor + 1.
	"Create the array of flags."
	flags := ByteArray new: (limit + 2309) // 2310 * 60 + 60.
	flags atAllPut: 16rFF. "set all to true"

	"Compute the primes up to 2310"
	primesUpTo2310 := self primesUpTo: 2310.

	"Create a mapping from 2310 integers to 480 bits (60 byte)"
	maskBitIndex := Array new: 2310.
	bitIndex := -1. "for pre-increment"
	maskBitIndex at: 1 put: (bitIndex := bitIndex + 1).
	maskBitIndex at: 2 put: (bitIndex := bitIndex + 1).

	1 to: 5 do:[:i| aBlock value: (primesUpTo2310 at: i)].

	index := 6.
	2 to: 2309 do:[:n|
		[(primesUpTo2310 at: index) < n] 
			whileTrue:[index := index + 1].
		n = (primesUpTo2310 at: index) ifTrue:[
			maskBitIndex at: n+1 put: (bitIndex := bitIndex + 1).
		] ifFalse:[
			"if modulo any of the prime factors of 2310, then could not be prime"
			(n \\ 2 = 0 or:[n \\ 3 = 0 or:[n \\ 5 = 0 or:[n \\ 7 = 0 or:[n \\ 11 = 0]]]]) 
				ifTrue:[maskBitIndex at: n+1 put: 0]
				ifFalse:[maskBitIndex at: n+1 put: (bitIndex := bitIndex + 1)].
		].
	].

	"Now the real work begins...
	Start with 13 since multiples of 2,3,5,7,11 are handled by the storage method;
	increment by 2 for odd numbers only."
	13 to: limit by: 2 do:[:n|
		(maskBit := maskBitIndex at: (n \\ 2310 + 1)) = 0 ifFalse:["not a multiple of 2,3,5,7,11"
			byteIndex := n // 2310 * 60 + (maskBit-1 bitShift: -3) + 1.
			bitIndex := 1 bitShift: (maskBit bitAnd: 7).
			((flags at: byteIndex) bitAnd: bitIndex) = 0 ifFalse:["not marked -- n is prime"
				aBlock value: n.
				"Start with n*n since any integer < n has already been sieved 
				(e.g., any multiple of n with a number k < n has been cleared 
				when k was sieved); add 2 * i to avoid even numbers and
				mark all multiples of this prime. Note: n < indexLimit below
				limits running into LargeInts -- nothing more."
				n < indexLimit ifTrue:[
					index := n * n.
					[index <= limit] whileTrue:[
						(maskBit := maskBitIndex at: (index \\ 2310 + 1)) = 0 ifFalse:[
							byteIndex := (index // 2310 * 60) + (maskBit-1 bitShift: -3) + 1.
							maskBit := 255 - (1 bitShift: (maskBit bitAnd: 7)).
							flags at: byteIndex put: ((flags at: byteIndex) bitAnd: maskBit).
						].
						index := index + (2 * n)].
				].
			].
		].
	].
! !

!Integer class methodsFor: 'prime numbers' stamp: 'ar 10/6/2001 19:33'!
primesUpTo: max
	"Return a list of prime integers up to the given integer."
	"Integer primesUpTo: 100"
	^Array streamContents:[:s| self primesUpTo: max do:[:prime| s nextPut: prime]]! !

!Integer class methodsFor: 'prime numbers' stamp: 'nice 6/17/2011 02:21'!
primesUpTo: max do: aBlock
	"Compute aBlock with all prime integers up to the given integer."
	"Integer primesUpTo: 100"

	| index limit limitSqrtFloor sieve increment |
	limit := max asInteger.
	limit <= 1 ifTrue: [ ^self ].
	"Fall back into #largePrimesUpTo:do: if we'd require more than 100k of memory; 
	the alternative will only requre 1/154th of the amount we need here and is almost as fast."
	limit > 25000 ifTrue:[ ^self largePrimesUpTo: limit do: aBlock ].
	limit := limit - 1. "upTo:"
	sieve := Array new: limit withAll: true.
	sieve at: 1 put: false.
	index := 2.
	limitSqrtFloor := limit sqrtFloor.
	increment := 1.
	[ index <= limitSqrtFloor ] whileTrue: [
		(sieve at: index) ifTrue: [
			| notPrimeIndex notPrimeIncrement |
			aBlock value: index.
			notPrimeIndex := index * index.
			notPrimeIncrement := increment * index.
			[ notPrimeIndex <= limit ] whileTrue: [
				sieve at: notPrimeIndex put: false.
				notPrimeIndex := notPrimeIndex + notPrimeIncrement ] ].
		index := index + increment.
		increment := 2].
	[ index <= limit ] whileTrue: [
		(sieve at: index) ifTrue: [
			aBlock value: index ].
		index := index + increment.
		increment := 2]! !

!Integer class methodsFor: 'prime numbers' stamp: 'ar 10/6/2001 19:33'!
verbosePrimesUpTo: max
	"Integer verbosePrimesUpTo: SmallInteger maxVal" "<- heh, heh"
	"Compute primes up to max, but be verbose about it"
	^Array streamContents:[:s| self verbosePrimesUpTo: max do:[:prime| s nextPut: prime]].! !

!Integer class methodsFor: 'prime numbers' stamp: 'jmv 7/17/2017 15:44:55'!
verbosePrimesUpTo: max do: aBlock
	"Integer verbosePrimesUpTo: SmallInteger maxVal" "<- heh, heh"
	"Compute primes up to max, but be verbose about it"
	| lastTime |
	lastTime := Time localMillisecondClock.
	Utilities informUserDuring: [ :barBlock|
		barBlock value:'Computing primes...'.
		self primesUpTo: max do: [ :prime| | nowTime |
			aBlock value: prime.
			nowTime := Time localMillisecondClock.
			(nowTime - lastTime > 1000) ifTrue:[
				lastTime := nowTime.
				barBlock value: 'Last prime found: ', prime printString]]].! !
