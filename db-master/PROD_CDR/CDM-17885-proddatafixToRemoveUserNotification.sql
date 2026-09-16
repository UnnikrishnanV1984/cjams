
/*
   Issue Description: CDM-17885
   Category/ Module  :Removing user notification
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update usernotification set activeflag = 0, updatedby = 'CDM-17885', updatedon = now() where usernotificationid = '0aeb7e57-0921-4336-aed5-bafd5f720e56';