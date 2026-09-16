/*
Issue Description: CJAMS-58503: User needs to insert a provider placement in the middle of the living arrangement dated 12/12/2024 - 12/27/2024 with provider id 6192151. 
                   The first living arrangement to be end dated to 12/12/2024. 
Category/Module: Placement 
Root cause: User needs to insert a provider placement in the middle of the living arrangement dated 12/12/2024 - 12/27/2024 with provider id 6192151. 
                   The first living arrangement to be end dated to 12/12/2024. 
Fix provided: Data fix to delete the removal end date so that user can continue adding the provider placement and living arrangement manually.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    updatedby = 'CJAMS-58503',
    updatedon = now()
where intakeservreqchildremovalid='3e8651ea-9b27-45af-8624-be992b471793'
and activeflag =1;


update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-58503', 
updatedon = now()  
where personprogramid ='f4da284a-cc29-4f2d-9cab-3d471ab91ce7' 
and activeflag = 1;

update placement
set enddatetime = '2024-12-12 00:00:00.000',
    updatedby = 'CJAMS-58503',
    updatedon = now()
where placementid='80bac7c7-360c-40c6-94bd-9d0d7803b2ee'
and activeflag = 1;

update placementrevision
set exitdate = '2024-12-12 00:00:00.000',
    updatedby = 'CJAMS-58503',
    updatedon = now()
where placementid='80bac7c7-360c-40c6-94bd-9d0d7803b2ee'
and placementrevisionid = 'db7ad5be-d2c0-48aa-b97b-01100bc93da3'
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-58503',
    update_ts = now()
where removal_id = 289492
and delete_sw = 'N';