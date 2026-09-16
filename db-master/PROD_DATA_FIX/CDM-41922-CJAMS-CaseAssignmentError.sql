/*
Issue Description: Need technical investigation on the case number mentioned below for these clients
Category/Module: Bug
Root cause: Kinship Navigation Intake was opening program assignment with wrong details
Fix provided: DB query to set the correct details
Data/Code fix ticket#: CDM-41922
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-9532
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updataing personprogramarea
update personprogramarea
set objectid = 'b63042b0-83b9-41bd-9cf8-39555a394e8d', entityid = '241030393166', updatedby = 'CDM-41922', updatedon = now()
where activeflag = 1 and personprogramid in (
'578c8cad-9331-48be-8d1b-3377792a5895',
'eabeda39-3f41-4d9d-b28b-8076b1b6fde0',
'a03a970b-7d58-4e4f-969e-1127777337af',
'3d807b67-31bc-4cdf-a933-36d90da91a5a',
'bbd25d66-da4f-4a36-8afe-a34b91dc6540');