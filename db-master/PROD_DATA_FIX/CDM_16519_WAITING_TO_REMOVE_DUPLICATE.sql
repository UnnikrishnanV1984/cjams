/*
   Issue Description: CDM-16519
   Category/ Module  : Approval inbox 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  user mentioned to screenout the intake and remove the case
   
*/

UPDATE intakesnapshot
	SET updatedby = 'CDM-16519', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
	jsonb_set(jsondata->'DAType', '{DATypeDetail}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
	WHERE intakenumber = 'I211010161156' AND activeflag=1;

	update intakeservicerequest set activeflag=0,updatedby = 'CDM-16519',updatedon = now() where servicerequestnumber=211020113177;