
/*
Issue Description:251022979808:Start mandate on 1/10, the date the override occured, not the date the case was initially received.
Category/Module: Bug
Root cause: due to data glitch caused user can only create intake , but they do not have access to update or edit record.
Fix provided:DB queries to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-59167
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakeservicerequest
set reporteddate = '2025-01-10 00:00:00.000',updatedby = 'CJAMS-59167', updatedon = now()
where intakeserviceid = 'c981dc5c-4558-4500-834a-31a00c870223' and activeflag =1;
