/*
Issue: CJAMS-65301 Intake Status Fix
Category/Module: Intake Status
Root cause: Case status is showed as In-Progress in the person search.
Fix provided:  Data fix has been done to update the intake status accordingly.
Data/Code fix ticket#: CJAMS-65301
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/

UPDATE intakesnapshot
SET
updatedby = 'CJAMS-65301', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013893693' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-65301', updatedon = now()
WHERE intakenumber = 'I261013893693' AND  id = 14208474;

update routing 
set activeflag = 1, routingstatustypeid=8,updatedby = 'CJAMS-65301', updatedon = now() 
 where routingid = 'e8f190c8-a8db-42d0-8640-5139904ba2f3';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-65301', updatedon = now() 
where intakenumber = 'I261013893693' and activeflag =1;

update intakeservicerequest 
set activeflag = 0, servicecaseid = null, updatedby = 'CJAMS-65301', updatedon = now() 
where intakenumber = 'I261013893693';