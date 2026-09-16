/*
   Issue Description: CDM-37270 - Approval Inbox
   The permanency plan approval for 23103011221 is stuck in my inbox for Rasheed Hamilton. This request was approved months ago. 
   Category/ Module  : Approval Inbox
   Root cause: Approved case is showing in Case pending Approval Dashboard. user requested to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/

update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37270'
    where routingid = '95849365-68ad-489f-b603-1f7c742e91ea'
    	and activeflag = 1;