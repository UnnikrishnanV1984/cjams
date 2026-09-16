/*
   Issue Description: CDM-24077
   Category/ Module  : Referral needs to be screen out
   Root cause: user wants to remove referral and case number  
   Pull request# for code fix: 4797,4807
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-24077', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100332937' AND activeflag=1;