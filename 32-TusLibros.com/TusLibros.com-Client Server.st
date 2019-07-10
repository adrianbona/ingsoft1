!classDefinition: #TLCartWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLCartWindow
	instanceVariableNames: 'catalog client password cartStatus fromPanel clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLCartWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 11:02:59'!
defaultExtent

	^ 500 @ 450! !

!TLCartWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 11:47:26'!
initializeFor: aClientId using: aPassword

	self titleMorph showButtonsNamed: #( close collapse ).
	self model: (TLCartWindowModel for: aClientId using: aPassword).
	self setLabel: 'Add books to shopping cart #' , model cartId.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.

	clientId _ aClientId.
	password _ aPassword.

	self model when: #catalogArrived send: #refreshCatalogList to: self.
	self model when: #cartUpdated send: #refreshCartContents to: self.
	
	self model when: #proceedToCheckOut send: #proceedToCheckOut to: self.

	self model when: #noBooksSelected send: #noBooksSelected to: self.
	self model when: #noBooksInCart send: #noBooksInCart to: self.! !

!TLCartWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 09:42:07'!
initializeFor: aClient using: aPassword from: aPanel

	aPanel closeButtonClicked.
	
	self initializeFor: aClient using: aPassword! !


!TLCartWindow methodsFor: 'events' stamp: 'AB 7/10/2019 10:28:51'!
closeButtonClicked

	TLDashboardWindow openFor: clientId using: password.
	self delete! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/10/2019 11:04:17'!
noBooksInCart

	cartStatus contents: 'Can not check out with an empty shopping cart'! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/10/2019 11:04:54'!
noBooksSelected

	cartStatus contents: 'Needs to select an item from catalog'! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/10/2019 11:46:56'!
proceedToCheckOut

	TLDashboardWindow openFor: clientId using: password.
	self delete! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/9/2019 15:18:36'!
refreshCartContents

	cartStatus contents: self model cartContents! !

!TLCartWindow methodsFor: 'events' stamp: 'AB 7/9/2019 15:15:05'!
refreshCatalogList

	catalog updateList.
	catalog setSelectionIndex: 0! !


!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:01:34'!
build1stRow

	| rowLayout |

	rowLayout _ LayoutMorph newRow.
	rowLayout padding: #center;
	addMorph: (StringMorph contents: 'Select and item from Catalog').

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:01:55'!
build2ndRow

	| rowLayout addToCartButton |

	addToCartButton _ PluggableButtonMorph model: self model stateGetter: nil action: #addSelectedBookToCart label: 'Add To Cart'.

	catalog _ PluggableListMorph model: self model listGetter: #catalog indexGetter: #catalogIndex indexSetter: #catalogIndex:.
	catalog  borderColor: Color skyBlue; borderWidth: 1.

	rowLayout _ LayoutMorph newRow.
	rowLayout separation: 15;
	padding: #center;
	addMorph: (StringMorph contents:'Catalog');
	addMorph: catalog;
	addMorph: addToCartButton.

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:02:12'!
build3rdRow

	| rowLayout |

	cartStatus _ StringMorph contents: 'Shopping cart is Empty'.

	rowLayout _ LayoutMorph newRow.
	rowLayout padding: #center;
	addMorph: cartStatus.

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:02:25'!
build4thRow

	| rowLayout addToCartButton |

	addToCartButton _ PluggableButtonMorph model: self model stateGetter: nil action: #checkOutCart label: 'Check out'.

	rowLayout _ LayoutMorph newRow.
	rowLayout padding: #center;
	addMorph: addToCartButton.

	^ rowLayout! !

!TLCartWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:01:16'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #center;

	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: self build4thRow.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLCartWindow class' category: #'TusLibros.com-Client Server'!
TLCartWindow class
	instanceVariableNames: ''!

!TLCartWindow class methodsFor: 'instance creation' stamp: 'AB 7/8/2019 16:26:03'!
openFor: aClient using: aPassword
	
	^ self new initializeFor: aClient using: aPassword! !

!TLCartWindow class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 09:39:21'!
openFor: aClient using: aPassword from: aPanel
	
	^ self new initializeFor: aClient using: aPassword from: aPanel! !


!classDefinition: #TLDashboardWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLDashboardWindow
	instanceVariableNames: 'listPurchasesButton createCartButton client password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLDashboardWindow methodsFor: 'initialization' stamp: 'AB 7/10/2019 11:00:17'!
defaultExtent

	^ 250 @ 250! !

!TLDashboardWindow methodsFor: 'initialization' stamp: 'AB 7/8/2019 16:23:22'!
initializeFor: aClient using: aPassword

	self titleMorph showButtonsNamed: #(close collapse).
	self setLabel: 'Dashboard'.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	client _ aClient.
	password _ aPassword! !


!TLDashboardWindow methodsFor: 'events' stamp: 'AB 7/10/2019 09:38:53'!
createCart

	TLCartWindow openFor: client using: password from: self! !

!TLDashboardWindow methodsFor: 'events' stamp: 'AB 7/10/2019 09:45:39'!
listPurchases

	TLPurchasesWindow openFor: client using: password from: self! !


!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:00:41'!
build1stRow

	| firstRowLayout |

	firstRowLayout _ LayoutMorph newRow.

	createCartButton _ PluggableButtonMorph model: self stateGetter: nil action: #createCart label: 'Start Shopping'.

	firstRowLayout separation: 15;
 	addMorph: createCartButton;
	padding: #center.
	
	^ firstRowLayout! !

!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:00:35'!
build2ndRow

	| secondRowLayout |

	secondRowLayout _ LayoutMorph newRow.

	listPurchasesButton _ PluggableButtonMorph model: self stateGetter: nil action: #listPurchases label: 'List Purchases'.

	secondRowLayout separation: 15;
 	addMorph: listPurchasesButton;
	padding: #center.
	
	^ secondRowLayout! !

!TLDashboardWindow methodsFor: 'graphic user interface' stamp: 'AB 7/10/2019 11:00:50'!
buildMorphicWindow

	self layoutMorph beColumn;
	padding: #center;

	addMorph: self build1stRow;
	addMorph: self build2ndRow! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLDashboardWindow class' category: #'TusLibros.com-Client Server'!
TLDashboardWindow class
	instanceVariableNames: ''!

!TLDashboardWindow class methodsFor: 'instance creation' stamp: 'AB 7/8/2019 14:10:37'!
openFor: aClient using: aPassword
	
	^ self new initializeFor: aClient using: aPassword! !


!classDefinition: #TLLoginWindow category: #'TusLibros.com-Client Server'!
Panel subclass: #TLLoginWindow
	instanceVariableNames: 'clientIdTextBox passwordTextBox resultLabel submitButton openDashboard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLLoginWindow methodsFor: 'events' stamp: 'AB 7/10/2019 09:27:54'!
updateLogIn

	resultLabel contents: model loginResponse.
	clientIdTextBox disableEditing; borderColor: Color green.
	passwordTextBox disableEditing; borderColor: Color green.

	submitButton model: self model stateGetter: nil action: #submitLogOut  label: 'Logout'.
	
	openDashboard _ TLDashboardWindow openFor: self model clientId using: self model password! !

!TLLoginWindow methodsFor: 'events' stamp: 'AB 7/10/2019 09:29:05'!
updateLogOut

	resultLabel contents: ''.
	clientIdTextBox enableEditing; borderColor: Color skyBlue.
	passwordTextBox enableEditing; borderColor: Color skyBlue.
	
	submitButton model: self model stateGetter: nil action: #submitLogIn  label: 'Login'.
	openDashboard ifNotNil: [ openDashboard closeButtonClicked ]! !

!TLLoginWindow methodsFor: 'events' stamp: 'AB 7/7/2019 19:12:43'!
wrongCredentials

	resultLabel contents: model loginResponse.
	clientIdTextBox borderColor: Color red.
	passwordTextBox borderColor: Color red! !


!TLLoginWindow methodsFor: 'initialization' stamp: 'AB 7/7/2019 17:00:46'!
defaultExtent

	^ 450 @ 250! !

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


!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/7/2019 19:20:28'!
build1stRow

	| firstRowLayout |
	
	firstRowLayout _ LayoutMorph newRow.
	
	clientIdTextBox _ TextModelMorph textProvider: self model textGetter: #clientId textSetter: #clientId:.
	clientIdTextBox textMorph setProperty: #keyStroke: toValue: [ :key | clientIdTextBox textMorph acceptContents ].
	clientIdTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: 'Client ID'.

	firstRowLayout separation: 25;
	addMorph: (StringMorph contents:'Enter Client ID');
	addMorph: clientIdTextBox;
	padding: #left.

	^ firstRowLayout! !

!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/7/2019 19:20:25'!
build2ndRow

	| secondRowLayout |
	
	secondRowLayout _ LayoutMorph newRow.
	
	passwordTextBox _ TextModelMorph textProvider: self model textGetter: #password textSetter: #password:. 
	passwordTextBox textMorph setProperty: #keyStroke: toValue: [ :key | passwordTextBox textMorph acceptContents ].
	passwordTextBox  borderWidth: 1; borderColor: Color skyBlue; morphExtent: 250@30; emptyTextDisplayMessage: 'Password'.
	
	secondRowLayout separation: 25;
	addMorph: (StringMorph contents:'Enter Password');
	addMorph: passwordTextBox;
	padding: #left.

	^ secondRowLayout! !

!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/7/2019 19:19:42'!
build3rdRow

	| thirdRowLayout |

	thirdRowLayout _ LayoutMorph newRow.

	submitButton _ PluggableButtonMorph model: self model stateGetter: nil action: #submitLogIn label: 'Login'.

	resultLabel _ StringMorph contents: ''.

	thirdRowLayout separation: 25;
 	addMorph: submitButton;
	addMorph: resultLabel;
	padding: #left.
	
	^ thirdRowLayout! !

!TLLoginWindow methodsFor: 'graphic user interface' stamp: 'AB 7/7/2019 17:01:44'!
buildMorphicWindow

	self layoutMorph beColumn;
	padding: #left;

	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow! !

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

!TLPurchasesWindow methodsFor: 'initialization' stamp: 'JR 7/7/2019 23:25:51'!
defaultExtent

	^ 350 @ 350! !

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

!TLPurchasesWindow methodsFor: 'graphic user interface' stamp: 'JR 7/7/2019 23:36:13'!
buildMorphicWindow

	self layoutMorph beColumn;
	padding: #left;

	addMorph: self build1stRow! !


!TLPurchasesWindow methodsFor: 'events' stamp: 'AB 7/10/2019 10:31:42'!
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

!TLPurchasesWindow class methodsFor: 'instance creation' stamp: 'AB 7/10/2019 09:45:56'!
openFor: aClient using: aPassword from: aPanel

	^ self new initializeFor: aClient using: aPassword from: aPanel! !


!classDefinition: #TLCartWindowModel category: #'TusLibros.com-Client Server'!
Object subclass: #TLCartWindowModel
	instanceVariableNames: 'selectedIndex webClient catalog cartId cartContents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/9/2019 15:10:15'!
cartContents

	^ cartContents! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/8/2019 17:28:23'!
cartId

	^ cartId! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/8/2019 17:42:02'!
cartIdFor: aClient protectedWith: aPassword

	| response |
	
	response _ webClient createCartFor: aClient  protectedWith: aPassword.
	
	^  response copyFrom: 3 to: response size! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'JR 7/8/2019 00:27:17'!
catalog
	
	^ catalog
! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/8/2019 16:27:43'!
catalogIndex

	^ selectedIndex! !

!TLCartWindowModel methodsFor: 'accessing' stamp: 'AB 7/8/2019 16:27:37'!
catalogIndex: anIndex

	selectedIndex _ anIndex! !


!TLCartWindowModel methodsFor: 'initialization' stamp: 'AB 7/9/2019 13:17:22'!
initializeFor: aClient using: aPassword

	selectedIndex _ 0.
	catalog _ OrderedCollection new.
	webClient _ TLWebClient new.
	cartId _ self cartIdFor: aClient protectedWith: aPassword.
	
	self sendCatalogRequest.! !


!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/10/2019 11:43:15'!
addSelectedBookToCart

	(selectedIndex = 0)

	ifTrue: [
		self triggerEvent: #noBooksSelected with: self
	]
	ifFalse: [
		| book fromCatalog response |

		fromCatalog _ catalog at: selectedIndex.
		book _ fromCatalog substrings at: 1.

		webClient addToCart: self cartId book: book.

		response _ webClient listCart: self cartId.

		((response copyFrom: 1 to: 2) = '0|')
			ifTrue: [
				cartContents _ response copyFrom: 3 to: response size.
				self triggerEvent: #cartUpdated with: self.
			]
	]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/10/2019 11:49:07'!
checkOutCart
	
	| response |

	response _ webClient listCart: self cartId.

	((response copyFrom: 1 to: 2) = '0|' and: (response copyFrom: 1 to: response size) size > 2)
		ifTrue: [
			self triggerEvent: #proceedToCheckOut with: self
		]
		ifFalse: [
			self triggerEvent: #noBooksInCart with: self
		]! !

!TLCartWindowModel methodsFor: 'events' stamp: 'AB 7/9/2019 15:09:19'!
sendCatalogRequest
		
	catalog _ webClient getCatalog.
	
	self triggerEvent: #catalogArrived with: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLCartWindowModel class' category: #'TusLibros.com-Client Server'!
TLCartWindowModel class
	instanceVariableNames: ''!

!TLCartWindowModel class methodsFor: 'instance creation' stamp: 'AB 7/8/2019 17:25:47'!
for: aClient using: aPassword

	^ self new initializeFor: aClient using: aPassword! !


!classDefinition: #TLLoginWindowModel category: #'TusLibros.com-Client Server'!
Object subclass: #TLLoginWindowModel
	instanceVariableNames: 'webClient loginResponse clientId password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLLoginWindowModel methodsFor: 'initialization' stamp: 'AB 7/8/2019 16:01:22'!
initialize

	webClient _ TLWebClient new.
	clientId _ ''.
	password _ ''.! !


!TLLoginWindowModel methodsFor: 'events' stamp: 'AB 7/7/2019 18:02:37'!
loginResponse

	^ loginResponse! !

!TLLoginWindowModel methodsFor: 'events' stamp: 'AB 7/7/2019 19:16:55'!
submitLogIn
		
	| response |
	
	response _ webClient signIn: clientId with: password.
	
	(response = '0|OK')
		ifTrue: [
			loginResponse _ 'Access granted'.
			self triggerEvent: #credentialsReceived with: self
		] ifFalse: [
			loginResponse _ response copyFrom: 3 to: response size.
			self triggerEvent: #wrongCredentials with: self		
		]! !

!TLLoginWindowModel methodsFor: 'events' stamp: 'AB 7/7/2019 18:54:07'!
submitLogOut

	loginResponse _ ''.

	self triggerEvent: #credentialsRemoved with: self! !


!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/7/2019 15:33:58'!
clientId

	^ clientId! !

!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/7/2019 19:16:27'!
clientId: aClientId

	clientId _ aClientId.
	^ true! !

!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/7/2019 15:34:06'!
password

	^ password! !

!TLLoginWindowModel methodsFor: 'accessing' stamp: 'AB 7/7/2019 19:16:16'!
password: aPassword

	password _ aPassword.
	^ true! !


!classDefinition: #TLPurchasesWindowModel category: #'TusLibros.com-Client Server'!
Object subclass: #TLPurchasesWindowModel
	instanceVariableNames: 'webClient purchasesList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com-Client Server'!

!TLPurchasesWindowModel methodsFor: 'initialization' stamp: 'AB 7/8/2019 16:27:16'!
initializeFor: aClient using: aPassword

	webClient _ TLWebClient new.
	purchasesList _ webClient listPurchasesFor: aClient with: aPassword! !


!TLPurchasesWindowModel methodsFor: 'accessing' stamp: 'JR 7/7/2019 23:42:57'!
purchasesList
	
	^ purchasesList
! !

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

!TLServer methodsFor: 'initialization' stamp: 'AB 7/6/2019 16:31:05'!
initialize

	kerberos _ [ :aClientId :aPassword | ].

	merchantProcessor _ [ :anAmount :aCreditCard | ].

	priceList _ StoreTestObjectsFactory new twoItemsPriceList.

	restInterface _ RestInterfaceExternal new initializewithCatalogue: priceList processingThrough: self signInUsersWith: self.

	self initializeServices! !

!TLServer methodsFor: 'initialization' stamp: 'AB 7/9/2019 12:34:20'!
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

!TLWebClient methodsFor: 'sending requests' stamp: 'JR 7/8/2019 00:36:07'!
addToCart: aCartId book: aBook

	| response |

	response _ WebClient htmlSubmit: (self url,'/addToCart') fields: { 'cartId' -> aCartId . 'bookIsbn' -> aBook . 'bookQuantity' -> 1 }.

	^ WebUtils jsonDecode: ((response content) readStream)! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/8/2019 17:32:45'!
createCartFor: aClientId protectedWith: aPassword

	| response |

	response _ WebClient htmlSubmit: (self url,'/createCart') fields: { 'clientId' -> aClientId. 'password' -> aPassword }.

	^ WebUtils jsonDecode: ((response content) readStream)! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/9/2019 11:04:24'!
getCatalog

	| response |

	response _ WebClient htmlSubmit: (self url,'/catalog') fields: {}.
	
	^ (WebUtils jsonDecode: ((response content) readStream)) asOrderedCollection! !

!TLWebClient methodsFor: 'sending requests' stamp: 'JR 7/8/2019 00:42:49'!
listCart: cartId

	| response |

	response _ WebClient htmlSubmit: (self url,'/listCart') fields: { 'cartId' -> cartId }.

	^ WebUtils jsonDecode: ((response content) readStream)! !

!TLWebClient methodsFor: 'sending requests' stamp: 'JR 7/7/2019 23:54:35'!
listPurchasesFor: aClientId with: aPassword

	| response |

	response _ WebClient htmlSubmit: (self url,'/listPurchases') fields: { 'clientId' -> aClientId. 'password' -> aPassword }.

	^ WebUtils jsonDecode: ((response content) readStream)! !

!TLWebClient methodsFor: 'sending requests' stamp: 'AB 7/7/2019 19:15:00'!
signIn: aClientId with: aPassword

	| response |

	response _ WebClient htmlSubmit: (self url,'/logInClient') fields: { 'clientId' -> aClientId. 'password' -> aPassword }.

	^ WebUtils jsonDecode: ((response content) readStream)! !


!TLWebClient methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:34:17'!
port

	^ port ifNil: [ port _ 8080 ]! !

!TLWebClient methodsFor: 'initialization' stamp: 'AB 7/6/2019 19:34:22'!
url
	
	^ 'http://localhost:', self port asString! !


!TLWebClient methodsFor: 'format' stamp: 'NR 6/25/2019 22:25:36'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !
