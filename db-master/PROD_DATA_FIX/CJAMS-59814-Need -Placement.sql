/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-59814
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-59369', updatedon = now()
where intakeservreqchildremovalhistoryid in ('1a5e978d-20e8-42de-82a3-26949ed6c021','c6f99f8c-fb2f-44b8-b0dd-8b5dd4dc39cf') and activeflag =1;

update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-59814', updatedon = now(),
returntransts = Null,returndate = Null,returntime = Null,removalexitreason = NULL
where intakeservreqchildremovalid = '6fb64c49-ed22-4dad-86fa-7e677632b3ed' and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-59814', updatedon = now()
where personprogramid = '7a893591-046e-465f-904e-8d5936251312' and activeflag=1;

update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-59369'
where eligibility_id  = 159789 and delete_sw = 'N';
