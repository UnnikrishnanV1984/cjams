/*
   Issue Description: CDM-18298
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE intakesnapshot
SET
updatedby = 'CDM-18298', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010208784' AND activeflag=1;

update intakeservicerequest i set servicecaseid =null, updatedby = 'CDM-18298', updatedon = now() where intakeserviceid ='7f97062d-f1dc-4b65-9948-3f16aa4a4e46';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-18298', updatedon = now()
	
	where intakenumber = 'I211010208784'
	and activeflag = 1;
