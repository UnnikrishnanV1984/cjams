/*
 * CDM-36933 - Removal Dates need corrected
 * Customer Email ID:brittany.brendel@maryland.gov
 * Focus Area:Child Removal
 * Identified As:User Error
 * Description - 1030257820:We put the removal date as 1/10/24 for these 5 children, but they were actually removed on 1/5/24. 
 * We cannot edit it as it's been approved already. Can this be changed to 1/5 or can it be unlocked so we can edit it.
 * 
 */

select removalid, removaldate, * from Intakeservreqchildremoval where intakeservreqchildremovalid in (
'37cec45a-a388-4283-aa37-3491787cd94f',
'325699c6-c1c9-4039-ae0f-8096d68e58cf',
'74426d14-ff89-4c43-baac-2c25eb702693',
'e7dc4f77-b32c-4de3-9671-4a80b862c588',
'1d14fc78-d7fe-4478-8c3c-d654301c30f9'
);
UPDATE cjams.intakeservreqchildremoval
SET removaldate='2024-01-05 00:00:00.000', updatedby='CDM-36933', updatedon=now() 
where intakeservreqchildremovalid in (
'37cec45a-a388-4283-aa37-3491787cd94f',
'325699c6-c1c9-4039-ae0f-8096d68e58cf',
'74426d14-ff89-4c43-baac-2c25eb702693',
'e7dc4f77-b32c-4de3-9671-4a80b862c588',
'1d14fc78-d7fe-4478-8c3c-d654301c30f9'
);
select start_dt, * from tb_client_eligibility where removal_id in (
300088,
300091,
300092,
300090,
300089
);
update tb_client_eligibility
set start_dt  = '2024-01-05',
    update_user_id = 'CDM-36933',
    update_ts = now()
where removal_id in (
300088,
300091,
300092,
300090,
300089
);

select startdate, * from cjams.personprogramarea where personprogramid in (
'7120c1f0-e3ff-4b60-b5c6-4be877367044',
'bc7cf25b-8f60-441b-9008-232ae0417c3a',
'be908d38-7943-48ea-b080-10dace8d6848',
'0ca595c5-8aec-46d7-b957-671587c17dd8',
'2162ff66-06e3-4ba8-a916-17ade1327d4a'
);

UPDATE personprogramarea 
SET startdate = '2024-01-05 00:00:00.000', updatedby = 'CDM-36933', updatedon = now() 
where personprogramid in (
'7120c1f0-e3ff-4b60-b5c6-4be877367044',
'bc7cf25b-8f60-441b-9008-232ae0417c3a',
'be908d38-7943-48ea-b080-10dace8d6848',
'0ca595c5-8aec-46d7-b957-671587c17dd8',
'2162ff66-06e3-4ba8-a916-17ade1327d4a'
);

