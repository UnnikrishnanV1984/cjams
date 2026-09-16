/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates  ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-58929
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-58929', updatedon = now()
where intakeservreqchildremovalid = '1409beb6-2b07-49a9-b183-de200a585a84' and activeflag =1;


update personprogramarea
set enddate = null, updatedby = 'CJAMS-58929', updatedon = now()
where personprogramid = '0f6dbf82-9bf4-4f3f-b432-fe1d25340654' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-58929'
where eligibility_id  = 10102664 and delete_sw = 'N';
