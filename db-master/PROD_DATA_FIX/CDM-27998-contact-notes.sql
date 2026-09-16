/*
   Issue Description: CDM-27998
   Category/ Module  :  contact notes
   Root cause: user unable to add a new contact
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update
    userresource
set
    activeflag = 0,
    updatedby = 'CDM-27998',
    updatedon = now()
where
    userid = '9659';