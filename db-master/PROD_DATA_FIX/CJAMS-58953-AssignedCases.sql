
/*
Issue Description:Please remove both cases (241030382019 & 2020036405056) from the supervisor to be assigned dashboard.
Category/Module: Error
Root cause: Due to data glitch caused servicecase status was open instead of assign.
Fix provided: DB queries to change the status
Data/Code fix ticket#:CJAMS-58953
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


--Updateing Servicease
update servicecase 
set statustypekey = 'ASSGN' , updatedby = 'CJAMS-58953', updatedon = now()
where servicecaseid in ('30a1a4c0-9846-4a61-a2f7-41a6dc74adf1',
'5114afd1-4a70-4662-9c90-56453548334b') and activeflag = 1;