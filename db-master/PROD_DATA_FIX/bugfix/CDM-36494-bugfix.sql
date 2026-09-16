/* 
    Issue Description: CDM-36494
   Category/ Module  : unable to add provider placement
   Root cause: User is unable to add a placement or living arrangement for the child. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

UPDATE
    cjams.placement
SET
    activeflag = 0,
    updatedby = 'CDM-36494',
    updatedon = now()
WHERE
    placementid = 'd64abc15-96fe-499b-98d3-cbc223fda197'
    and activeflag = 1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-36494',
    updatedon = now()
WHERE
    placementid = 'd64abc15-96fe-499b-98d3-cbc223fda197'
    and activeflag = 1;

UPDATE
    cjams.livingarrangement
SET
    activeflag = 0,
    updatedby = 'CDM-36494',
    updatedon = now()
WHERE
    placementid = 'd64abc15-96fe-499b-98d3-cbc223fda197'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-36494',
    updatedon = now()
where
    objectid = 'd64abc15-96fe-499b-98d3-cbc223fda197'
    and activeflag = 1;