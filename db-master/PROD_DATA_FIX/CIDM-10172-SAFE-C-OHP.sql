/*
Issue Description: SAFE-C OHP details aren't showing up in Stage3 UI after data refresh.  Case# 3184942
Category/Module: Error
Root cause: Previous datafix of CIDM-10126 put colon after SS instead of . in date format
Fix provided: DB query to rectify the date format in stg3 db
Data/Code fix ticket#: CIDM-10126
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updating assessment

UPDATE assessment
SET updatedon = now(), updatedby = 'CIDM-10126',
submissiondata = jsonb_set(submissiondata, '{dateassessmentinitiated}','"2025-01-31T15:36:00.000Z"',false )
WHERE assessmentid = '1d90c808-80fe-4b26-8515-0a85d8564c78' and activeflag = 1;

UPDATE assessment
SET updatedon = now(), updatedby = 'CIDM-10126',
submissiondata = jsonb_set(submissiondata, '{dateassessmentinitiated}','"2025-01-31T15:32:00.000Z"',false )
WHERE assessmentid = '4244ff1b-c14d-47da-9b5c-57320a10a2a1' and activeflag = 1;