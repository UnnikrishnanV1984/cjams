/*
   Issue Description: CJAMS-68281
   Category/ Module: Requested to remove case# 3223886 from Approval Inbox
   Root Cause: User Wants to remove case# 3223886 from Approval Inbox of tawana.nolan@maryland.gov
   Fix Provided: Data fix has been provided by removing the case# 3223886 from Approval Inbox of tawana.nolan@maryland.gov
   Pull request for code fix: 
   Reason why no related code fix: 
*/

update routing 
set activeflag =0, updatedby ='CJAMS-68281', updatedon =now()
where routingid ='71f7373b-8770-48dc-985b-74567708d9dd' and activeflag =1;