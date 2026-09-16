/*
   Issue Description: CDM-16517
   Category/ Module  :  Approval Inbox
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/


update routing 
set activeflag = 0, updatedby = 'CDM-16517', updatedon = now()
where routingid = 'f80f301e-a7f3-4a74-8a87-c625d0bee7fc';