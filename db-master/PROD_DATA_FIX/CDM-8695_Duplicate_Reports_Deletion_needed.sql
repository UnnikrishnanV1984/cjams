UPDATE intakesnapshot
SET
updatedby = 'CDM-8695',
updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000170051' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8695', updatedon = now() where intakeserviceid = 'c0f3f8a1-251f-4a94-a8e5-6e83b38ac95f';

update intakedastaging set status = 'Closed', updatedby = 'CDM-8695', updatedon = now()
where intakenumber = 'I202000170051' and activeflag = 1;

----------------------------------------

UPDATE intakesnapshot
SET
updatedby = 'CDM-8695',
updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000264493' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8695', updatedon = now() where intakeserviceid = '5e10f418-61f2-4c71-943f-6ef9393466c4';

update intakedastaging set status = 'Closed', updatedby = 'CDM-8695', updatedon = now()
where intakenumber = 'I202000264493' and activeflag = 1;

--------------------------------------------

UPDATE intakesnapshot
SET
updatedby = 'CDM-8695',
updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000164398' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8695', updatedon = now() where intakeserviceid = '213379c3-7094-488f-81b8-44a3869b702d';

update intakedastaging set status = 'Closed', updatedby = 'CDM-8695', updatedon = now()
where intakenumber = 'I202000164398' and activeflag = 1;

------------------------------------------------------

UPDATE intakesnapshot
SET
updatedby = 'CDM-8695',
updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000564946' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8695', updatedon = now() where intakeserviceid = 'efcebbc4-c8e7-4376-b746-4f9fb750583d';

update intakedastaging set status = 'Closed', updatedby = 'CDM-8695', updatedon = now()
where intakenumber = 'I202000564946' and activeflag = 1;