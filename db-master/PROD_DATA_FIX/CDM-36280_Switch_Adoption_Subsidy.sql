/*
 Issue Description: CDM-36280
 Category/ Module  :  Switch Adoption Subsidy
 Root cause: Need data fix to add the client (CJAMS PID# 3844254) in the adoption case 3285599
 Fix: Inserted a new adoptioncaseid into the adoptioncase with respective person
 Pull request# for code fix: 
 Reason why no related code fix: 
 */
INSERT INTO
    cjams.adoptioncaseactor (
        adoptioncaseactorid,
        adoptioncaseid,
        personid,
        actortypekey,
        old_id,
        activeflag,
        insertedon,
        insertedby,
        updatedon,
        updatedby,
        etl_userid,
        etl_load_date
    )
VALUES
    (
        'c4bb0d5b-7923-430b-838c-cc30d0a198c0',
        '112ac55b-e7a6-4f11-a0e5-9dba11e10cf7',
        '438591b3-56e2-4a6a-9f53-fc2f8dd65f73',
        'ADOPTIVEPARENT',
        '3285599',
        1,
        now(),
        'CDM-36280',
        now(),
        'CDM-36280',
        Null,
        Null
    );

update
    cjams.adoptioncaseactor
set
    personid = '9c02ad6e-44b3-4aab-9f2f-d27f724dd9ed',
    updatedby = 'CDM-36280',
    updatedon = now()
where
    adoptioncaseactorid = 'aa7baf75-553e-4f16-a3fb-50f7395bc8b3'
    and activeflag = 1;