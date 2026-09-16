/*
   Issue Description: CDM-24735
   Category/ Module  : Removal 
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
 --There is no placement records found this one.

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-24735', updatedon = now() 

where intakeservreqchildremovalid = '50556ef4-d987-4fe7-8fd5-97cb90f9eed2';