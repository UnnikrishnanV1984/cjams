UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8691', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000068770' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8691', updatedon = now() where intakeserviceid = '25a2f25b-c118-4c0c-9dfd-5c2d0d2d30fe';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8691', updatedon = now()
where intakenumber = 'I202000068770' and activeflag = 1;