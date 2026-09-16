
/*
Issue: CJAMS-65288 Reports case late on initial when case was not late
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-65288
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-65288',
		updatedon = now()
where intakeserviceid  = 'd19f03c1-583b-42fe-b817-c129615b3f9b'
	and activeflag = 1;