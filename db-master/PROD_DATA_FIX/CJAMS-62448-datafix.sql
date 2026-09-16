/*
   Issue Description: CJAMS-62448
   Category/ Module  :  child welfare - CPS 
   Root cause: User requested the status of supervisor decision and submission history to be screen out for the case I251013329173.
   Fix provided:  Data fix has been promoted that the status of supervisor decision and 
   submission history to be screen out for the case I251013329173 .
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error - requested a data fix
*/

UPDATE intakesnapshot 
SET updatedby = 'CJAMS-62448', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013329173' AND activeflag=1;

Update routing set 
routingstatustypeid = 8,updatedby = 'CJAMS-62448', updatedon = now(),
supervisordecision = 'ScreenOUT'
WHERE objectid = 'I251013329173';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-62448', updatedon = now() 
where intakenumber = 'I251013329173' and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CJAMS-62448', updatedon = now()
where intakenumber = 'I251013329173' and activeflag = 1;
