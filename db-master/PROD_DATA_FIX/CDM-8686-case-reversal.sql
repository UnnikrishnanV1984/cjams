UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8686', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000091856' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8686', updatedon = now() where intakeserviceid = '506c0d63-29e2-47cb-9068-29aa4797f6dd';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8686', updatedon = now()
where intakenumber = 'I202000091856' and activeflag = 1;