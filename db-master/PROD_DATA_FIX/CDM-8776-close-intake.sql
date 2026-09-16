UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8776', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000184049' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8776', updatedon = now() where intakeserviceid = 'fc7c8562-9eac-43a7-ba92-f2803f4cb147';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-8776', updatedon = now()
	
	where intakenumber = 'I202000184049'
	and activeflag = 1;