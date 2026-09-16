-- CDM-26412 - Case Removal
/*
-- Issue Description: 
	1. User Pending Approval Box has an old case from last year. Client 3251621

-- Category/ Module: Pending Approval Inbox
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	activeflag , routingstatustypeid , *  from routing r 
where 	routingid in ('a01ab93f-00db-4341-93cd-5a1bfe149ae3', 'db2efcad-e425-4b4b-afd3-53b5082d9fbb');

update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-26412',
		updatedon = now()
where 	routingid in ('a01ab93f-00db-4341-93cd-5a1bfe149ae3', 'db2efcad-e425-4b4b-afd3-53b5082d9fbb');