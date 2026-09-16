
/*Issue Description: Several Duplicate Investigation Findings Tabs
Category/Module: Bug
Root cause: Several duplicate investigation findings tabs have incorrectly populated. 
Fix provided: DB query to remove dupliacte records from the investigation finding screen
Code/Data fix ticket#: CJAMS-66677
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Soft deleted the duplicate records from DB
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update:Query: updated the endate in person program, update investigation findings
*/
update investigationallegation
set activeflag = 0,
    updatedby = 'CJAMS-66677',
    updatedon = now()
where investigationallegationid in ('68dac581-1264-4466-bc41-a6e3ac6fff1c', '917d0ced-2370-4940-b4e6-b00ac0d80084', 'b188a8a6-2a61-456b-a48b-47e58deebf59')
and activeflag=1;