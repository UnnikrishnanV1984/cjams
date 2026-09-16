/* 
    Issue Description: CDM-37288

    Category/ Module  : Unable to add new placements.
    Root cause: User is unable to add new placement or living arrangement for the child.
    Fix provided: Datafix provided to void the rejected placement.
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 


    -- serviceid: "84332130-403b-46a2-bb8c-8ce20adafe13"
    -- placementid: "5ee91041-7fae-493f-b102-7f261783255f"
    -- placementrevisionid: "392d36fd-d05c-4f08-86ea-e8f8bc24ec54"
*/

select activeflag,updatedby,updatedon from placement where placementid = '5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;
-- UPDATE cjams.placement
-- SET activeflag=1, updatedby='0e7979dd-60ea-49d1-8588-0eac57a3a9d1', updatedon='2022-11-18 13:15:14.000' 
-- where placementid = '5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;

UPDATE
    cjams.placement
SET
    activeflag = 0,
    updatedby = 'CDM-37288',
    updatedon = now()
WHERE
    placementid = '5ee91041-7fae-493f-b102-7f261783255f'
    and activeflag = 1;

select activeflag,updatedby,updatedon from placementrevision WHERE placementid = '5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;
-- UPDATE cjams.placementrevision
-- SET activeflag=1, updatedby='e8379a8c-fc16-4073-8cb7-90c54d395eb4', updatedon='2023-03-02 15:02:59.020' 
-- WHERE placementid = '5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-37288',
    updatedon = now()
WHERE
    placementid = '5ee91041-7fae-493f-b102-7f261783255f'
    and activeflag = 1;

select activeflag,updatedby,updatedon from livingarrangement WHERE placementid = '5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;
-- UPDATE cjams.livingarrangement
-- SET activeflag=1, updatedby='0e7979dd-60ea-49d1-8588-0eac57a3a9d1', updatedon='2022-11-18 13:15:14.194' 
-- WHERE placementid = '5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;

UPDATE
    cjams.livingarrangement
SET
    activeflag = 0,
    updatedby = 'CDM-37288',
    updatedon = now()
WHERE
    placementid = '5ee91041-7fae-493f-b102-7f261783255f'
    and activeflag = 1;

select activeflag,updatedby,updatedon from routing where objectid='5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;
-- UPDATE cjams.routing
-- SET activeflag=1, updatedby='e8379a8c-fc16-4073-8cb7-90c54d395eb4', updatedon='2023-03-02 15:02:59.020' 
-- where objectid='5ee91041-7fae-493f-b102-7f261783255f' and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-37288',
    updatedon = now()
where
    objectid = '5ee91041-7fae-493f-b102-7f261783255f'
    and activeflag = 1;