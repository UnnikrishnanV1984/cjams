/*
Issue Description: remove the Child Removal  End Date as requested.
Root cause: After end the Living Arrangement , data not updated into child removal end reason filed, user request update the data.
Fix provided: DB queries  update enddate intakeservreqchildremoval tables
Data/Code fix ticket#: CJAMS-60836
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservreqchildremoval
set removalexitreason = 'REUNIF',updatedby = 'CJAMS-60836', updatedon = now()
where intakeservreqchildremovalid  = 'b965076d-b9aa-4320-b2c9-9d22843978f1' and activeflag =1;


update intakeservreqchildremoval_history 
set removalexitreason = 'REUNIF',updatedby = 'CJAMS-60836', updatedon = now()
where intakeservreqchildremovalhistoryid  in ('d4a1efcf-576f-4b3f-95e2-db51c72dff60',
'8e5b722e-9c08-4696-8606-3e7c1b699d3e',
'cc9e8b41-cc25-4aea-9d0a-01c46b24816b',
'ec5eca96-ae28-4a2f-8fb7-47f5fd699c40',
'645928c5-475c-46c0-9cab-5ec9081f5bf5',
'e850e093-3953-42dc-9e33-148513c8b226') and activeflag =1;