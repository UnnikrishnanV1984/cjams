/*
Issue: CJAMS-65063 There is a service plan review in the approval screen of Lauren Reider who needs to be off boarded so this needs to be cleared 
Root Cause:User request to delete the approval record from Lauren Reider's approval inbox 
Data/Code fix ticket#: CJAMS-65063
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update cjams.routing 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-65063'
	where routingid = 'e5a479cd-4ec4-4d9c-bcd8-268e7639c9b6';