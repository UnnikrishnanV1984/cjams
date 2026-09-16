/*
   Issue Description: CDM-33011
   Category/ Module  :  Notification
   Root cause: user wants to update Notification from name 
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update usernotificationmap set fromsecurityusersid='991e43ab-c06b-4195-b446-c4f80ef8433a' ,updatedby ='CDM-33011',updatedon =now()
where usernotificationmapid='44c276e8-c84f-4111-a243-f7b58321fdad';