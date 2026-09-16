/*
   Issue Description: CDM-28643
   Category/ Module  :  Approval Inbox
   Root cause: user wants to remove approved record
   Pull request# for data fix: 7953
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing 
set activeflag = 0, updatedby = 'CDM-28643', updatedon = now()
where routingid = '58ab5586-e625-48d2-8f01-1c29ce2cf685';