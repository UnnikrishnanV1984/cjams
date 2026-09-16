/*
Issue Description: CJAMS-62029 Date of Death Deletion Needed for the client Keylor Soriano
Category/Module: Person card / Person Profile
Root cause: User accidentally entered the person Date Of Death and requested to removed it.
            Client ID: 204131886 (Keylor Soriano)
Fix provided: Data fix has been done to remove the date Date of Death
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix should correct it.
*/



update person 
set dateofdeath = null, 
    updatedby = 'CJAMS-62029', 
    updatedon = now() 
    where personid = '271518bc-f020-469f-8cfc-1497ba45871e'
    and activeflag=1;

UPDATE personauditlog
SET personjson = jsonb_set(personjson::jsonb, '{dateofdeath}', 'null'::jsonb),
    updatedon = now(),
    updatedby = 'CJAMS-62029'
WHERE personid = '271518bc-f020-469f-8cfc-1497ba45871e'
and activeflag = 1;
