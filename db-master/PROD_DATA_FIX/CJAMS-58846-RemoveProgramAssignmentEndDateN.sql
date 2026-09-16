/*
Issue Description: Program assignment for Arianna Roy (478043176) was incorrectly end dated. Please remove the end date for the GAP program assignment so it remains active.
Category/Module: Bug
Root cause: The GAP program was ended by mistake, and the user couldn't update it to keep it active.
Fix provided: DB queries  update enddate personprogramarea tables
Data/Code fix ticket#: CJAMS-58846
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update personprogramarea 
set enddate = null, updatedby = 'CJAMS-58846', updatedon = now()
where personprogramid = '016146e1-b38b-4688-88d8-6717bc75b9af' and activeflag =1;