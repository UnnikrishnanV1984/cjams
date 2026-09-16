-- CDM-26987 - Approval Inbox
/*
-- Issue Description: 
	1. The case # 221030015777 is assigned to Baltimore City jurisdiction and this case is appear on the user pending approval dashboard from Baltimore County jurisdiction
	
-- Category/ Module: Pending Approval Inbox
-- Root cause: This case is unrestricted. The case worker might have assigned to this user for approval 

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select  * from routing 
where   routingid = '4a58bb60-e9bc-48f1-8792-3bcb585bfd5a';

update 	routing
set 	activeflag = 0,
		updatedby = 'CDM-26987',
		updatedon = now()
where 	routingid = '4a58bb60-e9bc-48f1-8792-3bcb585bfd5a';