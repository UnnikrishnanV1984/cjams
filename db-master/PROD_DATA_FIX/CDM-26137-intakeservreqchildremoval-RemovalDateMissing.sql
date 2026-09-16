-- CDM-26137 -Removal date is missing
/*
   File Name: CDM-26137-intakeservreqchildremoval-RemovalDateMissing
-- Issue Description: 
    For the Case 3257755 Child Removal Draft record should be removed for the Client ID # 1737059  
    Customer Email ID:wanda.nolt@maryland.gov
  
-- Resolution: Updated the Flag to zero in the intakeservreqchildremoval table for the Client ID # 1737059

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-26137', updatedon= now() 
where intakeservreqchildremovalid = '8fb2a4fb-2bf3-4639-b272-d002d743c7aa';