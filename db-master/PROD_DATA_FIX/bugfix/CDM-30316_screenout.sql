/*
   Issue Description: CDM-30316
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot
SET
updatedby = 'CDM-30316', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010570704' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-30316', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010570704' AND activeflag=1;

UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'CDM-30316', updatedon = now() 
WHERE 
    servicerequestnumber = '231020499658'
AND intakeserviceid = '93d325d8-d951-4c7e-9a09-e8bd21b4e532' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30316'
WHERE objectid = '93d325d8-d951-4c7e-9a09-e8bd21b4e532' AND activeflag =1;