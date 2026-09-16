/*
   Issue Description: CJAMS-67364
   Category/ Module  : Intake screen out 
   Root cause: decision is screenout 
   Pull request# for code fix: 6517
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-67364', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014010983' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CJAMS-67364', updatedon = now()
where intakenumber = 'I261014010983' and activeflag = 1;


UPDATE intakesnapshot 
SET updatedby = 'CJAMS-67364', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014010983' AND activeflag=1;

Update routing 
set updatedby = 'CJAMS-67364',  supervisordecision = 'screenout', updatedon = now(),activeflag =0, routingstatustypeid = 8
WHERE objectid = 'I261014010983' and activeflag =1;

update intakeDAStatus set status = 8, updatedby = 'CJAMS-67364', updatedon = now() 
where intakenumber = 'I261014010983' and activeflag =1;



