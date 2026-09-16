-- CDM-17802 - GAP RATE Approval Issue
/*
-- Issue Description: 
    GAP RATE Approval Issue for the following Cases:
	Bethany Taylor 3901492
	Qwann Taylor 3878788
	Travon Taylor 3878789
	Isabella Lane 1551310
	Tresleem Salaam 3728028
	Melanie Rucker 1701170
	Mykayla Rucker 2320208
	Greggory Smith 1697678
	
	-- These are Provider IDs
	John Cornish(6001770)
	Yolanda Dale(5089080)

-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: deployed in Prod 10/22
*/

/*
Case ID: 3283955
Client ID: 3901492 (BETHANY TAYLOR) - 867d575e-4d65-431a-9277-2e785b08fef7
GAP ID: 1005508 - fc77e6ee-e067-4530-abc5-cea47858fe69
GAP Agreement ID: 63ed44d7-2e26-4c36-8e85-a6e532a56169
gapagreementrateid: e3854961-d23b-4e7e-980f-16657cb58649

Case ID: 3283955
Client ID: 3878788 (QWANN L	TAYLOR) - 0c2cf157-4d6a-4d35-911a-4fbe30831770 
GAP ID: 1005509 - b0f25b7b-d7f8-422d-9e64-c9d001d75d3e
GAP Agreement ID: 90bbf0fc-b97f-41ba-8ca9-d4dd3bf87cab
gapagreementrateid: 3da46e81-ced6-4007-9421-d240e191626e

Case ID: 3283955
Client ID: 3878789 (TRAVON C TAYLOR) - 1f937301-c82a-47dc-af4d-5f011f3a8ced
GAP ID: 1005525 - bb1d7316-b321-4db4-a1d1-64d8d16f9d7b
GAP Agreement ID: dba35577-0f16-4124-91df-2e923740460a
gapagreementrateid: 4e87e936-4805-4bc6-ac08-94b4ff2ae2f3

Case ID: 3080343
Client ID: 1551310 (ISABELLA LANE) - 0e9cfcd4-0183-4d8f-866c-989959720982 
GAP ID: 841 - d6b9412b-bf90-4a01-8e66-43dcbc61571a
GAP Agreement ID: 7521f501-d93e-41e7-86e4-12f8909aa69e 
gapagreementrateid: c182ba00-2bcd-4ec0-8114-6a7906d3a0a0

Case ID: 3252215
Client ID: 3728028 (TRESLEEM SALAAM) - b8f1c5ca-06a9-484f-a972-0fe5ef8b551d
GAP ID: 1005572 - a0488f22-bfc4-499d-b731-a814e02327a4
GAP Agreement ID: e5194200-06bc-476a-9619-c7bd4dd5a5c5
gapagreementrateid: 828eedb8-3320-48b8-a271-b5f0e4500d64

Case ID: 3124989
Client ID: 1701170 (MELANIE RUCKER) - f8d158aa-9ab7-4415-ae1a-b80389a7b1c4
GAP ID: 2590 - 86f650c4-8ebf-4b37-a51f-fd3b26b6729d
GAP Agreement ID: 73a5e22c-a4e9-456b-b5d8-0eb58b23490c
gapagreementrateid: 1f8e3a57-f652-48bd-9703-7f262d746e08

Case ID: 3124989
Client ID: 2320208 (MYKALYLA RUCKER) - 91e61c50-0f08-407f-9da5-65b53521ff73
GAP ID: 2591 - 2ccf6690-bf66-44b5-85fb-62b4fd28e43e
GAP Agreement ID: 2dfa5995-0000-4d3b-99cd-9472a78f2ff8
gapagreementrateid: 2d814e19-94b0-4f29-8765-018c4a3e036e


Case ID: 3095554
Client ID: 1697678 (GREGGORY SMITH) - 4c0c5a69-eafd-4e3b-aa5a-de7a35d94dc2 
GAP ID: 377 - 370020a8-b229-41df-ac26-d48f63360d6d
GAP Agreement ID: 4ab71bbb-d7ba-4e4d-aefd-1068359e5fd7
gapagreementrateid: 65aacb4c-666e-4f22-9545-d6676a9cff3c

*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid in
	(	'e3854961-d23b-4e7e-980f-16657cb58649',
		'3da46e81-ced6-4007-9421-d240e191626e',
		'4e87e936-4805-4bc6-ac08-94b4ff2ae2f3',
		'c182ba00-2bcd-4ec0-8114-6a7906d3a0a0',
		'828eedb8-3320-48b8-a271-b5f0e4500d64',
		'1f8e3a57-f652-48bd-9703-7f262d746e08',
		'2d814e19-94b0-4f29-8765-018c4a3e036e',
		'65aacb4c-666e-4f22-9545-d6676a9cff3c'
	)
	and lower(status) = 'review' 
	and activeflag = 1 ;


update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17802',
	updatedon = now()
where gapagreementrateid in
	(	'e3854961-d23b-4e7e-980f-16657cb58649',
		'3da46e81-ced6-4007-9421-d240e191626e',
		'4e87e936-4805-4bc6-ac08-94b4ff2ae2f3',
		'c182ba00-2bcd-4ec0-8114-6a7906d3a0a0',
		'828eedb8-3320-48b8-a271-b5f0e4500d64',
		'1f8e3a57-f652-48bd-9703-7f262d746e08',
		'2d814e19-94b0-4f29-8765-018c4a3e036e',
		'65aacb4c-666e-4f22-9545-d6676a9cff3c'
	)	
	and lower(status) = 'review' 
	and activeflag = 1 ;
