
update servicecase set activeflag = 0, updatedon = now(), updatedby = 'CDM-11249' where servicecaseid = 'd04b50de-0f76-48b3-a0ff-7470dee94564';
update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'CDM-11249' where intakeserviceid = 'b85a89d1-6322-4137-b4fd-f229206b9c9e';

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-11249', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100137034' AND activeflag=1;

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-11249', updatedon = now()
	
	where intakenumber = 'I202100137034'
	and activeflag = 1;