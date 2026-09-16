/*
   Issue Description: CDM-35715
   Category/ Module  : Intake glitch and re-opened
   Root cause: Need to change the supervisor decision and the status  as intake was re-opened somehow and able to approve
   Fix Provided: Changed the supervisor decison to screen IN And status from Review to Accepted
*/
--To change  supervisor decision to ScreenIn.
UPDATE intakedastaging
SET status = 'Accepted',
updatedby = 'CDM-35715', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I231011565418' AND activeflag=1;

--To change status from Review to Accepted
update cjams.routing 
set routingstatustypeid = 2
where routingid ='6ebaed1c-7b92-4c12-8e96-c3ccd2cdff23' and objectid = 'I231011565418' and activeflag = 1;