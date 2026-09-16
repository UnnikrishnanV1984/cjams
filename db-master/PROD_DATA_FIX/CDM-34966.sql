/*
 * CDM-34966 - CJAMS Glitch SENS Referral I231011372324 (Priority Assistance Needed)
 * Customer Email ID:jessica.roundtree@maryland.gov
 * Customer Name:Jessica Roundtree
 * Intake is screened In but there is no submission history or service case created. 
 * Please remove the supervisor decision, so that the user can submit the intake again for approval.
*/

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-34966', updatedon = now() where intakenumber = 'I231011372324';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-34966'
where objectid = 'I231011372324';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-34966'
where intakenumber = 'I231011372324' and activeflag=1;

UPDATE intakedastaging
SET 
status = 'pending',
ispreintake = FALSE,
updatedby = 'CDM-34966', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I231011372324' AND activeflag=1;

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-34966', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231011372324' AND activeflag=1;
