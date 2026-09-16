--tb_placement_validation
update
    tb_placement_validation
set
    placement_exit_dt = '2021-01-19',
    update_ts = current_timestamp
where
    placement_validation_id = '1949556'
    and placement_id = '1560589';

--placementrevision
update
    placementrevision
set
    exitdate = '2021-01-19 00:00:00'
where
    placementid = '712381b1-d17a-4353-8684-3884a0d52902'
    and placementrevisionid in (
        '5ad16745-bf36-4e88-9f33-b655336fe846',
        'a6ec340a-9a95-42c1-becc-9ffb2b549694'
    );

--placement
update
    placement
set
    enddatetime = '2021-01-19 00:00:00'
where
    placementid = '712381b1-d17a-4353-8684-3884a0d52902';