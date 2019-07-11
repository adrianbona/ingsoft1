!classDefinition: #TLCartWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLCartWindow
	instanceVariableNames: 'catalog client password cartStatus clientId cartId booksAmountTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLCartWindow methodsFor: 'initialization' stamp: 'AB 7/11/2019 09:18:22'!
initializeAfterChoosingModelFor: aClientId using: aPassword

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'Add books to shopping cart #' , model cartId printString.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.

	clientId _ aClientId.
	password _ aPassword.

	self model when: #catalogArrived send: #refreshCatalogList to: self.
	self model when: #cartUpdated send: #refreshCartContents to: self.
	
	self model when: #proceedToCheckOut send: #proceedToCheckOut to: self.
	self model when: #updateBooksAmount send: #updateBooksAmount to: self.

	self model when: #noBooksSelected send: #noBooksSelected to: self.
	self model when: #noBooksInCart send: #noBooksInCart to: self.
	
	self refreshCartContents.! !

!TLCartWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 17:04:04'!
initializeFor: aClientId using: aPassword

	self model: (TLCartWindowModel for: aClientId using: aPassword).

	self initializeAfterChoosingModelFor: aClientId using: aPassword! !

!TLCartWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 17:03:44'!
initializeFor: aClientId using: aPassword with: aCartId

	self model: (TLCartWindowModel for: aClientId using: aPassword with: aCartId).

	self initializeAfterChoosingModelFor: aClientId using: aPassword! !


!TLCartWindow methodsFor: 'events' stamp: 'AB 7/10/2019 16:53:15'!
closeButtonClicked

	TLDashboardWindow openFor: clientId using: password.
	
	self delete! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/10/2019 11:04:17'!
noBooksInCart

	cartStatus contents: 'Can not check out with an empty shopping cart'! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/11/2019 08:55:44'!
noBooksSelected

	cartStatus contents: 'Needs to select an item from catalog with a positive amount'! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/10/2019 16:53:32'!
proceedToCheckOut

	TLCheckOutWindow openFor: clientId using: password with: self model cartId.

	self delete! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/11/2019 00:32:04'!
refreshCartContents

	cartStatus contents: self model cartContents! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/11/2019 08:45:33'!
refreshCatalogList

	catalog updateList.

	catalog setSelectionIndex: 0! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/11/2019 09:25:17'!
updateBooksAmount

	booksAmountTextBox editor actualContents: self model booksAmount! !


!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/11/2019 00:04:45'!
build1stRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.
	rowLayout padding: #center;
	addMorph: (StringMorph contents: 'Select items from catalog').

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/11/2019 09:20:26'!
build2ndRow

	| rowLayout increaseBooksAmount decreaseBooksAmount |

	catalog _ PluggableListMorph model: self model listGetter: #catalog indexGetter: #catalogIndex indexSetter: #catalogIndex:.
	catalog  borderColor: Color skyBlue; morphExtent: 165@70; borderWidth: 1.

	booksAmountTextBox _ TextModelMorph textProvider: self model textGetter: #booksAmount textSetter: #booksAmount:.
	booksAmountTextBox textMorph setProperty: #keyStroke: toValue: [ :key | booksAmountTextBox textMorph acceptContents ].
	booksAmountTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 30@30; emptyTextDisplayMessage: ''.

	increaseBooksAmount _ PluggableButtonMorph model: self model stateGetter: nil action: #increaseBooksAmount label: '+'.
	decreaseBooksAmount _ PluggableButtonMorph model: self model stateGetter: nil action: #decreaseBooksAmount label: '-'.

	rowLayout _ LayoutMorph newRow.
	rowLayout separation: 15;
	padding: #center;
	addMorph: (StringMorph contents: 'Catalog');
	addMorph: catalog;
	addMorph: (StringMorph contents: 'Amount');
	addMorph: booksAmountTextBox;
	addMorph: increaseBooksAmount;
	addMorph: decreaseBooksAmount.

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/11/2019 09:36:34'!
build3rdRow

	| rowLayout addToCartButton |

	addToCartButton _ PluggableButtonMorph model: self model stateGetter: nil action: #addSelectedBookToCart label: 'Add to Shopping Cart'.

	rowLayout _ LayoutMorph newRow.
	rowLayout separation: 15;
	padding: #center;
	addMorph: addToCartButton.

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/11/2019 08:14:45'!
build4thRow

	| rowLayout |

	cartStatus _ StringMorph contents: ''.

	rowLayout _ LayoutMorph newRow.
	rowLayout padding: #center;
	addMorph: cartStatus.

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/11/2019 08:49:08'!
build5thRow

	| rowLayout addToCartButton goBackButton |

	addToCartButton _ PluggableButtonMorph model: self model stateGetter: nil action: #checkOutCart label: 'Proceed to Check out'.
	goBackButton _ PluggableButtonMorph model: self stateGetter: nil action: #closeButtonClicked label: 'Go Back'.

	rowLayout _ LayoutMorph newRow.
	rowLayout separation: 15;
	padding: #center;
	addMorph: addToCartButton;
	addMorph: goBackButton.

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/11/2019 08:15:45'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #center;

	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: self build4thRow;
	addMorph: self build5thRow.! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/11/2019 08:17:04'!
defaultExtent

	^ 650 @ 450! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLCartWindow class' category: #'TusLibros.com-Client Server'!
TLCartWindow class
	instanceVariableNames: ''!

!TLCartWindow class methodsFor: 'instance creation' stamp: 'AB 7/8/2019 16:26:03'!
openFor: aClient using: aPassword
	
	^ self new initializeFor: aClient using: aPassword! !

!TLCartWindow class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 16:58:59'!
openFor: aClient using: aPassword with: aCartId
	
	^ self new initializeFor: aClient using: aPassword with: aCartId! !


!classDefinition: #TLCheckOutWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLCheckOutWindow
	instanceVariableNames: 'creditCardNumberTextBox expirationMonthTextBox expirationYearTextBox ownersNameTextBox clientId cartId password paymentStatus processPaymentButton goBackButton'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLCheckOutWindow methodsFor: 'events' stamp: 'AB 7/10/2019 16:56:58'!
backToDashboard

	TLDashboardWindow openFor: clientId using: password.

	self delete! !

!TLCheckOutWindow methodsFor: 'events' stamp: 'AB 7/10/2019 16:57:34'!
closeButtonClicked

	TLCartWindow openFor: clientId using: password with: cartId.

	self delete! !

!TLCheckOutWindow methodsFor: 'events' stamp: 'AB 7/11/2019 01:21:10'!
paymentDone

	paymentStatus contents: model paymentResponse.
	creditCardNumberTextBox disableEditing; borderColor: Color green.
	expirationMonthTextBox disableEditing; borderColor: Color green.
	expirationYearTextBox disableEditing; borderColor: Color green.
	ownersNameTextBox disableEditing; borderColor: Color green.

	TLPurchasesWindow openFor: clientId using: password.

	processPaymentButton model: self stateGetter: nil action: #backToDashboard label: 'Go back to dashboard'.
	goBackButton delete.! !

!TLCheckOutWindow methodsFor: 'events' stamp: 'AB 7/10/2019 16:32:14'!
showPaymentStatus

	paymentStatus contents: model paymentResponse.
	creditCardNumberTextBox borderColor: Color red.
	expirationMonthTextBox borderColor: Color red.
	expirationYearTextBox borderColor: Color red.
	ownersNameTextBox borderColor: Color red.! !


!TLCheckOutWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 16:28:44'!
initializeFor: aClientId using: aPassword with: aCartId

	self titleMorph showButtonsNamed: #(close collapse).
	self setLabel: 'Shopping Cart Check Out'.
	self model: (TLCheckOutWindowModel for: aClientId using: aPassword with: aCartId).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	clientId _ aClientId.
	password _ aPassword.
	cartId _ aCartId.
	
	self model when: #paymentDone send: #paymentDone to: self.
	self model when: #paymentRevoked send: #showPaymentStatus to: self.
! !

!TLCheckOutWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 12:41:28'!
initializeFor: aClient using: aPassword with: aCartId from: aPanel

	aPanel closeButtonClicked.
	
	self initializeFor: aClient using: aPassword with: aCartId! !


!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:17:58'!
build1stRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.

	rowLayout separation: 15;
	addMorph: (StringMorph contents: 'Enter your credit card details');
	padding: #left.
	
	^ rowLayout! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:17:07'!
build2ndRow

	| rowLayout |
	
	rowLayout _ LayoutMorph newRow.
	
	creditCardNumberTextBox _ TextModelMorph textProvider: self model textGetter: #creditCardNumber textSetter: #creditCardNumber:.
	creditCardNumberTextBox textMorph setProperty: #keyStroke: toValue: [ :key | creditCardNumberTextBox textMorph acceptContents ].
	creditCardNumberTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: '16 digits number'.

	rowLayout separation: 15;
	addMorph: (StringMorph contents:'Enter number');
	addMorph: creditCardNumberTextBox;
	padding: #left.

	^ rowLayout! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:16:59'!
build3rdRow

	| rowLayout |
	
	rowLayout _ LayoutMorph newRow.
	
	expirationMonthTextBox _ TextModelMorph textProvider: self model textGetter: #creditCardExpirationMonth textSetter: #creditCardExpirationMonth:. 
	expirationMonthTextBox textMorph setProperty: #keyStroke: toValue: [ :key | expirationMonthTextBox textMorph acceptContents ].
	expirationMonthTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: 'Two digits for month'.
	
	rowLayout separation: 15;
	addMorph: (StringMorph contents:'Enter expiration month');
	addMorph: expirationMonthTextBox;
	padding: #left.

	^ rowLayout! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:16:50'!
build4thRow

	| rowLayout |
	
	rowLayout _ LayoutMorph newRow.
	
	expirationYearTextBox _ TextModelMorph textProvider: self model textGetter: #creditCardExpirationYear textSetter: #creditCardExpirationYear:. 
	expirationYearTextBox textMorph setProperty: #keyStroke: toValue: [ :key | expirationYearTextBox textMorph acceptContents ].
	expirationYearTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: 'Four digits for year'.
	
	rowLayout separation: 15;
	addMorph: (StringMorph contents:'Enter expiration year');
	addMorph: expirationYearTextBox;
	padding: #left.

	^ rowLayout! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:16:40'!
build5thRow

	| rowLayout |
	
	rowLayout _ LayoutMorph newRow.
	
	ownersNameTextBox _ TextModelMorph textProvider: self model textGetter: #creditCardOwnerName textSetter: #creditCardOwnerName:. 
	ownersNameTextBox textMorph setProperty: #keyStroke: toValue: [ :key | ownersNameTextBox textMorph acceptContents ].
	ownersNameTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: 'Owner name'.
	
	rowLayout separation: 15;
	addMorph: (StringMorph contents:'Enter name');
	addMorph: ownersNameTextBox;
	padding: #left.

	^ rowLayout! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:17:51'!
build6thRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.

	paymentStatus _ StringMorph contents: ''.

	rowLayout separation: 15;
	addMorph: paymentStatus;
	padding: #left.
	
	^ rowLayout! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:17:42'!
build7thRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.

	processPaymentButton _ PluggableButtonMorph model: self model stateGetter: nil action: #processPayment label: 'Process Payment'.

	goBackButton _ PluggableButtonMorph model: self stateGetter: nil action: #closeButtonClicked label: 'Back to cart'.

	rowLayout separation: 15;
 	addMorph: processPaymentButton;
	addMorph: goBackButton;
	padding: #left.
	
	^ rowLayout! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:18:38'!
buildMorphicWindow

	self layoutMorph beColumn;
	padding: #left;

	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: self build4thRow;
	addMorph: self build5thRow;
	addMorph: self build6thRow;
	addMorph: self build7thRow! !

!TLCheckOutWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 17:44:53'!
defaultExtent

	^ 700 @ 400! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLCheckOutWindow class' category: #'TusLibros.com-Client Server'!
TLCheckOutWindow class
	instanceVariableNames: ''!

!TLCheckOutWindow class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 12:40:12'!
openFor: aClient using: aPassword with: aCartId

	^ self new initializeFor: aClient using: aPassword with: aCartId! !


!classDefinition: #TLDashboardWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLDashboardWindow
	instanceVariableNames: 'listPurchasesButton createCartButton password clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLDashboardWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 19:06:46'!
initializeFor: aClientId using: aPassword

	self titleMorph showButtonsNamed: #(close collapse).
	self setLabel: 'Dashboard'.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	clientId _ aClientId.
	password _ aPassword! !


!TLDashboardWindow methodsFor: 'events' stamp: 'AB 7/10/2019 19:06:46'!
createCart

	TLCartWindow openFor: clientId using: password.
	
	self delete! !

!TLDashboardWindow methodsFor: 'events' stamp: 'AB 7/10/2019 19:06:46'!
listPurchases

	TLPurchasesWindow openFor: clientId using: password.
	
	self delete! !


!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 20:18:31'!
build1stRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.

	rowLayout separation: 15;
	addMorph: (StringMorph contents: 'Welcome to Tus Libros App');
	padding: #center.
	
	^ rowLayout! !

!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:07:55'!
build2ndRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.

	createCartButton _ PluggableButtonMorph model: self stateGetter: nil action: #createCart label: 'Start Shopping'.

	rowLayout separation: 15;
 	addMorph: createCartButton;
	padding: #center.
	
	^ rowLayout! !

!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:07:35'!
build3rdRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.

	listPurchasesButton _ PluggableButtonMorph model: self stateGetter: nil action: #listPurchases label: 'List Purchases'.

	rowLayout separation: 15;
 	addMorph: listPurchasesButton;
	padding: #center.
	
	^ rowLayout! !

!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:09:07'!
buildMorphicWindow

	self layoutMorph beColumn;
	padding: #center;

	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow! !

!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:00:17'!
defaultExtent

	^ 250 @ 250! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLDashboardWindow class' category: #'TusLibros.com-Client Server'!
TLDashboardWindow class
	instanceVariableNames: ''!

!TLDashboardWindow class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 19:10:21'!
openFor: aClientId using: aPassword
	
	^ self new initializeFor: aClientId using: aPassword! !


!classDefinition: #TLLoginWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLLoginWindow
	instanceVariableNames: 'clientIdTextBox passwordTextBox resultLabel submitButton openDashboard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLLoginWindow methodsFor: 'events' stamp: 'AB 7/11/2019 09:41:24'!
updateLogIn

	resultLabel contents: model loginResponse.
	clientIdTextBox disableEditing; borderColor: Color green.
	passwordTextBox disableEditing; borderColor: Color green.

	submitButton model: self model stateGetter: nil action: #submitLogOut label: 'Log out'.
	
	openDashboard _ TLDashboardWindow openFor: self model clientId using: self model password! !

!TLLoginWindow methodsFor: 'events' stamp: 'AB 7/11/2019 09:41:18'!
updateLogOut

	resultLabel contents: ''.
	clientIdTextBox enableEditing; borderColor: Color skyBlue.
	clientIdTextBox editor actualContents: ''.

	passwordTextBox enableEditing; borderColor: Color skyBlue.
	passwordTextBox editor actualContents: ''.
	
	submitButton model: self model stateGetter: nil action: #submitLogIn label: 'Login'.
	openDashboard ifNotNil: [ openDashboard closeButtonClicked ]! !

!TLLoginWindow methodsFor: 'events' stamp: 'AB 7/7/2019 19:12:43'!
wrongCredentials

	resultLabel contents: model loginResponse.
	clientIdTextBox borderColor: Color red.
	passwordTextBox borderColor: Color red! !


!TLLoginWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 09:27:41'!
initialize

	super initialize.
	
	self titleMorph showButtonsNamed: #(close collapse).
	self setLabel: 'Login to start shopping'.
	self model: (TLLoginWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.

	self model when: #credentialsReceived send: #updateLogIn to: self.
	self model when: #credentialsRemoved send: #updateLogOut to: self.
	self model when: #wrongCredentials send: #wrongCredentials to: self! !


!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:23:12'!
build1stRow

	| rowLayout |
	
	rowLayout _ LayoutMorph newRow.
	
	clientIdTextBox _ TextModelMorph textProvider: self model textGetter: #clientId textSetter: #clientId:.
	clientIdTextBox textMorph setProperty: #keyStroke: toValue: [ :key | clientIdTextBox textMorph acceptContents ].
	clientIdTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: 'Client ID'.

	rowLayout separation: 25;
	addMorph: (StringMorph contents: 'Enter Client ID');
	addMorph: clientIdTextBox;
	padding: #left.

	^ rowLayout! !

!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:22:58'!
build2ndRow

	| rowLayout |
	
	rowLayout _ LayoutMorph newRow.
	
	passwordTextBox _ TextModelMorph textProvider: self model textGetter: #password textSetter: #password:. 
	passwordTextBox textMorph setProperty: #keyStroke: toValue: [ :key | passwordTextBox textMorph acceptContents ].
	passwordTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: 'Password'.
	
	rowLayout separation: 25;
	addMorph: (StringMorph contents:'Enter Password');
	addMorph: passwordTextBox;
	padding: #left.

	^ rowLayout! !

!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 19:22:50'!
build3rdRow

	| rowLayout closeButton |

	rowLayout _ LayoutMorph newRow.

	submitButton _ PluggableButtonMorph model: self model stateGetter: nil action: #submitLogIn label: 'Login'.

	closeButton _ PluggableButtonMorph model: self stateGetter: nil action: #closeButtonClicked label: 'Exit'.

	resultLabel _ StringMorph contents: ''.

	rowLayout separation: 25;
	addMorph: submitButton;
	addMorph: closeButton;
	addMorph: resultLabel;
	padding: #left.
	
	^ rowLayout! !

!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/7/2019 17:01:44'!
buildMorphicWindow

	self layoutMorph beColumn;
	padding: #left;

	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow! !

!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/7/2019 17:00:46'!
defaultExtent

	^ 450 @ 250! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLLoginWindow class' category: #'TusLibros.com-Client Server'!
TLLoginWindow class
	instanceVariableNames: ''!

!TLLoginWindow class methodsFor: 'instance creation' stamp: 'AB 7/7/2019 15:22:58'!
open
	
	^ self new! !


!classDefinition: #TLPurchasesWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLPurchasesWindow
	instanceVariableNames: 'purchasesList clientId password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLPurchasesWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 10:32:26'!
initializeFor: aClientId using: aPassword

	self titleMorph showButtonsNamed: #(close collapse).
	self setLabel: 'Client Purchases'.
	self model: (TLPurchasesWindowModel for: aClientId using: aPassword).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	clientId _ aClientId.
	password _ aPassword.! !

!TLPurchasesWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 10:31:57'!
initializeFor: aClient using: aPassword from: aPanel

	aPanel closeButtonClicked.

	self initializeFor: aClient using: aPassword! !


!TLPurchasesWindow methodsFor: 'graphic user interface' stamp: 'JR 7/8/2019 00:02:22'!
build1stRow

	| firstRowLayout |

	purchasesList _ TextModelMorph withText: self model purchasesList.

	firstRowLayout _ LayoutMorph newRow.

	firstRowLayout separation: 25;
 	addMorph: purchasesList;
	padding: #center.
	
	^ firstRowLayout! !

!TLPurchasesWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 21:13:35'!
buildMorphicWindow

	self layoutMorph beColumn;
	padding: #left;
	addMorph: self build1stRow! !

!TLPurchasesWindow methodsFor: 'graphic user interface' stamp: 'JR 7/7/2019 23:25:51'!
defaultExtent

	^ 350 @ 350! !


!TLPurchasesWindow methodsFor: 'events' stamp: 'AB 7/10/2019 21:13:41'!
closeButtonClicked

	TLDashboardWindow openFor: clientId using: password.

	self delete! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLPurchasesWindow class' category: #'TusLibros.com-Client Server'!
TLPurchasesWindow class
	instanceVariableNames: ''!

!TLPurchasesWindow class methodsFor: 'instance creation' stamp: 'AB 7/8/2019 16:25:47'!
openFor: aClient using: aPassword
	
	^ self new initializeFor: aClient using: aPassword! !


!classDefinition: #TLCartWindowModel category: #'TusLibros.com-Client Server'!
Object subclass: #TLCartWindowModel
	instanceVariableNames: 'selectedIndex webClient catalog cartId cartContents booksAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/11/2019 08:30:38'!
booksAmount

	^ booksAmount! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/11/2019 08:30:25'!
booksAmount: anAmount

	booksAmount _ anAmount! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/9/2019 15:10:15'!
cartContents

	^ cartContents! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/8/2019 17:28:23'!
cartId

	^ cartId! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 23:51:22'!
catalog
	
	^ catalog value! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/8/2019 16:27:43'!
catalogIndex

	^ selectedIndex! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/8/2019 16:27:37'!
catalogIndex: anIndex

	selectedIndex _ anIndex! !


!TLCartWindowModel methodsFor: 'initialization' stamp: 'AB 7/11/2019 09:16:04'!
initializeFor: aClient using: aPassword

	selectedIndex _ 0.
	booksAmount _ '1'.
	catalog _ OrderedCollection new.
	webClient _ TLWebClient new.
	cartId _ self cartIdFor: aClient protectedWith: aPassword.
	cartContents _ 'Shopping cart is empty'.

	self sendCatalogRequest.! !

!TLCartWindowModel methodsFor: 'initialization' stamp: 'AB 7/11/2019 09:15:53'!
initializeFor: aClient using: aPassword with: aCartId

	selectedIndex _ 0.
	booksAmount _ '1'.
	catalog _ OrderedCollection new.
	webClient _ TLWebClient new.
	cartId _ aCartId.

	self updateCartStatus.
	self sendCatalogRequest.
! !


!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 08:53:16'!
addSelectedBookToCart

	(selectedIndex = 0)

	ifTrue: [
		self triggerEvent: #noBooksSelected with: self
	]
	ifFalse: [
		| book fromCatalog |

		fromCatalog _ catalog at: selectedIndex.
		book _ fromCatalog substrings at: 1.

		TLFuture of: [
			webClient addToCart: self cartId book: book quantity: booksAmount.
			self updateCartStatus
		]
	]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/10/2019 23:52:15'!
cartIdFor: aClientId protectedWith: aPassword

	| response |

	response _ TLFuture of: [ webClient createCartFor: aClientId  protectedWith: aPassword ].

	^  response value content! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 09:32:52'!
changeBooksAmountBy: aBlock

	aBlock on: Error do: [
		booksAmount _ 1 printString.
		self triggerEvent: #updateBooksAmount with: self
	]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/10/2019 21:06:21'!
checkOutCart
	
	| response |

	response _ webClient listCart: cartId.

	(response isCorrectAndNotEmpty)
	
		ifTrue: [ self triggerEvent: #proceedToCheckOut with: self ]

		ifFalse: [ self triggerEvent: #noBooksInCart with: self ]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 09:35:00'!
decreaseBooksAmount

	self changeBooksAmountBy: [
		(booksAmount asNumber > 1) ifTrue: [
			booksAmount _ (booksAmount asNumber - 1) printString.
			self triggerEvent: #updateBooksAmount with: self
		]
	]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 09:33:17'!
increaseBooksAmount

	self changeBooksAmountBy: [
		booksAmount _ (booksAmount asNumber + 1) printString.
		self triggerEvent: #updateBooksAmount with: self
	]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 00:22:24'!
sendCatalogRequest

	TLFuture of: [
		catalog _ webClient getCatalog.
		self triggerEvent: #catalogArrived with: self		
	]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 08:55:17'!
updateCartStatus

	TLFuture of: [
		| response |
		response _ webClient listCart: cartId.

		(response isCorrectAndNotEmpty)

		ifTrue: [
			cartContents _ response asCartContent.
			self triggerEvent: #cartUpdated with: self
		]
		ifFalse: [
			self triggerEvent: #noBooksSelected with: self
		].
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLCartWindowModel class' category: #'TusLibros.com-Client Server'!
TLCartWindowModel class
	instanceVariableNames: ''!

!TLCartWindowModel class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 17:08:56'!
for: aClientId using: aPassword

	^ self new initializeFor: aClientId using: aPassword! !

!TLCartWindowModel class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 16:50:33'!
for: aClient using: aPassword with: aCartId

	^ self new initializeFor: aClient using: aPassword with: aCartId! !


!classDefinition: #TLCheckOutWindowModel category: #'TusLibros.com-Client Server'!
Object subclass: #TLCheckOutWindowModel
	instanceVariableNames: 'creditCardNumber clientId password cartId creditCardExpirationMonth creditCardExpirationYear creditCardOwnerName webClient paymentResponse'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:55:48'!
creditCardExpirationMonth

	^ creditCardExpirationMonth! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:55:38'!
creditCardExpirationMonth: aCreditCardExpirationMonth

	creditCardExpirationMonth _ aCreditCardExpirationMonth! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:56:52'!
creditCardExpirationYear

	^ creditCardExpirationYear! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:57:12'!
creditCardExpirationYear: aCreditCardExpirationYear

	creditCardExpirationYear _ aCreditCardExpirationYear! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:49:37'!
creditCardNumber

	^ creditCardNumber! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:49:53'!
creditCardNumber: aCreditCardNumber

	creditCardNumber _ aCreditCardNumber! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:56:40'!
creditCardOwnerName

	^ creditCardOwnerName! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 12:56:31'!
creditCardOwnerName: aCreditCardOwnerName

	creditCardOwnerName _ aCreditCardOwnerName! !

!TLCheckOutWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 16:26:34'!
paymentResponse

	^ paymentResponse! !


!TLCheckOutWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 00:25:51'!
processPayment

	TLFuture of: [
		| response |
		response _ webClient checkOut: cartId 
		chargingToACreditCardNumbered: creditCardNumber 
		expiringOn: (creditCardExpirationMonth , creditCardExpirationYear) 
		ownedBy: creditCardOwnerName.

		(response isCorrect)
			ifTrue: [
				paymentResponse _ 'Payment was correctly processed'.
				self triggerEvent: #paymentDone with: self
			] ifFalse: [
				paymentResponse _ response content.
				self triggerEvent: #paymentRevoked with: self		
			]
	]! !


!TLCheckOutWindowModel methodsFor: 'initialization' stamp: 'AB 7/10/2019 16:26:34'!
initializeFor: aClientId using: aPassword with: aCartId

	clientId _ aClientId.
	password _ aPassword.
	cartId _ aCartId.
	
	paymentResponse _ ''.
	creditCardNumber _ ''.
	creditCardExpirationMonth _ ''.
	creditCardExpirationYear _ ''.
	creditCardOwnerName _ ''.
	
	webClient _ TLWebClient new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLCheckOutWindowModel class' category: #'TusLibros.com-Client Server'!
TLCheckOutWindowModel class
	instanceVariableNames: ''!

!TLCheckOutWindowModel class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 13:02:45'!
for: aClientId using: aPassword with: aCartId

	^ self new initializeFor: aClientId using: aPassword with: aCartId! !


!classDefinition: #TLLoginWindowModel category: #'TusLibros.com-Client Server'!
Object subclass: #TLLoginWindowModel
	instanceVariableNames: 'webClient loginResponse clientId password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLLoginWindowModel methodsFor: 'initialization' stamp: 'AB 7/10/2019 21:12:19'!
initialize

	webClient _ TLWebClient new.
	clientId _ ''.
	password _ ''! !


!TLLoginWindowModel methodsFor: 'events' stamp: 'AB 7/7/2019 18:02:37'!
loginResponse

	^ loginResponse! !

!TLLoginWindowModel methodsFor: 'events' stamp: 'AB 7/11/2019 00:26:55'!
submitLogIn

	TLFuture of: [
		| response |
		response _ webClient signIn: clientId with: password.

		(response isCorrect)
			ifTrue: [
				loginResponse _ 'Access granted'.
				self triggerEvent: #credentialsReceived with: self
			] ifFalse: [
				loginResponse _ response content.
				self triggerEvent: #wrongCredentials with: self		
			]
	]! !

!TLLoginWindowModel methodsFor: 'events' stamp: 'AB 7/7/2019 18:54:07'!
submitLogOut

	loginResponse _ ''.

	self triggerEvent: #credentialsRemoved with: self! !


!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/7/2019 15:33:58'!
clientId

	^ clientId! !

!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 21:12:00'!
clientId: aClientId

	clientId _ aClientId.

	^ true! !

!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/7/2019 15:34:06'!
password

	^ password! !

!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 21:12:26'!
password: aPassword

	password _ aPassword.

	^ true! !


!classDefinition: #TLPurchasesWindowModel category: #'TusLibros.com-Client Server'!
Object subclass: #TLPurchasesWindowModel
	instanceVariableNames: 'webClient purchasesList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLPurchasesWindowModel methodsFor: 'initialization' stamp: 'AB 7/10/2019 23:48:40'!
initializeFor: aClient using: aPassword

	webClient _ TLWebClient new.
	purchasesList _ TLFuture of: [ webClient listPurchasesFor: aClient with: aPassword ]! !


!TLPurchasesWindowModel methodsFor: 'accessing' stamp: 'AB 7/10/2019 23:48:48'!
purchasesList
	
	^ purchasesList value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLPurchasesWindowModel class' category: #'TusLibros.com-Client Server'!
TLPurchasesWindowModel class
	instanceVariableNames: ''!

!TLPurchasesWindowModel class methodsFor: 'instance creation' stamp: 'AB 7/8/2019 17:15:04'!
for: aClient using: aPassword

	^ self new initializeFor: aClient using: aPassword! !


!classDefinition: #TLServer category: #'TusLibros.com-Client Server'!
Object subclass: #TLServer
	instanceVariableNames: 'webServer port restInterface merchantProcessor priceList kerberos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLServer methodsFor: 'third party apps' stamp: 'AB 7/6/2019 16:28:45'!
debit: anAmount from: aCreditCard

	^ merchantProcessor value: anAmount value: aCreditCard! !

!TLServer methodsFor: 'third party apps' stamp: 'AB 7/6/2019 16:28:55'!
isRegisteredWith: aClientId and: aPassword

	^ kerberos value: aClientId value: aPassword! !


!TLServer methodsFor: 'enabling services' stamp: 'AB 7/6/2019 18:51:41'!
destroy
	
	webServer ifNotNil: [ webServer destroy ].! !

!TLServer methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:52:06'!
startListening
	
	webServer startListener ! !

!TLServer methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:52:12'!
stopListening
	
	webServer stopListener! !


!TLServer methodsFor: 'initialization' stamp: 'AB 7/7/2019 20:26:12'!
createEndPointName: endPoint executing: anActionBlock

	webServer addService: endPoint action: [ :request | self resolveWithDefaultErrorResponseFor: anActionBlock using: request ]
! !

!TLServer methodsFor: 'initialization' stamp: 'AB 7/10/2019 19:26:37'!
initialize

	kerberos _ [ :aClientId :aPassword | ].

	merchantProcessor _ [ :anAmount :aCreditCard | ].

	priceList _ StoreTestObjectsFactory new threeItemsPriceList.

	restInterface _ RestInterfaceExternal new initializewithCatalogue: priceList processingThrough: self signInUsersWith: self.

	self initializeServices! !

!TLServer methodsFor: 'initialization' stamp: 'AB 7/10/2019 16:37:44'!
initializeServices

	webServer _ WebServer new listenOn: self port.

	self createEndPointName: '/catalog' executing: [ :request |
		request send200Response: (WebUtils jsonEncode: restInterface catalog asArray)
	].

	self createEndPointName: '/loginClient' executing: [ :request |
		| clientId password |

		clientId _ (request fields at:'clientId').
		(clientId size = 0) ifTrue: [ self error: 'Missing Client ID' ].

		password _ (request fields at:'password').
		(password size = 0) ifTrue: [ self error: 'Missing password' ].

		request send200Response: (WebUtils jsonEncode: '0|OK')
	].

	self createEndPointName:  '/createCart' executing: [ :request |
		| clientId password |
		clientId _ (request fields at:'clientId').		
		password _ (request fields at:'password').
		request send200Response: (WebUtils jsonEncode: (restInterface createCartFor: clientId protectedWith: password))
	].

	self createEndPointName: '/addToCart'  executing: [ :request |
		| cartId bookIsbn bookQuantity |
		cartId _ (request fields at:'cartId') asInteger.
		bookIsbn _ (request fields at:'bookIsbn').
		bookQuantity _ (request fields at:'bookQuantity') asInteger.
		request send200Response: (WebUtils jsonEncode: (restInterface addTo: cartId anItemWithCode: bookIsbn aQuantityOf: bookQuantity))
	].

	self createEndPointName: '/listCart' executing: [ :request |
		| cartId |
		cartId _ (request fields at:'cartId') asInteger.
		request send200Response: (WebUtils jsonEncode: (restInterface listCart: cartId))
	].

	self createEndPointName: '/listPurchases'  executing: [ :request |
		| clientId password |
		clientId _ (request fields at:'clientId').		
		password _ (request fields at:'password').
		request send200Response: (WebUtils jsonEncode: (restInterface listPurchasesFor: clientId protectedBy: password))
	].

	self createEndPointName: '/checkOutCart' executing: [ :request |
		| cartId creditCardNumber expiration owner |
		cartId _ (request fields at:'cartId') asInteger.
		creditCardNumber _ (request fields at:'ccn').
		expiration _ (request fields at:'cced').
		owner _ (request fields at:'cco').
		request send200Response: (WebUtils jsonEncode: (restInterface checkOut: cartId chargingToACreditCardNumbered: creditCardNumber expiringOn: expiration ownedBy: owner))
	]! !

!TLServer methodsFor: 'initialization' stamp: 'AB 7/6/2019 18:52:02'!
port

	^ port ifNil: [ port _ 8080 ]! !

!TLServer methodsFor: 'initialization' stamp: 'AB 7/7/2019 20:26:12'!
resolveWithDefaultErrorResponseFor: aBlock using: aRequest

	[ aBlock value: aRequest ] on: Error do: [ :anError | aRequest send404Response: (WebUtils jsonEncode: ('1|' , anError messageText)) ]! !


!classDefinition: #TLWebClient category: #'TusLibros.com-Client Server'!
Object subclass: #TLWebClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/10/2019 20:50:09'!
addToCart: aCartId book: aBook

	| response |

	response _ WebClient htmlSubmit: (self url,'/addToCart') fields: { 'cartId' -> aCartId . 'bookIsbn' -> aBook . 'bookQuantity' -> 1 }.

	^ TLResponse wrapping: (WebUtils jsonDecode: ((response content) readStream))! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/11/2019 08:52:45'!
addToCart: aCartId book: aBook quantity: amount

	| response |

	response _ WebClient htmlSubmit: (self url,'/addToCart') fields: { 'cartId' -> aCartId . 'bookIsbn' -> aBook . 'bookQuantity' -> amount }.

	^ TLResponse wrapping: (WebUtils jsonDecode: ((response content) readStream))! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/10/2019 20:50:03'!
checkOut: aCartId chargingToACreditCardNumbered: aCreditCardNumber expiringOn: aMonthOfYear ownedBy: anOwnerName

	| response |

	response _ WebClient htmlSubmit: (self url,'/checkOutCart') fields: { 
		'cartId' -> aCartId. 
		'ccn' -> aCreditCardNumber.
		'cced' -> aMonthOfYear.
		'cco' -> anOwnerName.
	}.

	^ TLResponse wrapping: (WebUtils jsonDecode: ((response content) readStream))! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/10/2019 20:49:58'!
createCartFor: aClientId protectedWith: aPassword

	| response |

	response _ WebClient htmlSubmit: (self url,'/createCart') fields: { 'clientId' -> aClientId. 'password' -> aPassword }.

	^ TLResponse wrapping: ((WebUtils jsonDecode: ((response content) readStream)))! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/10/2019 20:49:47'!
getCatalog

	| response |

	response _ WebClient htmlSubmit: (self url,'/catalog') fields: {}.
	
	^ TLResponse wrapping: ((WebUtils jsonDecode: ((response content) readStream)) asOrderedCollection)! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/10/2019 20:49:41'!
listCart: cartId

	| response |

	response _ WebClient htmlSubmit: (self url,'/listCart') fields: { 'cartId' -> cartId }.

	^ TLResponse wrapping: (WebUtils jsonDecode: ((response content) readStream))! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/10/2019 20:49:35'!
listPurchasesFor: aClientId with: aPassword

	| response |

	response _ WebClient htmlSubmit: (self url,'/listPurchases') fields: { 'clientId' -> aClientId. 'password' -> aPassword }.

	^ TLResponse wrapping: (WebUtils jsonDecode: ((response content) readStream))! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/10/2019 20:47:01'!
signIn: aClientId with: aPassword

	| response |

	response _ WebClient htmlSubmit: (self url,'/logInClient') fields: { 'clientId' -> aClientId. 'password' -> aPassword }.

	^ TLResponse wrapping: (WebUtils jsonDecode: ((response content) readStream))! !


!TLWebClient methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:34:17'!
port

	^ port ifNil: [ port _ 8080 ]! !

!TLWebClient methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:34:22'!
url
	
	^ 'http://localhost:', self port asString! !


!TLWebClient methodsFor: 'format' stamp: 'NR 6/25/2019 22:25:36'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !


!classDefinition: #TLFuture category: #'TusLibros.com-Client Server'!
ProtoObject subclass: #TLFuture
	instanceVariableNames: 'readySemaphore value ready'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLFuture methodsFor: 'initialization' stamp: 'AB 7/10/2019 23:31:35'!
initializeOf: aBlock

	readySemaphore _ Semaphore new.
	ready _ false.
	
	[ value _ aBlock value.
	ready _ true.
	readySemaphore signal ] fork! !


!TLFuture methodsFor: 'evaluating' stamp: 'AB 7/10/2019 23:31:48'!
value

	ready ifFalse: [ readySemaphore wait ].

	^ value! !


!TLFuture methodsFor: 'message forwarding' stamp: 'AB 7/10/2019 23:31:12'!
doesNotUnderstand: aMessage

	^ aMessage sendTo: self value! !


!TLFuture methodsFor: 'object protocol' stamp: 'HAW 8/13/2017 18:12:56'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!TLFuture methodsFor: 'object protocol' stamp: 'HAW 5/12/2019 19:41:48'!
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

!TLFuture methodsFor: 'object protocol' stamp: 'HAW 8/13/2017 18:12:37'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLFuture class' category: #'TusLibros.com-Client Server'!
TLFuture class
	instanceVariableNames: ''!

!TLFuture class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:37:15'!
of: aBlock

	 ^self new initializeOf: aBlock! !


!classDefinition: #TLResponse category: #'TusLibros.com-Client Server'!
ProtoObject subclass: #TLResponse
	instanceVariableNames: 'response'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLResponse methodsFor: 'initialization' stamp: 'AB 7/10/2019 20:44:24'!
initializeWrapping: aWebUtilsResponse

	response _ aWebUtilsResponse! !


!TLResponse methodsFor: 'message handling' stamp: 'AB 7/10/2019 20:47:58'!
doesNotUnderstand: aMessage

	^aMessage sendTo: response! !


!TLResponse methodsFor: 'accessing' stamp: 'AB 7/11/2019 01:13:52'!
asCartContent

	| contentAsCollection parsedContent |

	contentAsCollection _ self content findBetweenSubStrs: '|'.

	parsedContent _ ''.

	1 to: contentAsCollection size by: 2 do: [ :position | 
		parsedContent _ parsedContent , (contentAsCollection at: position + 1) , ' copies of: ' , (contentAsCollection at: position).
		(position + 1 = contentAsCollection size) ifFalse: [ parsedContent _ parsedContent , ' / ' ] 
	].
	
	^ parsedContent! !

!TLResponse methodsFor: 'accessing' stamp: 'AB 7/10/2019 20:54:44'!
content

	^ response copyFrom: 3 to: response size! !

!TLResponse methodsFor: 'accessing' stamp: 'AB 7/10/2019 21:04:01'!
correctPrefix

	^ '0|'! !

!TLResponse methodsFor: 'accessing' stamp: 'AB 7/10/2019 21:05:38'!
errorPrefix

	^ '1|'! !

!TLResponse methodsFor: 'accessing' stamp: 'AB 7/10/2019 21:03:54'!
isCorrect

	^ (response copyFrom: 1 to: 2) = self correctPrefix! !

!TLResponse methodsFor: 'accessing' stamp: 'AB 7/10/2019 21:05:14'!
isCorrectAndNotEmpty

	^ self isCorrect and: self isEmpty not! !

!TLResponse methodsFor: 'accessing' stamp: 'AB 7/10/2019 21:05:01'!
isEmpty

	^ (response copyFrom: 1 to: response size) size = 2! !


!TLResponse methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:44:49'!
inspectorClass
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^ Inspector! !

!TLResponse methodsFor: 'inspecting' stamp: 'HAW 10/19/2017 16:45:07'!
instVarAt: index put: anObject
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	self primitiveFailed! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLResponse class' category: #'TusLibros.com-Client Server'!
TLResponse class
	instanceVariableNames: ''!

!TLResponse class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 20:43:52'!
wrapping: aWebUtilsResponse

	^ self new initializeWrapping: aWebUtilsResponse.! !
