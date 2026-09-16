/*
   Issue Description: CDM-31985
   Category/ Module  : 
   Root cause: user want to update caseworker name displayed in the notification.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

update usernotificationmap set fromsecurityusersid='991e43ab-c06b-4195-b446-c4f80ef8433a' ,updatedby ='CDM-31985',updatedon =now()
where usernotificationmapid='36fa49e8-5d5b-4b03-8fc0-e93288476cca';