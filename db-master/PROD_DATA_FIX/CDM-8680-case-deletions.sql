UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8680', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000583346' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8680', updatedon = now() where intakeserviceid = 'e6e7f1e8-1db5-4dce-ae6d-7a39eb518026';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8680', updatedon = now()
where intakenumber = 'I202000583346' and activeflag = 1;


------------------------------------------------------------------

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8680', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000677003' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8680', updatedon = now() where intakeserviceid = '96561be6-59bf-4fe8-8d1d-e04a9ba0a35f';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8680', updatedon = now()
where intakenumber = 'I202000677003' and activeflag = 1;


-------------------------------------------------------------------------

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-8680', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202000175729' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8680', updatedon = now() where intakeserviceid = 'e95b5e31-af24-4736-9d6b-2414481413d1';

update intakedastaging	set status = 'Closed', updatedby = 'CDM-8680', updatedon = now()
where intakenumber = 'I202000175729' and activeflag = 1;