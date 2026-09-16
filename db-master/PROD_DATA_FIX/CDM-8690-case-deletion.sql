UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8690', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000275845' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8690', updatedon = now() where intakeserviceid = '61dac097-2524-4e98-8b31-700a9d98c069';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8690', updatedon = now()
where intakenumber = 'I202000275845' and activeflag = 1;