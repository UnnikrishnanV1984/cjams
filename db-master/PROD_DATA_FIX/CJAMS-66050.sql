
/*
Issue: CJAMS-66050 Overdue Response Timer
Category/Module: Response Timer
Root cause: Overdue reason button appeared eventhough user met response timer condiiton.
Fix provided:  Data fix has been done to remove the Overdue Reason Button
Data/Code fix ticket#: CJAMS-66050
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
update cjams.cpsresponsetimeractions
	set activeflag = 0, 
		updatedby = 'CJAMS-66050',
		updatedon = now()
where cpsresponsetimeractionsid  in ('cb3fde19-144d-46ec-964c-7e45f04c171b','d348548c-7cde-4a05-9d0b-230c53d8c2f5')
and activeflag = 1;