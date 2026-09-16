UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8688', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000493604' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8688', updatedon = now() where intakeserviceid = 'f8582637-89bc-4405-990c-d203c4932fb2';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8688', updatedon = now()
where intakenumber = 'I202000493604' and activeflag = 1;