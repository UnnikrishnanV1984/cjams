/*
Issue Description: Need Technical Investigation.  User not able to add Initial Contact Caregiver role for Client
Category/Module: Defect
Root cause: User seems to have removed all roles, saved, and then added new roles, resulting in new actor record
Fix provided: DB query to deactivate old role-less actor record from database
Data/Code fix ticket#: CDM-43171
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating old actor
update actor
set activeflag = 0, updatedby = 'CDM-43171', updatedon = now()
where actorid = '8e2a569f-0c6f-4142-82b2-6564c6d8e0f4' and activeflag = 1;