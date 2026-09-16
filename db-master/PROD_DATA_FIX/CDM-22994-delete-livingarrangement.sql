/*
-- CDM-22994- 

-- Issue Description: 
 Unable to remove the living arrangement
  
-- Customer Email ID: theresa.kleppinger@maryland.gov

-- Root cause: Data fix to remove the living arrangement
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement set activeflag = 0, updatedby = 'CDM-22994', updatedon= now() 
where placementid = '8ddd9bdf-7e04-404d-a514-54ab8a6c3635' and activeflag = 1;

update livingarrangement set activeflag = 0, updatedby = 'CDM-22994', updatedon= now() 
where placementid = '8ddd9bdf-7e04-404d-a514-54ab8a6c3635' and activeflag = 1;

DELETE FROM cjams.intakeservreqchildremoval_history
WHERE intakeservreqchildremovalhistoryid in ('7e0cd148-1511-436f-bba9-8e2791b55ec7','c62fef32-5524-4669-b063-e7824ac2cc9a','9e811f39-c6ec-4bc1-a297-b9a583f1b2fa');