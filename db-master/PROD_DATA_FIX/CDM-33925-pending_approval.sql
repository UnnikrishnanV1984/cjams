/*
   Issue Description: CDM-33925
   Category/ Module  : Approval Inbox
   Root cause: Pending approval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag = 0,updatedby ='CDM-33925',updatedon =now() where routingid = '67ecf81b-534e-4a08-9a2a-f078dde40a28';