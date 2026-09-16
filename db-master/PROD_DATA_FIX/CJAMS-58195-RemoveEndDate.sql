/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-58195
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-58195', updatedon = now()
where intakeservreqchildremovalid = '62130df5-1ef5-4d71-86d7-7ee05924df39' and activeflag =1;


update personprogramarea
set enddate = null, updatedby = 'CJAMS-58195', updatedon = now()
where personprogramid = '481dd7e5-3948-4e5f-8ff9-a3b9a998b5ae' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-58195'
where eligibility_id  = 10005586 and delete_sw = 'N';