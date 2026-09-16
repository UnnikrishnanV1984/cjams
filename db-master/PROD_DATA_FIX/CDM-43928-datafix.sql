/*
Issue Description: data fix
User request remove the case assignment (1/17) and close the case (231030160539) as intake, 
persons and contacts data are not available and need to removed it on workload.
Category/Module: Support
Root cause: remove the case assignment (1/17) and close the case (231030160539) as intake, 
persons and contacts data are not available and need to removed it on workload.
Fix provided: Data fix to remove the case assignment (1/17) and close the case (231030160539) as intake, 
persons and contacts data are not available and need to removed it on workload.
Data/Code fix ticket#: CDM-43928
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed',
dispositioncode = 'Closed',
    updatedby = 'CDM-43928',
    updatedon = now()
where servicecaseid = '08beaf96-0175-4fad-ba04-6ec3c470085e' and activeflag = 1;

update servicecase
set statustypekey = 'ASSGN',
    updatedon = now(),
    updatedby = 'CDM-43928'
where servicecaseid = '08beaf96-0175-4fad-ba04-6ec3c470085e' and activeflag = 1;

UPDATE caseassignment 
set activeflag = 0,
    updatedby = 'CDM-43928',
    updatedon = now() 
WHERE caseassignmentid = 'e832b6f7-3b57-43cf-8e0c-bd4b090f6e4f' and activeflag = 1