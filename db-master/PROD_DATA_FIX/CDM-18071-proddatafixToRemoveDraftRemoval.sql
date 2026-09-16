
/*
   Issue Description: CDM-18071
   Category/ Module  : Removing Draft removal for closed case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-18071', updatedon = now() where intakeservreqchildremovalid = '4af8f847-84b0-4c82-81b2-f7efe3a66e9b';
