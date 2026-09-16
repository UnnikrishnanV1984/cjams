-- CDM-31866 - Data fix
/*
-- Issue Description:
-- Category/ Module: Intake/Investigation (Expungement)
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2184997
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update intakeservreqchildremoval set exitdate = null , 
updatedby = 'CDM-31866', updatedon  = now() 
where intakeservreqchildremovalid in ('57c02d31-10cd-4922-8209-888d72d521d6',
'9fc00544-6f3b-4146-81fe-c41eb2b10054',
'aa484ae3-ae47-4676-a33d-e04b01caa81a');

-- 2023-06-07 00:00:00
update personprogramarea SET enddate = null,  updatedby = 'CDM-31866', updatedon = now()
where personprogramid in ('5dcccadf-3eed-4120-9f93-53406f8764e8',
'65cb89b3-e01d-4d0f-b802-4abbecbf5cde',
'b82c4b9b-5246-49e3-af35-971e683bb58d');

-- 2023-06-07 00:00:00
update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-31866',
    update_ts = now()
where removal_id in ('198539','198368','198538');



-- 2023-06-07 00:00:00
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-31866' 
where placementid in ('afdb5260-f4dd-47ef-9b2a-629fdb5dcc12',
'cb104b5b-b525-4aac-9c88-8b1ef01e02c2',
'84640ad4-a57a-46e5-b60f-84fe59aa9f5d') and activeflag = 1;

--2023-06-07 00:00:00
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-31866' 
where placementid in ('afdb5260-f4dd-47ef-9b2a-629fdb5dcc12',
'cb104b5b-b525-4aac-9c88-8b1ef01e02c2',
'84640ad4-a57a-46e5-b60f-84fe59aa9f5d') and activeflag = 1;

update tb_placement_validation set placement_exit_dt = null, update_user_id = 'CDM-31866', update_ts = now() 
where placement_id  in ('1571387','339450','339451');
