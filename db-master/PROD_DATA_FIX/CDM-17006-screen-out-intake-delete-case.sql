UPDATE intakesnapshot 
SET 
updatedby = 'CDM-17006', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010193202' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-17006', updatedon = now() where intakenumber = 'I211010193202';

update servicecase set activeflag = 0, updatedby = 'CDM-17006', updatedon = now() where servicecasenumber = '211030011029';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-17006', updatedon = now()
	
	where intakenumber = 'I211010193202'
	and activeflag = 1;