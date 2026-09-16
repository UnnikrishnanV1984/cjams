/*
   Issue Description: CDM-44118 User requested to delete the draft child removal as it is incorrect
   Category/ Module  : Child Removal
   Root cause: User requested to remove the draft child removal as it is incorrect.
   Fix Provided: Data fix has been done to remove the draft child removal.
   Data/Code fix ticket#: CDM-44118
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: User error 
*/

update intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CDM-44118',
	updatedon = now()
where intakeservreqchildremovalid='1ef7c519-58a4-4f16-b82a-1c54b092de95'
and activeflag = 1;


update intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-44118',
	updatedon = now()
where intakeservreqchildremovalid='1ef7c519-58a4-4f16-b82a-1c54b092de95'
and activeflag = 1;