-- CDM-10230 - Remove case and screen out the intake

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-10230', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000465837' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10230', updatedon = now() where intakeserviceid = '00a40275-e432-44a5-a021-9033f46daca1';

update intakedastaging 
	set status = 'Closed', updatedby = 'CDM-10230', updatedon = now()
	where intakenumber = 'I202000465837'
	and activeflag = 1;
