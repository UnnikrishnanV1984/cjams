
/*
   Issue Description: CDM-240
   Category/ Module  : Update intake screen out
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-240', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000159773' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'CDM-240' where intakeserviceid = '75d8d5d8-5104-4e5d-a715-b4dadd6aad19';
