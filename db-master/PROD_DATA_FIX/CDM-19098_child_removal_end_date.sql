/*
   Issue Description: CDM-19098
   Category/ Module  : Child Removal  
   Root cause: User requested to update the child removal end date
   Pull request# for code fix: 4407
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set exitdate = '09/30/2021' , updatedby = 'CDM-19098', updatedon  = now() where intakeservreqchildremovalid = 'aee11b60-b466-45d2-a3c4-475244698ce5'