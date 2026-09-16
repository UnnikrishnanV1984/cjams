/*
Issue Description: Datafix to change the incident date from 01/17/2025 to 01/15/2025 in the intake# I251013210512 
Category/Module: Error
Root cause: Datafix to change the incident date from 01/17/2025 to 01/15/2025 in the intake# I251013210512 
Fix provided: DB queries to change the incident date
Data/Code fix ticket#:CDM-44023
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-44105', updatedon = now(), jsondata = jsonb_set(jsondata, '{narrative}',
jsonb_set(jsondata->'narrative', '{0}',
jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2025-01-15 05:00:00.000"')))
WHERE intakenumber = 'I251013210512' AND activeflag=1;

UPDATE intakedastaging
SET updatedby = 'CDM-44105', updatedon = now(), jsondata = jsonb_set(jsondata, '{narrative}',
jsonb_set(jsondata->'narrative', '{0}',
jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2025-01-15 05:00:00.000"')))
WHERE intakenumber = 'I251013210512' AND activeflag=1;

update intakeservicerequest
set reporterincidentdate = '2025-01-15 05:00:00.000', reportedtime = '2025-01-15 05:00:00.000', updatedby = 'CDM-34786', updatedon = now()
where intakeserviceid = '95407e52-bfea-42cc-8e5b-e284889ccfc8' and activeflag = 1;