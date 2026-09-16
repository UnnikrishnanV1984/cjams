/*
-- CDM-19403 - 

-- Issue Description: 
 Supervisor decision should be changed as 'Screened Out' and case needs to be closed
  
-- IntakeNumber: I211010226572, Case Number: 211030013182

-- Root cause: Data fix updated the intake number to screenout
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-19403', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010226572' AND activeflag=1;

update servicecase set activeflag =0, updatedby = 'CDM-19403', updatedon = now() where servicecasenumber = 211030013182 and activeflag =1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-19403', updatedon = now()
where intakenumber = 'I211010226572'
and activeflag = 1;

update intakedastatus
set status = 8, updatedby = 'CDM-19403', updatedon = now()
where intakenumber = 'I211010226572'
and activeflag = 1;