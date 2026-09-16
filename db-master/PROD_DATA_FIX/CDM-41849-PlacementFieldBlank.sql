/*
Issue Description: FTDM was saved without picking a placement
Category/Module: Error
Root cause: FTDM was saved without picking a placement
Fix provided: DB query to add relevant placement data to recording
Data/Code fix ticket#: CDM-41849
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Adding data to meetingrecording
update meetingrecording
set placementid = '155d57dc-3a6b-4fc8-9dd0-0c4aa65787cd', updatedby = 'CDM-41849', updatedon = now()
where meetingrecordingid = '149a9cd3-f15d-4753-bc50-b2a0b14eccae' and activeflag = 1;