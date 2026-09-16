-- CDM-10238 - Remove case and screen out the intake

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-10238', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000661953' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10238', updatedon = now() where intakeserviceid = 'aced3d3d-900c-45c9-8f53-c9ced9fd59d3';

update intakedastaging 
	set status = 'Closed', updatedby = 'CDM-10238', updatedon = now()
	where intakenumber = 'I202000661953'
	and activeflag = 1;
