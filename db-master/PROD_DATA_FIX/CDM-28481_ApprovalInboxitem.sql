/*
   Issue Description: CDM-28481
   Category/ Module  : Approval Inbox item
   Root cause:3196463:Dashboard:This item has already been approved yet it has not come out of my inbox.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/






update cjams.routing set activeflag =0, updatedby = 'CDM-28481', updatedon = now() where routingid='e481af63-c9c6-4a09-99a8-5d8239dbbf79' and activeflag =1 
