/*
   Issue Description: CDM-15950
   Category/ Module  :  child removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval
set updatedby = 'CDM-15950', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = 'a68698c5-9a8c-4fdf-8bd6-64aeefee02cb';