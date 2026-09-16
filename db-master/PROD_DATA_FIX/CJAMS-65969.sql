
/*
Issue: CJAMS-65969 Overdue Response Timer
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-65969
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-65969',
		updatedon = now()
where intakeserviceid  = 'fc3a33ff-a135-4a38-959f-2498b9ab4dc7'
	and activeflag = 1;