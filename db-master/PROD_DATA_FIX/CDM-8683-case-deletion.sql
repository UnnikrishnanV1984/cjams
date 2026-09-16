UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8683', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000277362' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8683', updatedon = now() where intakeserviceid = '311545e4-72fc-4a56-8592-b967ca10058f';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8683', updatedon = now()
where intakenumber = 'I202000277362' and activeflag = 1;