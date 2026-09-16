-- CDM-27108 -Should Not Have Been Accepted. 
/*
   File Name: CDM-27108-intakedastaging-Screenout
-- Issue Description: I221010340915- This referral was accepted incorrectly by another supervisor and needs to be screened out. 
    Customer Email ID:linda.coy@maryland.gov
  
-- Resolution: Updated the jsondata to screen out in the intakedastaging table for the intakenumber = 'I221010340915'

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	intakedastaging
set
	updatedby = 'CDM-27108',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}', jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where
	intakenumber = 'I221010340915'
	and activeflag = 1;