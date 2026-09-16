/*
   Issue Description: CDM-28940
   Category/ Module  : Decision tab
   Root cause: user wants to screenout the decision
   Pull request# for code fix: 8140
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot
SET
updatedby = 'CDM-28940', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010382638' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-28940', updatedon = now()  
where intakeserviceid = '9cdf0589-6309-429f-9e08-cd495b7a8261' and activeflag = 1;