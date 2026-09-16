/*
   Issue Description: CDM-23721
   Category/ Module  : Prod data fix to Remove Permanency plan
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update permanencyplan set activeflag = 0, updatedon = now(), updatedby = 'CDM-23721' 
where permanencyplanid = '1aaeed2e-89e0-41b4-a757-d58d387a54fa' and activeflag = 1;