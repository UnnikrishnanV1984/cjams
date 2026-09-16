
/*
   Issue Description: CDM-31788
   Category/ Module  : Intake
   Root cause: user decision updated screenin due to code error and that was fixed already
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
---Giving Access to the user to approve this intake so reamining all tables records will insert properly 
--And there is no record in intakesnapshot only if user approved only it will insert both snapshot and routing records and intakeservierequest table record as well 

UPDATE intakedastaging 
SET 
updatedby = 'CDM-31788', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231010627328'
AND activeflag=1;