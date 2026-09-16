/*
   Issue Description: CJAMS-69708
   Category/ Module  : CJAMS - Intake
   Root cause: User wants to screen out intake I261014146659.
   Fix Provided: Data fix has been provided by updating the inatke status to screenout
   Pull request# for code fix: 
   Reason why no related code fix: only Data fix is needed
*/


UPDATE 	intakesnapshot 
SET 	updatedby = 'CJAMS-69708', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261014146659' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-69708', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014146659' AND activeflag=1;

update cjams.routing 
set routingstatustypeid =8, supervisordecision='ScreenOUT', updatedon = now()  
where routingid='984c8d19-9d0c-495a-8d7d-1960bbac396e' and activeflag = 1;
