UPDATE intakesnapshot 
SET 
updatedby = 'CDM-9538', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000101836' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-9538', updatedon = now() where intakeserviceid = '85b0fd1f-72e2-484a-81f7-9b3b7bd9aab0';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-9538', updatedon = now()
	
	where intakenumber = 'I202000101836'
	and activeflag = 1;