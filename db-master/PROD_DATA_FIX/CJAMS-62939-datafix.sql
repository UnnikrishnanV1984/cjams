/*
Issue: Persons
Category/Module: Persons
Root cause: User requested to update the client Previous Adoption Date as 8/27/2001 under the person profile.
Client ID#: 1254120 (Shalena Curry)
Fix provided: Data fix has been done to  to update the client Previous Adoption Date as 8/27/2001 under the person profile.
Client ID#: 1254120 (Shalena Curry)
Data/Code fix ticket#: CJAMS-62939
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update person 
set preadoptiondate = '2001-08-27',
    updatedby = 'CJAMS-62939',
    updatedon = now()
where personid = 'a30fef0a-05b4-4711-8219-a44edc89cae3' 
and activeflag=1;
