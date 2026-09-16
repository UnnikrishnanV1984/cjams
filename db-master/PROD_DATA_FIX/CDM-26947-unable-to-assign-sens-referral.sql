/*
   Issue Description: CDM-26947
   Category/ Module  : Unable to Assign SENS Referral 
   Root cause:  Intake I221010341180 Approved but no service case created or connected. Need to Move this ticket back to Supervisor Approval Inbox so supervisor can approve and create or connect to service case.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

   select routingstatustypeid,activeflag, * from routing r where objectid = 'I221010341180';
   select status, * from intakedastatus i  where  intakenumber = 'I221010341180';
   select status,ispreintake, * from intakedastaging i where intakenumber = 'I221010341180';
   select activeflag, * from intakesnapshot i where intakenumber = 'I221010341180';
*/

UPDATE intakedastaging
SET 
updatedby = 'CDM-26947', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I221010341180' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-26947', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', 'null'))))
WHERE intakenumber = 'I221010341180' AND activeflag=1;


UPDATE intakedastaging
SET 
updatedby = 'CDM-26947', updatedon = now(), jsondata = jsonb_set(jsondata, '{disposition}', 
			jsonb_set(jsondata->'disposition', '{0}', 
			jsonb_set(jsondata->'disposition'->0, '{supDisposition}', 'null')))
WHERE intakenumber = 'I221010341180' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-26947', updatedon = now(), jsondata = jsonb_set(jsondata, '{disposition}', 
			jsonb_set(jsondata->'disposition', '{0}', 
			jsonb_set(jsondata->'disposition'->0, '{dispositioncode}', 'null')))
WHERE intakenumber = 'I221010341180' AND activeflag=1;



update routing
set routingstatustypeid  = 1,
updatedon = now(),
updatedby = 'CDM-26947'
where objectid = 'I221010341180';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-26947'
where intakenumber = 'I221010341180';

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-26947'
where intakenumber = 'I221010341180';

update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-26947'
where intakenumber = 'I221010341180';