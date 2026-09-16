/*
-- Issue Description: 
-- Category/ Module: User Notifications (Case Management) 
-- Root cause: data fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update usernotification
set activeflag = 0,
	updatedby = 'CDM-29586',
	updatedon = now()
where 
	usernotificationid = 'd77e89bd-8b8f-43ef-9566-866ccda07663';