-- CDM-26949 - Approval Inbox
/*
-- Issue Description: 
	3176482:Approval stuck in Approval Box
	
-- Category/ Module:  Approval Inbox
-- Root cause: Case Approval stuck in Inbox 

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	activeflag, * from routing
where 	tosecurityusersid = '47194b3d-bf52-416c-a53b-82888c49d6a2'
		and objectid = 'ad168cf2-f3e0-444f-9d33-a79227d120fa';

update 	routing
set 	activeflag = 0,
		updatedby = 'CDM-26949',
		updatedon = now()
where 	routingid = '3fbe9fa5-f549-4e99-932c-89cfc64bb70c' and activeflag = 1;