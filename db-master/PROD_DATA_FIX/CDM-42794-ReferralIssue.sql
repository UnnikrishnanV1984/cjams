/*
Issue: Need data fix to update the Intake Jurisdiction from Anne Arundel to "Howard County" and need to verify if caseworker is able to edit the Intake after the fix
Category/Module: Support
Root cause: Data error did not properly update this cross-county referral
Fix provided: DB queries to change the county id so user can edit the referral
Data/Code fix ticket#: CDM-42794
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakedastaging
update intakedastaging
set jsondata = jsonb_set(jsondata, '{General, countyid}', '"bbce9638-24f9-4336-993c-007f6755c980"', false),
updatedby = 'CDM-42794', updatedon = now()
where intakenumber = 'I241013175099' and activeflag = 1;

--Updating intakedastatus
update intakedastatus
set jsondata = jsonb_set(jsondata, '{General, countyid}', '"bbce9638-24f9-4336-993c-007f6755c980"', false),
updatedby = 'CDM-42794', updatedon = now()
where intakedastatusid = '2974738c-6b93-4b14-8530-269d6d204c0f' and activeflag = 1;