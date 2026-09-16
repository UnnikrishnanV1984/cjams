/*
   Issue Description: CDM-24304
   Category/ Module  : Prod data fix to screenout Intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE 	intakesnapshot 
SET 	updatedby = 'CDM-24304', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I221010269609' AND activeflag=1;

update 	intakedastaging 
set 	status = 'Closed', 
		updatedby = 'CDM-24304', 
		updatedon = now()
where 	intakenumber = 'I221010269609' and activeflag = 1;

update 	intakeservicerequest 
set 	activeflag =0, 
		updatedby = 'CDM-24304', 
		updatedon = now() 
where 	servicerequestnumber = '221020210819' and activeflag =1;

update 	personprogramarea 
set 	activeflag = 0, 
		updatedby = 'CDM-24304', 
		updatedon = now()
where 	objectid in (select intakeserviceid::character varying
    					from intakeservicerequest where servicerequestnumber = '221020210819')
		and activeflag = 1;