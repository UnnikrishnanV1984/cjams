UPDATE intakesnapshot 
SET 
updatedby = 'CDM-10228', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000483086' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10228', updatedon = now() where intakenumber = 'I202000483086';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-10228', updatedon = now()
	
	where intakenumber = 'I202000483086'
	and activeflag = 1;