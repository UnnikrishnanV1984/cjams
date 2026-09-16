/*
   Issue Description: CDM-29268
   Category/ Module  :  contact notes
   Root cause: user unable to add a new contact
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update  cjams.userresource
set activeflag = 0, updatedby = 'CDM-29268', updatedon = now()
where userid = '9659' and userresourceid = '6a7b6946-ef09-403b-9bba-97ae788560d0';