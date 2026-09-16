
/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-58057
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-58057', updatedon = now()
where intakeservreqchildremovalid = '6a6bd2f6-7e5c-4e39-9bd5-21ba5720f6d3' and activeflag =1;


update personprogramarea
set enddate = null, updatedby = 'CJAMS-58057', updatedon = now()
where personprogramid = '24a3261c-e5b6-49da-95fd-1b0955c90839' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-58057'
where eligibility_id  = 10125965 and delete_sw = 'N';