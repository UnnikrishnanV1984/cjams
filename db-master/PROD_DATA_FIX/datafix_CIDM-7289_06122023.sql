-- CIDM-7289 
-- Deactivate support log tickets for which frommailid user profiles are not found and insertedby is null
/*
Contact Support Ticket Clean Up

-- Contact Support Ticket Clean Up to 
1) To Deactivate APS support log tickets for which frommailid user profiles are not found and insertedby is null
	
-- Category/ Module: Contact Support Ticket
-- Root cause: User Setup Issue 
-- Fix Provided: Datafix to update correct Team IDs for MD Think team members 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) To Deactivate APS support log tickets for which frommailid user profiles are not found and insertedby is null
select supportlogid, supportno, frommailid, insertedby, jirarequestsent, jirarequestno, 
	activeflag, updatedby, updatedon
from defecttracking.supportlog 
where insertedby is null
	and jiraenv = 'Production'
	and application = 'AS' 
	and activeflag = 1 ;
	
update defecttracking.supportlog 
set activeflag = 0,	
	updatedby = 'CIDM-7289', 
	updatedon = now()
where insertedby is null
	and jiraenv = 'Production'
	and application = 'AS' 
	and activeflag = 1 ;
