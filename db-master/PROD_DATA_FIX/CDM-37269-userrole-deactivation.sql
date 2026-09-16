
/*
   Issue Description: CDM-37269
   Category/ Module  :  User role
   Root cause: user unable to upload document due to role issue
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update userresource 
set activeflag =0,
updatedby ='CDM-37269',
updatedon =now()
where userresourceid ='45a08e4a-ab2b-4f3f-855c-b53507398aa7' 
and userid ='7681';