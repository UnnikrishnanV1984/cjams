/*
   Issue Description: CDM-33618
   Category/ Module  : Intake 
   Root cause:  User request 
   Fix Provide: Did data fix to remove intakenumber of I231010953412 from case 3049880, and status and supervisor disposition changed so user can submit again
*/


UPDATE cjams.intakeservicerequest
SET servicecaseid=NULL, updatedby='CDM-33618', updatedon=now() 
WHERE intakeserviceid='c084fbd4-824c-4b2b-8139-28967abbc074' and intakenumber = 'I231010953412';

--select activeflag,* from servicecasedisposition where servicecasedispositionid = '76d69432-ef4a-494f-a55d-876108f91686';
UPDATE cjams.servicecasedisposition
SET activeflag=0, updatedby='CDM-33618', updatedon=now() 
WHERE servicecasedispositionid='76d69432-ef4a-494f-a55d-876108f91686';


UPDATE intakedastaging
SET 
updatedby = 'CDM-33618', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I231010953412' AND activeflag=1;

UPDATE intakesnapshot
SET 
updatedby = 'CDM-33618', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I231010953412' AND activeflag=1;



UPDATE cjams.intakedastaging
SET ispreintake=false, status='Pending', updatedby='CDM-33618', updatedon=now() 
WHERE intakenumber='I231010953412' and activeflag=1; 


UPDATE cjams.routing
SET routingstatustypeid=1 
WHERE routingid='212ce944-914a-4c12-9b9c-792eda89ce81';