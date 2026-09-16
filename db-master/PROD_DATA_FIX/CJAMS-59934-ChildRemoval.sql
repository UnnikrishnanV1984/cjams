/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates  ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-59934
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-59934', updatedon = now(),
returntransts = Null,
returndate = Null,
returntime = Null,
removalexitreason = NULL
where intakeservreqchildremovalid = '4324162a-b648-40c5-8084-fbcb6f8dc95d' and activeflag =1;


update intakeservreqchildremoval_history
set exitdate = null ,updatedby = 'CJAMS-59934', updatedon = now()
where intakeservreqchildremovalhistoryid = 'f5146336-41be-4ab1-9a35-d7ea2b7be3ac' and activeflag =1;

update personprogramarea
set enddate = null, updatedby = 'CJAMS-59934', updatedon = now()
where personprogramid = '7395c9ba-4ad0-484a-a713-3b984ed51f42' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-59934'
where eligibility_id  = 10001300 and delete_sw = 'N';
