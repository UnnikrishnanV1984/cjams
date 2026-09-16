/*
Issue: CJAMS-64880 Duplicate approval record in approval inbox
Root Cause:User request to delete the duplicate approval record from approval inbox for case 241030293420
Fix Provided (Data Fix Only):Data fix to delete the removal order approval request record.
Data/Code fix ticket#: CJAMS-64880
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update cjams.intakeservreqchildremoval
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64880'
	where intakeservreqchildremovalid = '05792b6a-34be-4e97-bbb5-447b97938ba5'
		and activeflag = 1;
	
update cjams.intakeservreqchildremoval_history
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64880'
	where intakeservreqchildremovalid = '05792b6a-34be-4e97-bbb5-447b97938ba5'
		and activeflag = 1;

update cjams.routing 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-64880'
	where objectid = '05792b6a-34be-4e97-bbb5-447b97938ba5'
		and activeflag = 1;