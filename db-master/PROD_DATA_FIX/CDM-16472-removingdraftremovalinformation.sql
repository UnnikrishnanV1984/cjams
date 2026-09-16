/*
   Issue Description: CDM-16472
   Category/ Module  :  
   Root cause: Removing Draft removal as requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-16472', updatedon = now() where removalid = '251698';
