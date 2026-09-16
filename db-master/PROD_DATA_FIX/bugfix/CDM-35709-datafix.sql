/*
   Issue Description: CDM-35709
   Category/ Module  : Decision
   Root cause: Not able to change the supervisor decision to screen out then approves the intake.
   Fix Provided: Changed Screen in to Screen out and approved
*/
--updated the Supervisor Decision to Screen Out and Approved.
UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-35709', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011567861' AND activeflag=1;

update routing set routingstatustypeid = 8 where objectid='I231011567861'and activeflag=1;
