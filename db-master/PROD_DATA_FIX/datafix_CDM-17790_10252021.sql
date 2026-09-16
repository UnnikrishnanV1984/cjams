-- CDM-17790 - GAP RATE Approval Issue
/*
-- Issue Description: 
   GAP RATE Approval Issue for the following Cases:
	TRUE BLESSING BAYLOR-#1951532
	ZION MCCLOUD-#3096824
	DESTINY MARTINO-#2411301
	TANAYA ADAMS-#1720377 

-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: deployed in Prod 10/22
*/

/*
Case ID: 3122257
Client ID: 1951532 (TRUE BLESSING BAYLOR) - 89f722fe-99a3-4611-9c8f-abf83cb0471b
GAP ID: 1496 - c968f4f2-ae42-4a9f-90e8-173bf745023a
GAP Agreement ID: db7cf968-627c-43ce-a4b5-6f20e04c0e78
gapagreementrateid: 6aa2f718-55df-40b1-8edc-5444fe064521

Case ID: 3170483
Client ID: 3096824 (ZION MCCLOUD) - efc628c9-7929-487b-be92-6d610799e20d
GAP ID: 1915 - c974ddf1-fbcd-4596-a1a0-1733177beff4
GAP Agreement ID: 12e2c9d8-3c69-4bbb-94d1-b379cd2c0c63
gapagreementrateid: fb97a8f0-a8d7-496e-ada6-49f45725aacf

Case ID: 3167229
Client ID: 2411301 (DESTINY	N MARTINO) - 82bd7813-c831-49a7-9088-9629d6cd73b2
GAP ID: 1613 - 43503796-8f1c-49bc-b0cd-f33f9b724c6e
GAP Agreement ID: 16466761-8ab0-4ecb-94b2-46ccd79e7f28
gapagreementrateid: 62f03a61-86ca-4a05-84e5-f3b6de0a4ca3 


Case ID: 3127600
Client ID: 1720377 (TANAYA R ADAMS) - c8c28f48-228f-45b4-aa91-3ac6a977c434 
GAP ID: 1429 - 998ea122-cf08-4cfb-ab60-36f8f2666707
GAP Agreement ID: 67fb4259-cacc-45a1-8957-23be3e0cfa93
gapagreementrateid: 24ccd5e8-cef4-4a84-b34f-0fbb745dbdad

*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid in
	(	'6aa2f718-55df-40b1-8edc-5444fe064521',
		'fb97a8f0-a8d7-496e-ada6-49f45725aacf',
		'62f03a61-86ca-4a05-84e5-f3b6de0a4ca3',
		'24ccd5e8-cef4-4a84-b34f-0fbb745dbdad'	
	)	
	and lower(status) = 'review' 
	and activeflag = 1 ;


update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17790',
	updatedon = now()
where gapagreementrateid in
	(	'6aa2f718-55df-40b1-8edc-5444fe064521',
		'fb97a8f0-a8d7-496e-ada6-49f45725aacf',
		'62f03a61-86ca-4a05-84e5-f3b6de0a4ca3',
		'24ccd5e8-cef4-4a84-b34f-0fbb745dbdad'	
	)	
	and lower(status) = 'review' 
	and activeflag = 1 ;

