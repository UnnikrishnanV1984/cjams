/*
-- Issue Description: 
-- Category/ Module: User Notifications (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update usernotification
set activeflag = 0,
	updatedby = 'CDM-29690',
	updatedon = now()
where 
	  usernotificationid = 'cc7e6f41-cfb7-4e62-8f1f-7f73cb9f29ca';
