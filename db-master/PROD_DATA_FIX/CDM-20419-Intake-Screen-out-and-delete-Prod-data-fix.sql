/*
-- CDM-20419 - 

-- Issue Description: 
 I221010239296:This case says screened it and was do to be assigned to Family Preservation but was not assigned to anyone. 
 Later it was learned that the case should be screened out but it will not allow me to screen this referral out.
  
-- Case ID: I221010239296

-- Root cause: Data fix updated the intake number to screenout
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-20419', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010239296' AND activeflag=1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-20419', updatedon = now() where intakenumber = 'I221010239296';

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-20419', updatedon = now()
	
	where intakenumber = 'I221010239296'
	and activeflag = 1;
	
update intakedastatus 
	set status = 8, updatedby = 'CDM-20419', updatedon = now()
	where intakenumber = 'I221010239296'
	and activeflag = 1;


update servicecase set activeflag = 0,  updatedby = 'CDM-20419', updatedon = now()
where servicecaseid = 'c16de7bb-1d91-43d0-95f9-f802de20ac78';