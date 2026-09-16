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
	updatedby = 'CDM-29692',
	updatedon = now()
where 
	usernotificationid = '66816e69-bedd-4cfd-b93e-70593d55aace';