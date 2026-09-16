UPDATE intakesnapshot 
SET 
updatedby = 'CDM-12961', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100450129' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-12961', updatedon = now() where intakenumber = 'I202100450129';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-12961', updatedon = now()
	
	where intakenumber = 'I202100450129'
	and activeflag = 1;
	
update personprogramarea set 
activeflag = 0,
updatedby = 'CDM-12961',
updatedon = now()
where personprogramid in ('017980f3-b3f8-4e11-b585-465bf634a2e0','6f158958-bf39-4b01-b329-1d00b41357ad');

update intakedastatus 
	set status = 8, updatedby = 'CDM-12959', updatedon = now()
	where intakenumber = 'I202100450129'
	and activeflag = 1;