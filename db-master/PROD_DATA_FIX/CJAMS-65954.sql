
/*
Issue: CJAMS-65954 Timer Running
Category/Module: Response Timer
Root Cause: Received user confirmation. Need to:Revert the current fix of stopping the response timer and Add fix to remove the Overdue Reason button.
Fix Provided: Data fix has been done to remove overdue reason button.
Data/Code fix ticket#: CJAMS-65954
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue, not a code defect
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-65954',
		updatedon = now()
where intakeserviceid  = 'e8a49e7a-0069-45e9-bcd3-5a8b73e6b17c'
	and activeflag = 1;