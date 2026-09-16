/*
   Issue Description: CDM-22537
   Category/ Module  : Approval Inbox  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- Updatedby                             Updatedon
--8c533ce8-bc9e-4062-9d15-3e5b4421ab6c --2021-05-25 14:36:43

update cjams.routing set activeflag =0, updatedby ='CDM-22537', updatedon = now()

where routingid ='5313c666-b531-4b40-a176-e9d7b0cb889b';