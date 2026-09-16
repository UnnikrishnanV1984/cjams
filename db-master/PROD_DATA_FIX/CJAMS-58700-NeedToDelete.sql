/*
Issue Description: Need to delete 2026-2027 rate begin and end. Accidentally added an additional rate list for GAP Screen 
Category/Module: Bug
Root cause: Service Log end date is missing which is preventing the user to close the case.
Fix provided:DB queries to update record in tb_service_log table.
Data/Code fix ticket#: CJAMS-58700
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CJAMS-58700',
	updatedon = now()
where gapagreementrateid = '585cbafa-78f1-4f2d-852d-e7498e3df7ed'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
	updatedby = 'CJAMS-58700',
	updatedon = now()
where routingid in ('7c5db311-cd5b-4877-b37b-e2a5140230ee','d3f30a62-0933-4fd4-b5d5-784eaf391f6d')
	and activeflag = 1 ;

update gapratesrevision 
set activeflag = 0,
	updatedby = 'CJAMS-58700',
	updatedon = now()
where gapratesrevisionid in ('e3353442-73b5-4b48-bcd2-ef00fc641e7a','933650bb-b69a-4a19-a031-b44137d6155f')
	and activeflag = 1 ;
