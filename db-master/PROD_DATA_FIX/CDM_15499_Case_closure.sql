/*
   Issue Description: CDM-15499
   Category/ Module  :  Case worker  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequestsdm 
set isneggn_exposuretounsafe = true, updatedby = 'CDM-15499', updatedon = now()
where intakeserviceid = 'c83a0f29-31da-4802-8870-25e8941c2bf9';