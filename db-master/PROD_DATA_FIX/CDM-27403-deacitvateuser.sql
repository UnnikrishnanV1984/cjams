/*
  Issue Description: CDM-27403 DAM-13327 - Removal of a SailPoint account: Jessyca Orzech
   Category/ Module  :  User management
   Root cause: Removing unwanted table active record for the deactivated users
   Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update cjams.securityusers set  activeflag=0, updatedby='CDM-27403', updatedon=now()  where securityusersid='6da801a8-c5c3-439f-96d8-ae6dc369ed0b';
update cjams.teammemberassignment set  activeflag=0, updatedby='CDM-27403', updatedon=now() where securityusersid='6da801a8-c5c3-439f-96d8-ae6dc369ed0b';
update cjams.rolemapping set  activeflag=0, updatedby='CDM-27403', updatedon=now() where principalid ='14243' and activeflag=1;
update cjams.userresource set  activeflag=0, updatedby='CDM-27403', updatedon=now() where userid ='14243' and activeflag=1;