/*
   Issue Description: CDM-31044
   Category/ Module  : Prod data fix to Remove Permanency plan
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update
    permanencyplan
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31044'
where
    permanencyplanid = '41a70933-bdf2-4fc8-ad1b-4550ac02bd14'
    and activeflag = 1;