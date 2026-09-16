/*
   Issue Description: CDM-37626
   Category/ Module  :  Case Pending Approval
   Root Cause: User Wants to Remove The Stucked Cases
   Fix Provided: Data Fix Provided.
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/

select * from routing where objectid = 'e6a10ad7-f416-4b79-98ab-2a443bf0f1ce' and routingid = 'd32385d7-8536-452c-b767-c9026cd5fe63';

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-37626'
where routingid = 'd32385d7-8536-452c-b767-c9026cd5fe63' and objectid = 'e6a10ad7-f416-4b79-98ab-2a443bf0f1ce' and activeflag = 1;