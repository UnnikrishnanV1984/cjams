-- CIDM-7258 - Contact Support Ticket Clean Up
/*
Contact Support Ticket Clean Up

-- Contact Support Ticket Clean Up to 
1) To update the frommailid (user email id) based on the insertedby (securityusersid)
	
-- Category/ Module: Contact Support Ticket
-- Root cause: To fix Jira tickets data issue
-- Fix Provided: Datafix for Contact Support Ticket Clean Up
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) To update the frommailid (user email id) based on the insertedby (securityusersid)
select sp.application, 
	sp.activeflag, 
	sp.insertedby, 
	sp.frommailid, 
	sp.ldssregion, 
	(select email from userprofile where securityusersid = sp.insertedby) as new_email
from defecttracking.supportlog sp
where sp.activeflag = 1
	and sp.frommailid is null 
	and sp.insertedby is not null ;

update defecttracking.supportlog sp
set frommailid = (select email from userprofile where securityusersid = sp.insertedby),
	updatedby = 'CIDM-7258-10', 
	updatedon = now() 
where activeflag = 1
	and frommailid is null 
	and insertedby is not null ;
