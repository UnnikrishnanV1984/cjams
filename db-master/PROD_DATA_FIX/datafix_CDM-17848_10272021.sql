-- CDM-17848 - Approval not coming to my inbox and was approved not showing approved.
/*
-- Issue Description: 
   GAP RATE Approval Issue for the following cases.
   The system is not allowing the supervisor to approve the rate changes. 
   It's continues to show "Review".

-- Case ID: 3219584
-- Client ID: 3120269 (ALONZO HART) - 3926f1d0-c7b2-479c-92c1-4133080df0eb
-- GAP ID: 4004 - 8c9f8bd1-e6a3-466a-9f7f-8f336d21793c
-- GAP Agreement ID: a568ccd7-62b5-4e42-b219-8299421fa539
-- gapagreementrateid: 37b325d3-f812-4312-9b63-4a150fc4c015

-- Case ID: 3193089
-- Client ID: 3134380 (KHYREESE	LAMAR SAUNDERS) - 825ffe3a-2d22-4b26-9620-9b9c9713975c
-- GAP ID: 3131 - b686801e-c2c1-4fcd-ad1a-57c436d32535
-- GAP Agreement ID: 7d49651a-5b71-4c13-b969-ba7766c87ca0
-- gapagreementrateid: d2f36b23-010f-467a-99b3-1c81f360dcbf

-- Case ID: 3193089
-- Client ID: 3134379 (AMAHZSA RAE SAUNDERS) - 43009a44-ff41-452d-8a2f-db90182fbe99
-- GAP ID: 3130 - fbf96482-a9b3-4028-a9e8-7154585a135b
-- GAP Agreement ID: c6a5b27d-b9ef-40e8-94fc-92ac66df9c90
-- gapagreementrateid: feabf6de-8d5b-4e3f-b33b-647932326b3b
  
-- Case ID: 3244212
-- Client ID: 3365138 (LIDIA SPIELMAN) - 3bbad4c3-64df-4966-8bf8-b56f12dd7d2d
-- GAP ID: 4296 - 13ff3a1f-509c-4866-ae88-3ff4623b2d1e
-- GAP Agreement ID: 14fadf8a-f83d-4a82-bb79-52bc34845d1e
-- gapagreementrateid: e46b762a-d597-42d8-872d-f5ae05252f9d

-- Case ID: 3244212
-- Client ID: 3365137 (JILLIAN BIANCA SPIELMAN) - 4a2af3ba-acb2-414a-a2a7-442dc034211b
-- GAP ID: 4295 - 1d3765f4-51ed-4c55-a605-af9cbe0f841d
-- GAP Agreement ID: 0c8dbcb7-b294-4d44-8e44-429293834ad3
-- gapagreementrateid: d57e1551-2d20-48b3-bb7e-446c65488144
  
*/   

-- Soft-delete GAP Rate in Reviews
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid 
		in (	'37b325d3-f812-4312-9b63-4a150fc4c015',
				'd2f36b23-010f-467a-99b3-1c81f360dcbf',
				'feabf6de-8d5b-4e3f-b33b-647932326b3b',
				'e46b762a-d597-42d8-872d-f5ae05252f9d',
				'd57e1551-2d20-48b3-bb7e-446c65488144' 
			) 
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17848',
	updatedon = now()
where gapagreementrateid 
		in (	'37b325d3-f812-4312-9b63-4a150fc4c015',
				'd2f36b23-010f-467a-99b3-1c81f360dcbf',
				'feabf6de-8d5b-4e3f-b33b-647932326b3b',
				'e46b762a-d597-42d8-872d-f5ae05252f9d',
				'd57e1551-2d20-48b3-bb7e-446c65488144' 
			) 
	and lower(status) = 'review' 
	and activeflag = 1 ;

