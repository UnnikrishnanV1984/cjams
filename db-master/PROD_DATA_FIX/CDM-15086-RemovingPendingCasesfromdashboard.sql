/*
   Issue Description: CDM-15086
   Category/ Module  :  Removing pending
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing set activeflag = 0, updatedby = 'CDM-15086', updatedon = now() where routingid = '53344b68-b177-4be1-a554-b880776756b9'; 