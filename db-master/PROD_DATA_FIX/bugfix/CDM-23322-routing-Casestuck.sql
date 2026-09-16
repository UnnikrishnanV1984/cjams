-- CDM-23322 -Case is stuck in approval box
/*
   File Name: CDM-23322-routing-Casestuck
Issue Description: 
    For the case 221030015182:The Perm Plan has been approved but it still is populating in my approval box.User wants it to be removed.
    Customer Email ID:michelle.sears@montgomerycountymd.gov
  
-- Resolution: Updated the ActiveFlag to zero in the routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	routing
set
	activeflag = 0,
	updatedby = 'CDM-23322',
	updatedon = now()
where
	routingid = '3ff99788-4d5b-40ab-8b34-9a7d5af0b606'
	and activeflag = 1;