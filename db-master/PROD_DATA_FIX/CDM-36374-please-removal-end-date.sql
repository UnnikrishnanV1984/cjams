/*
    -- Issue Description: CDM-36374
    -- Category/ Module  : Child Removal
    -- Root cause: User entered wrong removal end date and needs to be deleted
    -- Fix: 
    -- 1. Removed the Child Removal End Date.
    -- 2. Changed the Placement Exit Type to "Change of placement structure".
*/

-- 1
select exitdate, returntransts, * from intakeservreqchildremoval where intakeservreqchildremovalid = '832e91fc-71d1-4985-924c-c73ce05e9912';
UPDATE cjams.intakeservreqchildremoval
SET exitdate=NULL, returntransts=NULL, updatedby='CDM-36374', updatedon=now() 
WHERE intakeservreqchildremovalid='832e91fc-71d1-4985-924c-c73ce05e9912';

select enddate ,* from personprogramarea where personprogramid = 'c6009f62-ec6f-45ce-8e06-a98db29bc989';
UPDATE cjams.personprogramarea
SET enddate=NULL, updatedby='CDM-36374', updatedon=now() 
WHERE personprogramid='c6009f62-ec6f-45ce-8e06-a98db29bc989'::uuid; 

select end_dt,removal_id, * from tb_client_eligibility where case_id = 3297896 and eligibility_id=168441;
UPDATE cjams.tb_client_eligibility
SET end_dt=NULL, update_user_id='CDM-36374', update_ts=now() 
WHERE eligibility_id=168441 and case_id = '3297896';
-- 1

-- 2
select * from placement where placementid ='9e6db50a-2b3e-4ccc-9fbf-02478a6c4d51' and alternateid=1585531;

update
    placement
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    updatedby = 'CDM-36374',
    updatedon = now()
where
    placementid ='9e6db50a-2b3e-4ccc-9fbf-02478a6c4d51' and alternateid=1585531 and activeflag=1;
--
select approvalstatustypkey,approvaldate,* from placementrevision where
    placementid = '9e6db50a-2b3e-4ccc-9fbf-02478a6c4d51' 
    and placementrevisionid in (
    '3630576c-b87f-4f39-a01c-11583e3af474',
    'c381b56a-b522-4ee2-bc0d-af17cdeb5886'
    );

update
    placementrevision
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    updatedby = 'CDM-36374',
    updatedon = now()
where
    placementid = '9e6db50a-2b3e-4ccc-9fbf-02478a6c4d51' 
    and placementrevisionid in (
    '3630576c-b87f-4f39-a01c-11583e3af474',
    'c381b56a-b522-4ee2-bc0d-af17cdeb5886'
    );
-- 2