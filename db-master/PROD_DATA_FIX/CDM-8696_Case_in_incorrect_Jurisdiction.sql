UPDATE intakesnapshot
SET
updatedby = 'CDM-8696',
updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000266421' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8696', updatedon = now() where intakeserviceid = '999dc9c0-94e1-45d5-a4cc-5929de6e5f31';

update intakedastaging set status = 'Closed', updatedby = 'CDM-8696', updatedon = now()
where intakenumber = 'I202000266421' and activeflag = 1;