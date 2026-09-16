/*
   Issue Description: CJAMS-69776
   Category/ Module: Intake screenout 
   Root cause: User requested to screenout intake
   Fix Provided: Data fix has been provided by screenout the intake
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

UPDATE intakesnapshot 
SET updatedby = 'CJAMS-69776', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014150550' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-69776', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014150550' AND activeflag=1;

-- select * from routing where objectid ='I261014150550' AND activeflag=1;
