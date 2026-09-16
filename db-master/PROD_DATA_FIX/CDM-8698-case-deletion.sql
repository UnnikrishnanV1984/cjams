UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8698', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000069800' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8698', updatedon = now() where intakeserviceid = 'f0cfdcf9-5b9f-42c9-b691-9286f70bb95f';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8698', updatedon = now()
where intakenumber = 'I202000069800' and activeflag = 1;