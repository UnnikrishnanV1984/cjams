
/*
Issue Description: Data Entry Error
Category/Module: Bug
Root cause: This is a known issue and code fix will be done, Proceeding with datafix for this case
Fix provided:Data fix is done to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-67786
Regression Impacts: N/A
Is Code fix Required?: Y - CIDM-11278
Code fix ticket#: CIDM-11278.
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update intakeservicerequest
set reporteddate = '2026-05-07 14:42:00',
updatedby = 'CJAMS-67786',
updatedon = now()
where intakeserviceid='84a92e78-35c6-4bbb-a941-cbe97d8bf2be'
and activeflag=1;

select * from cjams.cpsresponsetimerupdate('84a92e78-35c6-4bbb-a941-cbe97d8bf2be'::uuid, 'CJAMS-67786'::character varying );