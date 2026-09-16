/*
   Issue Description: CDM-34582
   Category/ Module  : Screenout referral and delete service case created
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-34582', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010794519' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-34582', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010794519' AND activeflag=1;

Update routing set 
updatedby = 'CDM-34582', updatedon = now(), activeflag =0, routingstatustypeid = 8
WHERE objectid = 'I231010794519';

update intakedastatus 
set status = 8, updatedby = 'CDM-34582', updatedon = now()
where intakenumber = 'I231010794519' and activeflag = 1;

update servicecase 
set activeflag = 0, updatedby = 'CDM-34582', updatedon = now()
where servicecaseid = 'dbdd0930-99be-4060-8c16-31fc1526d6e6' and activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-34582'
WHERE objectid = 'dbdd0930-99be-4060-8c16-31fc1526d6e6' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-34582', updatedon = now() 
where objectid = 'dbdd0930-99be-4060-8c16-31fc1526d6e6' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-34582', updatedon = now() 
where objectid = 'dbdd0930-99be-4060-8c16-31fc1526d6e6' and activeflag = 1;

