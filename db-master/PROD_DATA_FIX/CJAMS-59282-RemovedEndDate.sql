/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-59282
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-59282', updatedon = now()
where intakeservreqchildremovalid = '5a9ca84f-b822-429a-8a45-ff60fad7f7ee' and activeflag =1;


update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-59282', updatedon = now()
where intakeservreqchildremovalhistoryid in ('8f3eb644-42a5-4c30-8f13-d9d9fcceb58b',
'1121335a-64fc-438d-a612-9c53c4953116',
'4caa4d68-426f-48ac-9f54-359c3c6daeb3') and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-59282', updatedon = now()
where personprogramid = 'd4ee0b06-18bd-4837-8bd8-d389a682e01d' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-59282'
where eligibility_id  = 10126965 and delete_sw = 'N';
