/*
Issue Description:
Category/Module: Bug
Root cause: Issue is not replicable so proceeding with datafix to modify the start date
Fix provided:DB query to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-65598
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservicerequest
set reporteddate = '2026-02-17 14:38:00',
    updatedby = 'CJAMS-65598',
    updatedon = now()
where intakeserviceid = '48e2e6a1-ec39-4939-a3d3-9346c8ac4869' and activeflag =1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(
    jsondata,
    '{General,narrativeUpdatedDate}',
     '"2026-02-12T14:47:52.721Z"',
    true
),
updatedon = now(),
updatedby = 'CJAMS-65598'
WHERE intakenumber = 'I261013899232' and activeflag=1;


UPDATE intakesnapshot 
SET jsondata = jsonb_set(
    jsondata,
    '{General,addendumNarrativeUpdatedAt}',
     '"2026-02-17T19:38:52.721Z"',
    true
),
updatedon = now(),
updatedby = 'CJAMS-65598'
WHERE intakenumber = 'I261013899232' and activeflag=1;


