/*
-- CDM-22932- 

-- Issue Description: 
 Unable to remove rejected record
  
-- Customer Email ID: kelly.beswick@maryland.gov

-- Root cause: Data fix to remove rejected record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-22932', updatedon = now()
where intakeservreqchildremovalid = '1cb1145d-bdd4-475b-9dbd-047fa840027d';

update routing set activeflag = 0, updatedby = 'CDM-22932', updatedon = now()
where routingid = '369db735-f665-4b4a-9563-a153c82a129d';