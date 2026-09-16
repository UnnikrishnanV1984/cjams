/*
   Issue Description: CIDM-8438
   Category/ Module  : Decision
   Root cause: Not able to change the supervisor decision to screen out.
   Fix Provided: Changed Screen in to Screen out
*/
--updated the Supervisor Decision to Screen Out.


select status,* from intakedastaging where intakenumber = 'I202100217791' and activeflag = 1;

UPDATE intakesnapshot
SET
updatedby = 'CIDM-8438', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100217791' AND activeflag=1;