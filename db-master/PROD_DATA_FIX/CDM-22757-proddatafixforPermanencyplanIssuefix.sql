/*
   Issue Description: CDM-22757
   Category/ Module  : Updating Intakeservice request actor ID issue
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update permanencyplan set intakeservicerequestactorid = 'cdc343da-bc41-4d54-9144-8c7fa826c964', updatedon = now(), updatedby ='CDM-22757' 
where permanencyplanid = '577db590-c917-40ed-8d99-616900dbfddb';