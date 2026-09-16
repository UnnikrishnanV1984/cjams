/*
   Issue Description: CJAMS-59026
   Category/ Module  : Placement
   Root cause: Requested to do the data fix to remove the Living arrangement record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE
    cjams.placement
SET
    activeflag = 0,
    updatedby = 'CJAMS-59026',
    updatedon = now()
WHERE
    placementid = '12201ab4-837f-43db-a7e0-b12a9fecf95d'
    and activeflag = 1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CJAMS-59026',
    updatedon = now()
WHERE
    placementid = '12201ab4-837f-43db-a7e0-b12a9fecf95d'
    and activeflag = 1;

UPDATE
    cjams.livingarrangement
SET
    activeflag = 0,
    updatedby = 'CJAMS-59026',
    updatedon = now()
WHERE
    placementid = '12201ab4-837f-43db-a7e0-b12a9fecf95d'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CJAMS-59026',
    updatedon = now()
where
    objectid = '12201ab4-837f-43db-a7e0-b12a9fecf95d'
    and activeflag = 1;