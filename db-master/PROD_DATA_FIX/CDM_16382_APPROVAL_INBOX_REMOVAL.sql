/*
   Issue Description: CDM-16382
   Category/ Module  :  Approval Inbox 
   Root cause: user wants to remove the dupliate records
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

update routing 
set activeflag = 0, updatedby = 'CDM-16382', updatedon = now()
where routingid in ('2dfd4532-7ef8-4272-a7d1-543802d85111', 'ed58f44b-f201-4a9b-9556-681c16756cde');