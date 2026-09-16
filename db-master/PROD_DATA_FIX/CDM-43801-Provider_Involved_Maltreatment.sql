/*
 Issue Description: CDM-43801
-- Category/ Module: Maltreatment Type 
-- Root cause: User requested to update Maltreatment type
-- Fix Provided: Datafix has been promoted to update the Maltreatment type
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/


update intakeservicerequestsdm set isprivateplacement = 'false',ismaltreatment='false',updatedon = now(),updatedby='CDM-43801'
where intakeserviceid = '5a3f8aed-c84c-4e2d-bd8b-27175a2bc6f3' and activeflag =1;

update intakedastaging 
set jsondata = replace(jsondata::text, '"maltreatment": "yes"', '"maltreatment": "no"')::json, 
updatedby = 'CDM-43801', updatedon = now()
 where intakenumber = 'I251013201519' and activeflag = 1;

update intakesnapshot 
set jsondata = replace(jsondata::text, '"maltreatment": "yes"', '"maltreatment": "no"')::json, 
updatedby = 'CDM-43801', updatedon = now()
 where intakenumber = 'I251013201519' and activeflag = 1;