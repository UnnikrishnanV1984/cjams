/*
Issue: Persons
Category/Module: Persons
Root cause: user ended the GAP program manually,so removing the GAP program assignment end date as there is an active GAP for the child.
Fix provided: Data fix has been done to remove the GAP program assignment end date as there is an active GAP for the child.
Data/Code fix ticket#: CJAMS-62994
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: CIDM-10875
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update personprogramarea 
set enddate = null, updatedby = 'CJAMS-62994', updatedon = now() where personprogramid = '633a488d-de0d-467c-84f7-470a46b8906c' and activeflag=1;

