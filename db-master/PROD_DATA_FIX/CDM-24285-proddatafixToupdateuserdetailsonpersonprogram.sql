/*
   Issue Description: CDM-CDM-24285
   Category/ Module  : Prod data fix to update user details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 370b988d-ed28-417e-bb3c-4f20051cb0c9
update personprogramarea set updatedby = '89f87ac0-bd69-4170-a7a8-21447db3492a' , updatedon =  now()
where personprogramid = '9f08c9d9-f843-4e61-974b-1ca6e95b275c';