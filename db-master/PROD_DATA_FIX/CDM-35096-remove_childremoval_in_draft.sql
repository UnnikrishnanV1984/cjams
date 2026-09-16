/*
   Issue Description: CDM-35096
   Category/ Module  : Prod data fix to Remove Removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set activeflag =0,updatedby ='CDM-35096',updatedon =now() where intakeservreqchildremovalid='4402bb5a-7523-4798-9dfd-d26d9e636e6c';

update cjams.intakeservreqchildremoval_history set activeflag =0,updatedby ='CDM-35096',updatedon =now() where intakeservreqchildremovalid='4402bb5a-7523-4798-9dfd-d26d9e636e6c';