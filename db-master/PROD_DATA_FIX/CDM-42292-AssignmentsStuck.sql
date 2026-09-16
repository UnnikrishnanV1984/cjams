/*
Issue Description:Need to remove case # 231030138258 from the supervisor dashboard.
Category/Module: Error
Root cause: servicecase status was open instead of assign
Fix provided: DB queries to chnage the status
Data/Code fix ticket#:CDM-42292
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


--Updateing Servicease
update servicecase 
set statustypekey = 'ASSGN' , updatedby = 'CDM-42292', updatedon = now()
where servicecaseid = '741e7499-f16e-4267-9a07-d6bbec81dcd9' and activeflag = 1;
