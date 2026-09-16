/*
   Issue Description: CJAMS-67564
   Category/ Module  : Update Supervisor Decision
   Root cause: Supervisor wants to screenout the intake as user not able to update it
   Fix Provided: Data fx was provided by updating the superviosr decision to screenout as requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	intakedastaging 
SET 	updatedby = 'CJAMS-67564', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261014013919' and activeflag = 1;