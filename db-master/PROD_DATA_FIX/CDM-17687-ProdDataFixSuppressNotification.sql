/*
   Issue Description: CDM-17687
   Category/ Module  : User Notification  
   Root cause: User received unknow notification
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.usernotification set activeflag = 0 , updatedby = 'CDM-17687', updatedon = now() where usernotificationid = '764d4f17-bfd3-49d1-8445-6115321448ee';  