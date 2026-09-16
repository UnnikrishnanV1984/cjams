-- CDM-26309 - Duplicate case needs Screened Out
/*
-- Issue Description: 
	for the Case number 221020232533 change the associated Intake Referral from Screened in to Screened Out. 
	This is a duplicate of CPS case 221020228079.

    Customer Email ID:stephanie.cooke1@maryland.gov
  
-- Resolution: Updated the activeflag to zero in the intakeservicerequest table for the servicerequestnumbers 221020232533
	and set screenout in the table intakesnapshot 

-- Case ID: 221020232533

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-26309', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010289365' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-26309', updatedon = now() where intakeserviceid = '41bb6f53-50f0-4a1c-a8cf-2b7d7ac81bb6';

update intakedastaging set status = 'Closed', updatedby = 'CDM-26309', updatedon = now() where intakenumber = 'I221010289365'and activeflag = 1;