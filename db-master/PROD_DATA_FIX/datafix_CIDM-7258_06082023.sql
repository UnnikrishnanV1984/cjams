-- CIDM-7258 - Contact Support Ticket Clean Up
/*
Contact Support Ticket Clean Up

-- Contact Support Ticket Clean Up to 
1) To update the ldssregion as null for the tickets are created by the external provider users
	
-- Category/ Module: Contact Support Ticket
-- Root cause: To fix Jira tickets data issue
-- Fix Provided: Datafix for Contact Support Ticket Clean Up
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) To update the ldssregion as null for the tickets are created by the external provider users
select count(*) 
	from defecttracking.supportlog sp 
where btrim(ldssregion) = '' 
	and jiraenv = 'Production'
	and activeflag = 1 ;

update defecttracking.supportlog 
set ldssregion = NULL,
	updatedby = 'CIDM-7258-9', 
	updatedon = now() 
where btrim(ldssregion) = '' 
	and jiraenv = 'Production'
	and activeflag = 1 ;
