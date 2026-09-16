/*
   Issue Description: CJAMS-66247
   Category/ Module  : CJAMS - Intake
   Root cause: user wants to screen out intake I261013953696 .After the data fix is done make sure Case Number : 261023684791 is also removed.
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-66247', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013953696' AND activeflag=1;


UPDATE intakesnapshot 
SET updatedby = 'CJAMS-66247', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013953696' AND activeflag=1;

Update routing 
set updatedby = 'CJAMS-66247',  supervisordecision = 'screenout', updatedon = now(),activeflag =0, routingstatustypeid = 8
WHERE objectid = 'I261013953696' and activeflag =1;

update intakeDAStatus set status = 8, updatedby = 'CJAMS-66247', updatedon = now() 
where intakenumber = 'I261013953696' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CJAMS-66247', updatedon = now()
where intakenumber = 'I261013953696' and activeflag = 1;


update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-66247', updatedon = now() 
where intakenumber = 'I261013953696' and activeflag =1;

