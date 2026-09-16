/*
   Issue Description: CDM-15924
   Category/ Module  :  
   Root cause: Inserting Gap disclosure
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-16114', updatedon = now() where removalid = '250896';
