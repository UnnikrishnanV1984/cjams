/*
-- CDM-23198- 

-- Issue Description: 
 Unable to complete the placement tab
  
-- Customer Email ID: kate.letsa@maryland.gov

-- Root cause: Data fix to set the service case id
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- ee1b2978-fe97-4247-8ff5-6b1c29b70b25
update intakeservreqchildremoval set servicecaseid = '50b1d121-4456-45d9-845b-f168978a5526',
updatedby = 'CDM-23198', updatedon = now() 
where intakeservreqchildremovalid  = 'a241a98a-e033-43a0-b1e7-5e5fd501a382';