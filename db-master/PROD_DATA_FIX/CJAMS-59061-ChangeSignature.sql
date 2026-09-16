
/*
Issue Description:221030014781:Need to change Signature Dates under permanency plan.
Category/Module: Bug
Root cause: user could not able to update Primary Guardian application Date records, they can only create.
Fix provided: DB queries  update gapapplication table.
Data/Code fix ticket#: CJAMS-59061
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update gapapplication
set  guardianonedate  = '2025-03-18 04:00:00.000', ldssdirectordate = '2025-03-18 04:00:00.000',updatedby = 'CJAMS-59061' , updatedon = now()
where  gapapplicationid = '12d44396-ca00-4ceb-97be-714cff5d8be7' and activeflag = 1;