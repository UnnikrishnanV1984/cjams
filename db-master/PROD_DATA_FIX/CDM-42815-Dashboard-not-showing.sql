/*
   Issue Description: CDM-42815
   Category/ Module  : Dashboard
   Root cause: Caseload is not showing for the user because of incorrect roletype and roleid.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Yes
*/

UPDATE
    teammember
SET
    roletypekey = 'CWCW',
    updatedby = 'CDM-42815',
    updatedon = CURRENT_TIMESTAMP
WHERE
    teammemberid = '8a32574b-96b6-4899-be37-dd3d4639da00'
    AND activeflag = 1;

UPDATE
    rolemapping
SET
    activeflag = 0,
    updatedby = 'CDM-42815',
    updatedon = CURRENT_TIMESTAMP
WHERE
    principalid = '42631'
    and roleid = 135
    AND activeflag = 1;

INSERT INTO
    cjams.rolemapping (
        id,
        principaltype,
        principalid,
        roleid,
        activeflag,
        insertedby,
        updatedby,
        insertedon,
        updatedon,
        old_id,
        teamtypekey
    )
VALUES
(
        212321212,
        'USER',
        '42631',
        71,
        1,
        'ADMIN',
        'CDM-42815',
        Now(),
        NOW(),
        '',
        'CW'
    );