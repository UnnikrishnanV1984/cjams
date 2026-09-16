
/*
Issue: CJAMS-65960 Overdue Response Timer
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-65960
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
	update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-65960',
		updatedon = now()
where intakeserviceid  = 'f993b482-c376-47b1-b994-b62ce4fb97ea'
	and activeflag = 1;