/*
   Issue Description: CDM-17093
   Category/ Module  :  Child removal/PA
   Root cause: user asked to end date the PA and child removal for client id 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-17093', updatedon = now() where removalid = '252483'; 
