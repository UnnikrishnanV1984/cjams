
/*
Issue: CJAMS-67040 Overdue Response Timer
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done by updating the reported date and time and to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-67040
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:
*/

update intakeservicerequest 
set reporteddate ='2026-04-10 14:53:33.714', updatedby='CJAMS-67040', updatedon =now()
where intakeserviceid ='bcc3ec72-79eb-472a-8041-550adca85246';

update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-67040',
		updatedon = now()
where intakeserviceid  = 'bcc3ec72-79eb-472a-8041-550adca85246'
	and activeflag = 1;
