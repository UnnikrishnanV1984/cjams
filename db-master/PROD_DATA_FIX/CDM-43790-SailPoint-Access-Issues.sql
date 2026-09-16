/*
  Issue Description: CDM-437290
   Category/ Module  :  user management
   Root cause: Revoked the read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userresource 
set activeflag =0, updatedby = 'CDM-43790', updatedon = now()
where userresourceid = 'ce855d91-bc47-4e61-be34-c01379eb7fe2' and activeflag = 1 and userid = 54923; 