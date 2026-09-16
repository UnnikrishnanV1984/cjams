
/*
Issue: Please delete the respective intake as requested.
Category/Module: User Error
Root cause: User cannot delete an intake intakedastaging intakedastatus tables.
Fix provided: DB query to dete recor in 
Data/Code fix ticket#: CDM-44218
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update intakedastaging
set activeflag = 0, updatedon = now() ,updatedby = 'CDM-44218'
where id = 11745930 and activeflag = 1;

update intakedastatus
set activeflag = 0, updatedon = now() ,updatedby = 'CDM-44218'
where intakedastatusid  = 'f3831a6f-a4f1-426e-97f1-d9a597a4ed9d' and activeflag = 1;