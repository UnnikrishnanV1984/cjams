/*
   Issue Description: CDM-25904
   Category/ Module  :  
   Root cause: user wanted to delete case, screenout intake and merge person
   Pull request# for code fix: 6699
   Reason why no related code fix: 
    
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-25904', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010322305' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-25904', updatedon = now()
where intakenumber = 'I221010322305' and activeflag = 1;

update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'CDM-25904' where intakeserviceid = '475ff930-13d9-4c4d-85ab-25e33f6ad745'; 

