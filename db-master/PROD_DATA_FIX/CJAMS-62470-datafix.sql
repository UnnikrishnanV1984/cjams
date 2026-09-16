/*
Issue Description:3117128 Remove the blank Hospitalization record
Category/Module: User Error
Root cause: Users requested to Remove the blank Hospitalization record
Fix provided: DB queries to Remove the blank Hospitalization record
Data/Code fix ticket#: CJAMS-62470
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update personhospitalization
set activeflag = 0, updatedby = 'CJAMS-62470', updatedon = now()
where hospitalizationid = '49406797-9a35-4d55-bbb6-895bc01eb68c';

update personhospitalization_history
set activeflag = 0, updatedby = 'CJAMS-62470', updatedon = now()
where hospitalizationid  = '49406797-9a35-4d55-bbb6-895bc01eb68c';