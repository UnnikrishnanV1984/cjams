UPDATE intakesnapshot 
SET 
updatedby = 'CDM-17161', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber in ('I202000497463') AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-17161', updatedon = now() where intakenumber in ('I202000497463');

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-17161', updatedon = now()
	
	where intakenumber in ('I202000497463')
	and activeflag = 1;
	
update intakedastatus 
	set status = 8, updatedby = 'CDM-12959', updatedon = now()
	where intakenumber in ('I202000497463')
	and activeflag = 1;
