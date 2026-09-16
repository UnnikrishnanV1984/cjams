/*
-- CDM-15700 - 

-- Issue Description: 
   Unable to update end time on child removal 	
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove OOH and set removal end time on child removal
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set activeflag=0, updatedby = 'CDM-15700', updatedon = now() where personprogramid = '36788d2f-483d-4b0c-acf0-12e7448fd213';

--2020-02-13 20:00:00
update intakeservreqchildremoval set removaltime = '2020-02-13 12:00:00', updatedby = 'CDM-15700', updatedon = now() where intakeservreqchildremovalid = '8dd0d1aa-9401-4c37-a9c7-d2b785d148d5';