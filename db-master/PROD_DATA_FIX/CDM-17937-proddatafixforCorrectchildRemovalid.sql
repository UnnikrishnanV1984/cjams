/*
   Issue Description: CDM-17937
   Category/ Module  : Updating correct Intakeremovalid in placement table
   
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--  23f84606-16ca-4990-a600-04a200c3b935	
update placement set intakeservreqchildremovalid = '4812d08a-4d07-4f7d-b860-4d463126be40', updatedby = 'CDM-17937', updatedon = now() where placementid = 'dbb6e271-9b8c-4e57-9808-10f47eedcdd4';
