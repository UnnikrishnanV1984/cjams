/*
 Issue Description: CDM-35901
 Category/ Module  : Child Removal
 Root cause: User entered wrong removal end date and needs to be deleted
 Fix: 1. Removed the Child Removal End Date for both children.
 2. Removed the OOH PA End Date for both children.
 3. Changed the Placement Exit Type to "Change of placement structure" for both children.
 Pull request# for code fix:
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
-- removing childremoval end date
select
    removalid,
    *
from
    intakeservreqchildremoval
where
    personid in (
        '116e1c47-aa7f-44e9-ad62-281499e00b88',
        '146ecd31-1c73-4b3a-96ed-07b7e7531f3c'
    );

UPDATE
    intakeservreqchildremoval
SET
    returntransts = null,
    exitdate = NULL,
    updatedby = 'CDM-35901',
    updatedon = now()
WHERE
    intakeservreqchildremovalid IN (
        '1245843e-1145-4697-bb05-3a650f210374',
        '280015a2-e63d-49b9-9971-8c0a1d22c76c'
    )
    AND activeflag = 1;

select
    *
from
    tb_client_eligibility
where
    removal_id in ('254104', '254105');

UPDATE
    tb_client_eligibility
SET
    end_dt = null,
    update_user_id = 'CDM-35901',
    update_ts = now()
WHERE
    removal_id in ('254104', '254105');

-- removing OOH PA end date
update
    personprogramarea
set
    enddate = NULL,
    updatedon = now(),
    updatedby = 'CDM-35901'
where
    entityid = '221030016331'
    and programkey = 'OOH';

-- for placement
select
    *
from
    placement
where
    alternateid in ('1642305', '1642338');

update
    placement
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    updatedby = 'CDM-35901',
    updatedon = now()
where
    alternateid in ('1642305', '1642338') and activeflag=1;

-- got placementrevisionid from getplacementbyservicecase()
--select queries
select
    *
from
    placementrevision
where
    placementid = '26508ce5-63d5-42d1-bc9d-c8fb75178974'
    and placementrevisionid in (
        '5a612d57-f664-43e8-ad94-44dad25560c8',
        '30b8c323-c8d7-4b57-8ad6-2ed67c60565c'
    );

select
    *
from
    placementrevision
where
    placementid = '709c2cf6-c490-4d15-9345-6f6f7ede5e3b'
    and placementrevisionid in (
        'afa41d6d-9677-48f6-9a62-724586b6dcd7',
        '151d77aa-e007-4eea-8e54-b62908a8b01d'
    );

-- update queries
update
    placementrevision
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    updatedby = 'CDM-35901',
    updatedon = now()
where
    placementid = '26508ce5-63d5-42d1-bc9d-c8fb75178974'
    and placementrevisionid in (
        '5a612d57-f664-43e8-ad94-44dad25560c8',
        '30b8c323-c8d7-4b57-8ad6-2ed67c60565c'
    );

update
    placementrevision
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    updatedby = 'CDM-35901',
    updatedon = now()
where
    placementid = '709c2cf6-c490-4d15-9345-6f6f7ede5e3b'
    and placementrevisionid in (
        'afa41d6d-9677-48f6-9a62-724586b6dcd7',
        '151d77aa-e007-4eea-8e54-b62908a8b01d'
    );

-- "servicecaseid":"7af97b2d-d943-4a02-92d3-47d3923292cd
-- intakeservreqchildremovalid - 1245843e-1145-4697-bb05-3a650f210374(same); personid - 116e1c47-aa7f-44e9-ad62-281499e00b88;
-- removalid - 254104, intakeservicerequestactorid - da8aed97-cb18-4393-937a-287de10729de and 
-- intakeservreqchildremovalid - 280015a2-e63d-49b9-9971-8c0a1d22c76c and personid - 146ecd31-1c73-4b3a-96ed-07b7e7531f3c;
-- removalid - 254105, intakeservicerequestactorid - 1ea5905d-012b-41fd-8752-aaeec81b798e