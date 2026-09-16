
/*
   Issue Description: CDM-14974
   Category/ Module  :  Removing Draft Removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby ='CDM-14974', updatedon = now() where removalid = '252344';
