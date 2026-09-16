/*
Issue Description: 3160124:Migrated case error - Datafix neededOn the Permanency Plan tab, Daniel Fairbanks has the plan with the active GAP should not have an end date. Please complete a data fix to remove the end date on the plan "Guardianship by Non-Relative"
Category/Module: permanencyplan table
Root cause: Request for a data fix to end date in the record with the active GAP under Permanency Plan tab for Daniel Fairbanks.
Fix provided: Yes, write db query
Code fix ticket#: CDM-39628
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

update permanencyplan
set 
	enddate = null,
	updatedby = 'CDM-39628',
	updatedon = now()
where permanencyplanid = '5d955bef-6ebf-4a28-891f-df1f45fa7642' and activeflag = 1;