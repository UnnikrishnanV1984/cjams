/*
   Issue Description: CDM-28480
   Category/ Module  : Removal History
   Root cause: user wants to delete draft from removal history
   Pull request# for data fix:7866
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update intakeservreqchildremoval
	set activeflag = 0, updatedby = 'CDM-28480', updatedon = now() 
	where intakeservreqchildremovalid = 'bec65fdf-c617-48e3-ae3a-c126db1da184';