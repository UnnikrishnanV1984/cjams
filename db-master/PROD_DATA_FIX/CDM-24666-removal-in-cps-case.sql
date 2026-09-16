/*
   Issue Description: CDM-24666
   Category/ Module  : Child removal
   Root cause: remove the duplicate child removal 
   Pull request# for data fix: 6235
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby ='CDM-24666' ,updatedon = now() 
where intakeservreqchildremovalid ='50556ef4-d987-4fe7-8fd5-97cb90f9eed2';