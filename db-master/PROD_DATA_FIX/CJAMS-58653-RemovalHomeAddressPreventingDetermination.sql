/*
Issue Description:User needs to connect with the case worker to get the 2nd parent info.
Category/Module: Bug
Root cause: user could not abe to update  child removal records, they can only create.
Fix provided: DB queries  update intakeservreqchildremoval table.
Data/Code fix ticket#:CJAMS-58653
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservreqchildremoval
set parent2comments  = 'Not in the home, Minimum participation' , updatedby = 'CJAMS-58653' , updatedon = now()
where intakeservreqchildremovalid = '74347bac-4db5-4cfe-be4a-8f473ede400b' and activeflag = 1;

