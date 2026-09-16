/*
   Issue Description: CDM-27642
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot
SET
updatedby = 'CDM-27642', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010336128' AND activeflag=1;

update intakeservicerequest set servicecaseid =null, updatedby = 'CDM-27642', updatedon = now() where intakeserviceid ='1b79cac1-8b2b-46c0-8f22-c0e534a7992d';

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-27642', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010336128' AND activeflag=1;
