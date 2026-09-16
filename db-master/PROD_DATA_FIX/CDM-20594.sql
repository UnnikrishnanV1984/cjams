/*
   Issue Description: CIDM-20594
   Category/ Module  :  
   Root cause: Old Assessments in Approval Inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the data fix if already submitted and expected prod fix date: 
   removed the record from pending approval
*/

update routing set activeflag  = 0,
updatedon  = now() ,
updatedby  = 'CDM-20594'
where routingid  in ('d4570c5f-55a3-4e56-9c35-211d9ca356d6', '7997ebf6-78f4-4d48-a8b2-84daa449be02')
and activeflag  = 1;
