/*
   Issue Description: CDM-16992
   Category/ Module  :  Child removal
   Root cause: User asked to remove a child removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-16992', updatedon = now() 
where intakeservreqchildremovalid = '38d14f09-6f15-4cd9-b6ef-745c32fdb538';