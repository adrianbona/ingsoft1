!classDefinition: #TestNumerosRomanos category: #NumerosRomanos!
TestCase subclass: #TestNumerosRomanos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosRomanos'!

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:00:52'!
test01

	self assert: 'I' equals: 1 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:02:56'!
test02

	self assert: 'II' equals: 2 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:06:25'!
test03

	self assert: 'III' equals: 3 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:21:55'!
test04

	self assert: 'IV' equals: 4 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:42:30'!
test05

	self assert: 'V' equals: 5 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:46:31'!
test06

	self assert: 'VI' equals: 6 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:54:31'!
test07

	self assert: 'VII' equals: 7 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:56:51'!
test08

	self assert: 'VIII' equals: 8 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'Clase ISW1 5/2/2019 20:59:28'!
test09

	self assert: 'IX' equals: 9 asRomanString! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'AB 5/5/2019 21:14:40'!
test10to19

	self assert: 'X' equals: 10 asRomanString.
	self assert: 'XI' equals: 11 asRomanString.
	self assert: 'XII' equals: 12 asRomanString.
	self assert: 'XIII' equals: 13 asRomanString.
	self assert: 'XIV' equals: 14 asRomanString.
	self assert: 'XV' equals: 15 asRomanString.
	self assert: 'XVI' equals: 16 asRomanString.
	self assert: 'XVII' equals: 17 asRomanString.
	self assert: 'XVIII' equals: 18 asRomanString.
	self assert: 'XIX' equals: 19 asRomanString.! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'AB 5/5/2019 21:15:03'!
test20to29

	self assert: 'XX' equals: 20 asRomanString.
	self assert: 'XXI' equals: 21 asRomanString.
	self assert: 'XXII' equals: 22 asRomanString.
	self assert: 'XXIII' equals: 23 asRomanString.
	self assert: 'XXIV' equals: 24 asRomanString.
	self assert: 'XXV' equals: 25 asRomanString.
	self assert: 'XXVI' equals: 26 asRomanString.
	self assert: 'XXVII' equals: 27 asRomanString.
	self assert: 'XXVIII' equals: 28 asRomanString.
	self assert: 'XXIX' equals: 29 asRomanString.
! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'AB 5/5/2019 21:17:04'!
test30to39

	self assert: 'XXX' equals: 30 asRomanString.
	self assert: 'XXXI' equals: 31 asRomanString.
	self assert: 'XXXII' equals: 32 asRomanString.
	self assert: 'XXXIII' equals: 33 asRomanString.
	self assert: 'XXXIV' equals: 34 asRomanString.
	self assert: 'XXXV' equals: 35 asRomanString.
	self assert: 'XXXVI' equals: 36 asRomanString.
	self assert: 'XXXVII' equals: 37 asRomanString.
	self assert: 'XXXVIII' equals: 38 asRomanString.
	self assert: 'XXXIX' equals: 39 asRomanString.
! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'AB 5/5/2019 21:16:22'!
test40to49

	self assert: 'XL' equals: 40 asRomanString.
	self assert: 'XLI' equals: 41 asRomanString.
	self assert: 'XLII' equals: 42 asRomanString.
	self assert: 'XLIII' equals: 43 asRomanString.
	self assert: 'XLIV' equals: 44 asRomanString.
	self assert: 'XLV' equals: 45 asRomanString.
	self assert: 'XLVI' equals: 46 asRomanString.
	self assert: 'XLVII' equals: 47 asRomanString.
	self assert: 'XLVIII' equals: 48 asRomanString.
	self assert: 'XLIX' equals: 49 asRomanString.! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'AB 5/5/2019 21:46:57'!
test50to99

	self assert: 'L' equals: 50 asRomanString.
	self assert: 'LXIII' equals: 63 asRomanString.
	self assert: 'LXXIV' equals: 74 asRomanString.
	self assert: 'LXXXV' equals: 85 asRomanString.
	self assert: 'LXXXVIII' equals: 88 asRomanString.
	self assert: 'LXXXIX' equals: 89 asRomanString.
	self assert: 'XCIII' equals: 93 asRomanString.
	self assert: 'XCIX' equals: 99 asRomanString.! !

!TestNumerosRomanos methodsFor: 'as yet unclassified' stamp: 'AB 5/5/2019 21:16:41'!
testCanNotGetRomansStringOf0
	
	self should: [ 0 asRomanString ] raise: Error! !
