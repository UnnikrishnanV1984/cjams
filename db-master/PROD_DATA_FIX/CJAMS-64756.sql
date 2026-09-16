/*
Issue Description:Intake was screened out on 01/21/2026 and supervisor override completed and screened in on 01/23/2026. The CPS start date & time is not taking the addendum to narrative last updated date & time.
Category/Module: Bug
Root cause: Issue is not replicable so proceeding with datafix to modify the start date
Fix provided:DB query to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-64756
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update intakeservicerequest
set reporteddate = '2026-01-23 10:58',
updatedby = 'CJAMS-64756',
updatedon = now()
where intakeserviceid='3ec4088b-9188-4262-8184-f0282cac1b57';


update intakeservicerequestdispositioncode set insertedon ='2026-01-23 10:58:08.434',updatedby = 'CJAMS-64756',
updatedon = now() where intakeservicerequestdispositioncodeid ='b4cf9a40-4e19-4c60-91db-ec2d58d9f930' and activeflag =1;