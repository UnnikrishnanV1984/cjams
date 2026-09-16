 /*
  Issue Description: CDM-27370 DAM-13320 - SAILPOINT - remove account: Cierra Costello
   Category/ Module  :  User management
   Root cause: Removing unwanted table active record for the deactivated users
   Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/


update cjams.securityusers set  activeflag=0, updatedby='CDM-27370', updatedon=now()  where securityusersid='ce38f93f-7a1c-46f3-b0ab-7f5df6baf8b4';
update cjams.teammemberassignment set  activeflag=0, updatedby='CDM-27370', updatedon=now() where securityusersid='ce38f93f-7a1c-46f3-b0ab-7f5df6baf8b4';
update cjams.teammember set  activeflag=0, updatedby='CDM-27370', updatedon=now() where teammemberid='502be4d6-2614-4060-992b-ba109b629229';
update cjams.rolemapping set  activeflag=0, updatedby='CDM-27370', updatedon=now() where principalid ='13276' and activeflag=1;
update cjams.userresource set  activeflag=0, updatedby='CDM-27370', updatedon=now() where userid ='13276' and activeflag=1;
