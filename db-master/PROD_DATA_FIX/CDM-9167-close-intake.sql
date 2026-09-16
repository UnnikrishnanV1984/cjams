update intakeservicerequest set servicecaseid = null,updatedby = 'CDM-9167', updatedon = now() where intakenumber = 'I202100216144';

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9167', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100216144' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9167', updatedon = now() where intakeserviceid = '73156ba4-88b2-4b60-aca4-d5e7bf56a4a6';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9167', updatedon = now()
	
	where intakenumber = 'I202100216144'
	and activeflag = 1;