/*
   Issue Description: CDM-31392
   Category/ Module  :  intake screenout 
   Root cause: User requested to screenout intake
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

UPDATE intakesnapshot 
SET updatedby = 'CDM-43385', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013194626' AND activeflag=1;


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-43385', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013194626' AND activeflag=1;


update intakeservicerequest set activeflag = 0, updatedby = 'CDM-43385', updatedon = now()  
where intakenumber = 'I241013194626' and activeflag = 1;

update routing set supervisordecision = 'screenout',routingstatustypeid = 8,updatedon=now(),updatedby = 'CDM-43385'
where routingid = 'df220f9b-39e9-4de0-8f8a-1a5ed709d4f3'  and objectid ='I241013194626' and activeflag = 1;