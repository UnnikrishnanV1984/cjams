
/*
Issue: Will not allow screen out recommendation.
Root Cause: The Intake recommendation and Supervisor decision needs to be 'Screen Out'
Fix Provided: Data fix has been done to update the intake recommendation and supervisor decision to 'Screen Out'.
Data/Code fix ticket#: CJAMS-66206
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Screen Out fixed on the database.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
UPDATE intakedastaging
SET  jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))),
updatedon=now(),
updatedby='CJAMS-66206'
WHERE intakenumber = 'I261013872146' AND activeflag=1;

UPDATE intakesnapshot
set  jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))),
updatedon=now(),
updatedby='CJAMS-66206'
WHERE intakenumber = 'I241013170670' AND activeflag=1;