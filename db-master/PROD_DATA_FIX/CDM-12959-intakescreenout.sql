UPDATE intakesnapshot 
SET 
updatedby = 'CDM-12959', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100352019' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-12959', updatedon = now() where intakenumber = 'I202100352019';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-12959', updatedon = now()
	
	where intakenumber = 'I202100352019'
	and activeflag = 1;

update intakedastatus 
	set status = 8, updatedby = 'CDM-12959', updatedon = now()
	where intakenumber = 'I202100352019'
	and activeflag = 1;