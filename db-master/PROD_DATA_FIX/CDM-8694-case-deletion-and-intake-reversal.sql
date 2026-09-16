UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8694', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000370569' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8694', updatedon = now() where intakeserviceid = '73ddebe6-a138-4e86-9489-d070dff91424';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8694', updatedon = now()
where intakenumber = 'I202000370569' and activeflag = 1;