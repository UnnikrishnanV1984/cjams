
/*
Issue Description: 251023000951:Marian Tibrey-case accepted as neglect on 2/19, Social worker saw the children on 2/21, while at the hospital, bruises were noticed on the children. Screening was notified and when physical abuse was added, the override caused it to be overdue. Please start the date on 2/21, 
the date the overide was approved, not the date the report was received. 
Category/Module: Bug
Root cause: due to data glitch caused user can only create intake , but they do not have access to update or edit record.
Fix provided:DB queries to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-59166
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update intakeservicerequest
set reporteddate = '2025-02-21 00:00:00.000',updatedby = 'CJAMS-59166', updatedon = now()
where intakeserviceid = 'f4ff7cb0-3d19-4819-815b-fe6bdfa33d5f' and activeflag =1;
