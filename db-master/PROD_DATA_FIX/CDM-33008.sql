/*
   Issue Description: CDM-33008
   Category/ Module  :  Notification
   Root cause: user wants to update Notification from name 
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/

update usernotificationmap set fromsecurityusersid='2744efa4-8129-48fb-b292-7c4351f66f89',updatedby ='CDM-33008',updatedon =now() 
where usernotificationmapid='acbeec54-f894-4f53-8c31-a2af686db94b';