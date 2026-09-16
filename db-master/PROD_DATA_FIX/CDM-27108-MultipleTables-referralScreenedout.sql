-- CDM-27108 - Should Not Have Been Accepted
/*
   File Name: CDM-27108-MultipleTables-referralScreenedout
-- Issue Description: 
    For the case I221010340915:This referral was accepted incorrectly by another supervisor and needs to be screened out.
    Customer Email ID:linda.coy@maryland.gov

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	intakesnapshot
set
	updatedby = 'CDM-27108',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}', jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where
	intakenumber = 'I221010340915'
	and activeflag = 1;


-- d64004ee-cdc5-4669-aad6-35930d29d68f
 update
	intakeservicerequest
set
	servicecaseid = null,
	updatedby = 'CDM-27108',
	updatedon = now()
where
	intakeserviceid = '4fc45e6c-0cd1-4300-81ee-eaca01bdde0c';


update
	servicecase
set
	statustypekey = 'Closed',
	dispositioncode = 'Closed',
	enddate = now(),
	updatedby = 'CDM-27108',
	updatedon = now()
where
	servicecaseid = 'd64004ee-cdc5-4669-aad6-35930d29d68f';


update
	servicecasedisposition
set
	activeflag = 0,
	updatedby = 'CDM-27108',
	updatedon = now()
where
	servicecasedispositionid = 'b4068afe-a38a-4742-8d6f-62ee849678b2';