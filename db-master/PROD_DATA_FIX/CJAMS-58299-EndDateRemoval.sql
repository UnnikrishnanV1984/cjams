
/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-58299
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-58299', updatedon = now()
where intakeservreqchildremovalid = '3548c02a-dd14-4829-a39c-6a681bd13675' and activeflag =1;


update personprogramarea
set enddate = null, updatedby = 'CJAMS-58299', updatedon = now()
where personprogramid = '3654ac42-ac36-475e-94e3-c74da7d7379b' and activeflag = 1 ;


update placement 
set exittypekey = 'CIPS' ,updatedby = 'CJAMS-58299', updatedon = now()
where placementid = 'f49eb4af-5a96-4fb8-8d60-3f27cc49c58f' and activeflag = 1;


update placementrevision 
set exittypekey = 'CIPS' ,updatedby = 'CJAMS-58299', updatedon = now()
where placementrevisionid = 'ec0948e8-8205-43ae-8527-206773afb8d6' and activeflag = 1;

update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-58299'
where eligibility_id  = 162068 and delete_sw = 'N';