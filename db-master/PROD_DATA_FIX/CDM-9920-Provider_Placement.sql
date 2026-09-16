--Placement 
UPDATE
    placement
SET
    startdatetime = '2020-09-02 00:00:00'
WHERE
    placementid = '6997a1ac-9801-4f50-bd2b-c7205728b96c'
    AND intakeservicerequestactorid = '680522fa-2f8c-4ea3-9742-89f6ba098795';

-- Placementrevision
UPDATE
    placementrevision
SET
    entrydate = '2020-09-02 00:00:00'
WHERE
    placementid = '6997a1ac-9801-4f50-bd2b-c7205728b96c';

--tb_placement_validation
UPDATE
    tb_placement_validation
SET
    placement_entry_dt = '2020-09-02',
    update_ts = current_timestamp
WHERE
    placement_id = '1557679';