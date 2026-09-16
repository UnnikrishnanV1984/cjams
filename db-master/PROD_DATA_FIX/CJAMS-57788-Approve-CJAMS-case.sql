/*
Issue Description: CJAMS-57788: Approve CJAMS case
Category/Module: Placement Approval
Root cause: CJAMS case sent to supervisor is missing the role in the db due to a glitch
Fix provided: Data fix has been done to update the placement table and assign the role accordingly to the placmentid
Regression Impacts: N/A
Data/Code fix ticket#: CJAMS-57788
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
UPDATE
    routing
SET
    toroleid = 'CWSP',
    updatedby = 'CJAMS-57788',
    updatedon = NOW()
WHERE
    objectid IN (
        '38275411-8cf2-4beb-bc69-9dbebc17f577',
        '997cf16e-da43-47b5-925d-a1b6754bcdaf'
    )
    AND activeflag = 1;