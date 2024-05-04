!classDefinition: #BillingTest category: #Mercap!
TestCase subclass: #BillingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!BillingTest methodsFor: 'as yet unclassified' stamp: 'dg 5/4/2024 14:18:25'!
test_001_localCallCost

	| localCall |
	localCall := LocalCall  new initializeWithCallDuration: 10 dateAndTime: (DateAndTime year: 															 				  				 					2024month: 5 day: 3 hour: 13 minute: 24 second: 5).
	
	self assert: localCall callCost equals: 2.0.
	
	! !

!BillingTest methodsFor: 'as yet unclassified' stamp: 'dg 5/4/2024 14:19:01'!
test_002_nationalCallCost

	| nationalCall berazategui |
	
	berazategui := Location new initializeWithName: 'Berazategui' cost: 10.
	
	nationalCall := NationalCall  new initializeWithCallDuration:  6                                                                                                                                  location: berazategui.

	self assert: nationalCall callCost equals: 60.0.
	
	! !

!BillingTest methodsFor: 'as yet unclassified' stamp: 'dg 5/4/2024 14:20:01'!
test_003_internationalCallCost

	| internationalCall argentina |
	
	argentina := Country new initializeWithName: 'Argentina' cost: 50.
	
	internationalCall := InternationalCall new initializeWithCallDuration: 8           
	                                                                               country: argentina.
	
	self assert: internationalCall callCost equals: 400.0.
	
	! !

!BillingTest methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:51:45'!
test_004_costOfTotalBillingWithMultipleCalls

	| bill berazategui nationalCall argentina internationalCall localCall_1 localCall_2 |
	
	localCall_1 := LocalCall  new initializeWithCallDuration: 5 dateAndTime: (DateAndTime year: 															 				  				 					2024month: 5 day: 3 hour: 13 minute: 22 second: 5). 
	
	
	localCall_2 := LocalCall  new initializeWithCallDuration: 5 dateAndTime: (DateAndTime year: 															 				  				 					2024month: 5 day: 3 hour: 22 minute: 35 second: 5).
	
	
	berazategui := Location new initializeWithName: 'Berazategui' cost: 10.
	
	nationalCall := NationalCall  new initializeWithCallDuration:  6                                                                                                                                  location: berazategui.
	
	argentina := Country new initializeWithName: 'Argentina' cost: 50.
	
	internationalCall := InternationalCall new initializeWithCallDuration: 8       
	                                                                               country: argentina.
	
	
	
	
	bill := Billing  new.
	
	bill addCall: localCall_1.
	bill  addCall: nationalCall.
	bill addCall: localCall_2.
	bill  addCall: internationalCall.
	
	self assert: bill calculationTotalCost equals: 561.5.
	
	! !

!BillingTest methodsFor: 'as yet unclassified' stamp: 'dg 5/4/2024 14:21:01'!
test_005_costOfTotalBillingWithMultipleCallsPrint

	| bill berazategui nationalCall argentina internationalCall localCall_1 localCall_2 |
	
	localCall_1 := LocalCall  new initializeWithCallDuration: 5 dateAndTime: (DateAndTime year: 															 				  				 					2024month: 5 day: 3 hour: 13 minute: 22 second: 5). 
	
	
	localCall_2 := LocalCall  new initializeWithCallDuration: 5 dateAndTime: (DateAndTime year: 															 				  				 					2024month: 5 day: 3 hour: 22 minute: 35 second: 5).
	
	
	berazategui := Location new initializeWithName: 'Berazategui' cost: 10.
	
	nationalCall := NationalCall  new initializeWithCallDuration:  6                                                                                                                                         location: berazategui.
	
	argentina := Country new initializeWithName: 'Argentina' cost: 50.
	
	internationalCall := InternationalCall new initializeWithCallDuration: 8    
	                                                                               country: argentina.
	
	
	
	
	bill := Billing  new.
	
	bill addCall: localCall_1.
	bill  addCall: nationalCall.
	bill addCall: localCall_2.
	bill  addCall: internationalCall.
	
	bill print.
	
	self assert: bill calculationTotalCost equals: 561.5.
	
	
	
	! !


!classDefinition: #Billing category: #Mercap!
Object subclass: #Billing
	instanceVariableNames: 'basicMonthlyPass callList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!Billing methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:10:19'!
addCall: aCall
	callList  add: aCall.! !

!Billing methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:11:29'!
calculationTotalCost
	
	| totalCost |
	totalCost  := callList sum:[:call | call callCost ].
	
	^ totalCost  + basicMonthlyPass.
! !

!Billing methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:09:09'!
initialize
	basicMonthlyPass  := 100.
	callList  := OrderedCollection new.
! !

!Billing methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:07:57'!
print
	Transcript cr; show: '=================='.
	Transcript  cr; show: 'Basic monthly pass: '; show: basicMonthlyPass  printString.
	Transcript cr; show: '=================='.
	Transcript  cr; show: 'Total call cost: '; show: self calculationTotalCost  printString .
	Transcript cr; show: '=================='.! !


!classDefinition: #Call category: #Mercap!
Object subclass: #Call
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!Call methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:11:28'!
callCost
	self subclassResponsibility ! !


!classDefinition: #InternationalCall category: #Mercap!
Call subclass: #InternationalCall
	instanceVariableNames: 'country callDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!InternationalCall methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:24:10'!
callCost
	^ country  cost * callDuration.! !

!InternationalCall methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:49:21'!
initializeWithCallDuration:duration country: aCountry
	callDuration := duration.
	country  := aCountry.! !


!classDefinition: #LocalCall category: #Mercap!
Call subclass: #LocalCall
	instanceVariableNames: 'callDuration dateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!LocalCall methodsFor: 'as yet unclassified' stamp: 'dg 5/4/2024 14:17:00'!
callCost 

	| workingDay hour |
	hour := dateAndTime hour.
	workingDay := dateAndTime  dayOfWeek < 6.
	
	workingDay & (hour > 8 and: hour < 20) ifTrue: [  
            ^ 0.20 * callDuration.
        ] ifFalse: [
        ^ 0.10 * callDuration.
    	].! !

!LocalCall methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:50:15'!
initializeWithCallDuration:duration dateAndTime: aDate
      callDuration := duration.
      dateAndTime := aDate.
 ! !


!classDefinition: #NationalCall category: #Mercap!
Call subclass: #NationalCall
	instanceVariableNames: 'location callDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!NationalCall methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:24:10'!
callCost
	^ location cost * callDuration.! !

!NationalCall methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:51:13'!
initializeWithCallDuration:duration location: aLocation
	callDuration := duration.
	location := aLocation.! !


!classDefinition: #Country category: #Mercap!
Object subclass: #Country
	instanceVariableNames: 'name cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!Country methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:24:21'!
cost
	^ cost.! !

!Country methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:51:44'!
initializeWithName: aName cost: aCost
	name := aName.
	cost  := aCost.! !


!classDefinition: #Location category: #Mercap!
Object subclass: #Location
	instanceVariableNames: 'name cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mercap'!

!Location methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:26:23'!
cost
	^ cost.
	! !

!Location methodsFor: 'as yet unclassified' stamp: 'dg 5/3/2024 20:51:45'!
initializeWithName: aName cost: aCost
	name := aName.
	cost := aCost .! !
