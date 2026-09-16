/*
Issue Description: CW10143987:This old intake from 2019 has appeared on my dashboard, is unable to be screened or sent to another Supervisor to screen
Root cause: User requested to close the intake.
Fix provided: update into routing,intakedastatus,intakedastaging table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: User Error.
*/


UPDATE intakedastaging
SET updatedby = 'CJAMS-62876', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Progress ROA"'))))
WHERE intakenumber = 'CW10143987' AND activeflag=1;

UPDATE routing
set intakerecommendation='Progress ROA',supervisordecision='progress roa',updatedon = now() 
where objectid='CW10143987' and activeflag = 1;