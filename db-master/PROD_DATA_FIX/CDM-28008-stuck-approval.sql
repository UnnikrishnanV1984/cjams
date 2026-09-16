-- CDM-28008 - Approval Inbox
/*
-- Issue Description: 
	3235070:Approval stuck in Approval Box
-- Category/ Module:  Approval Inbox
-- Root cause: Case Approval stuck in Inbox 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-28008',
    updatedon = now()
where
    routingid = 'c0edab3c-ff16-4e5a-8812-e1b43774d8b3'
    and activeflag = 1;