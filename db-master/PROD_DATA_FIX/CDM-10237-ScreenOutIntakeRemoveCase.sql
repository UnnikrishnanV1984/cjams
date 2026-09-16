-- CDM-10237 - Remove case and screen out the intake

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-10237', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000462540' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10237', updatedon = now() where intakeserviceid = 'b91dfa9b-ec92-4687-bf43-30267a0fa1b8';

update intakedastaging 
	set status = 'Closed', updatedby = 'CDM-10237', updatedon = now()
	where intakenumber = 'I202000462540'
	and activeflag = 1;
