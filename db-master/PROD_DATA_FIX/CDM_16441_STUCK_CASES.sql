/*
   Issue Description: CDM-16441
   Category/ Module  :  Approval Inbox
   Root cause: user wants to remove stucked cases
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

update routing 
set activeflag = 0, updatedby = 'CDM-16441', updatedon = now()
where routingid in ('68345229-c63a-49f8-abf0-1f6015585128', '81aeb3cc-6a14-4427-8e2e-792e25822d52', '0d73b0b9-2e8f-40b6-830a-3ccca2ac0a2b');