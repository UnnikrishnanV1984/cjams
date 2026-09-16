-- CIDM-6799 - Contact Support Ticket: Move Approved Tickets to unapproved status for the ones 
--             which not created JIRA ID
/*
-- Issue Description: 
    Move Approved Tickets to unapproved status for the ones which not created JIRA ID
	We need to update the Contact Support ticket Status back to unapproved / waiting for approval for the tickets that are created from 1/1/2023 to till date.
	We have 78 tickets
	
-- Category/ Module: Contact Support Ticket
-- Root cause: Issue on ESMS 
-- Fix Provided: Datafix was promoted to update the Contact Support Ticket as Pending.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select supportlogid, jirarequestsent, updatedby, updatedon, jirarequestno  	
	from defecttracking.supportlog
where activeflag = 1
	and jiraenv = 'Production'
	and coalesce(jirarequestsent, 'Pending') in ( 'Approve', 'Approved')
	-- and application  = 'CW'
	and jirarequestno is null
	and insertedon::date >= '2023-01-01'::date ;
	
update defecttracking.supportlog
set jirarequestsent = NULL,
	updatedby  = 'CIDM-6799',
	updatedon  = now()
where supportlogid in 
	(	
	select supportlogid	
	from defecttracking.supportlog
	where activeflag = 1
		and jiraenv = 'Production'
		and coalesce(jirarequestsent, 'Pending') in ( 'Approve', 'Approved')
		-- and application  = 'CW'
		and jirarequestno is null
		and insertedon::date >= '2023-01-01'::date
	) ;
	
select supportlogid, jirarequestsent, updatedby, updatedon, jirarequestno  	
	from defecttracking.supportlog
where updatedby = 'CIDM-6799'
	and updatedon::date = current_date ;	