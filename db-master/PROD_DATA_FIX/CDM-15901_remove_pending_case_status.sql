/*
   Issue Description: CDM-15901
   Category/ Module  : Service case assignment
   Root cause: Approved case is listed on pending case dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-15901' , updatedon = now() where routingid = 'b4ccd197-7e16-4d92-ae4d-93bcde2c43e2';