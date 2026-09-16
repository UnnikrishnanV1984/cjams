/*
   Issue Description: CDM-22918
   Category/ Module  : Approved Inbox 
   Root cause: This is a migration case 
   Pull request# for code fix: 4235
   Reason why no related code fix:  user requested to delete this record
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- This is a migration record and this assessment record it self not exist only they insertes approval review inbox record  that's why i am just removing this approval record 

update cjams.routing set activeflag =0, updatedby='CDM-22918', updatedon =now()

where routingid ='0218c8e9-88ed-41d8-87fc-4edb1d140c0e';