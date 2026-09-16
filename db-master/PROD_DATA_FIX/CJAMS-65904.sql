

/*
Issue: CJAMS-65904 Overdue Response Timer
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-65904
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-65904',
		updatedon = now()
where intakeserviceid  = '8f3b00d6-750b-4b99-b71a-9064c899eb67'
	and activeflag = 1;