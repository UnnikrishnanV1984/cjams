/*
  Issue Description:CJAMS-67164-intake error
   Category/ Module  : Decision
   Root cause: user requested to screenout the intake as user has mistakenly screened in the intake
   Fix provided: Data fix has been done to screenout the intake as requested by user
   Is code fix required: N
   Why no code fix is required: User error
   Pull request# for code fix: 
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CJAMS-67164', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014007448' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CJAMS-67164', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014007448' AND activeflag=1;


UPDATE cjams.routing
SET routingstatustypeid=8, activeflag=0,supervisordecision='ScreenOUT' ,updatedby='CJAMS-67164', updatedon=now()  
WHERE routingid='79acc552-1ef6-4b20-8ead-cc60ccc72b4f'; 