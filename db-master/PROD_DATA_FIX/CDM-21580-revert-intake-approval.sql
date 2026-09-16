/*
-- CDM-21580
-- Issue Description: Reverting the intake approval as requested by the user
*/

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-21580', updatedon = now() where intakenumber = 'I221010253064';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-21580'
where objectid = 'I221010253064';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-21580'
where intakenumber = 'I221010253064' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-21580'
where intakenumber = 'I221010253064' and activeflag = 1;

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-21580', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010253064' AND activeflag=1;
