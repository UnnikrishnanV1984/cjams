 /*
  Issue Description: CDM-17220
   Category/ Module  : Intake/CPS IR 
   Root cause: user asked to delete the CPS IR case and screen out the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE personprogramarea 
SET activeflag = 0, updatedby = 'CDM-17220', updatedon = now()
WHERE personprogramid in ('ca3f7946-1fb9-41ec-b8a8-2b66b1700356', '6477d106-1c6d-476d-bed8-a4f380eb837c');

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-17220', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010196144' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-17220', updatedon = now()
where intakenumber = 'I211010196144' and activeflag = 1;

update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'CDM-17220' where intakeserviceid = '355ebe80-bb5e-4d47-888f-c2feeb42a398';
