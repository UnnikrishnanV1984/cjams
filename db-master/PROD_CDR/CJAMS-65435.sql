
/*
Issue: CJAMS-65435 Overdue Response Timer
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-65435
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-65435',
		updatedon = now()
where intakeserviceid  = '37b058f1-b291-4ff2-8e2f-3219892b76f3'
	and activeflag = 1;