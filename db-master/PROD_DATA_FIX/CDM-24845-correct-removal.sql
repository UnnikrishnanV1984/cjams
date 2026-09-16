/*
   Issue Description: CDM-24845
   Category/ Module  : Correct removal
   Root cause: Duplicate child removal
   Pull request# for code fix: 
   Explanantion: User wants to remove the child removal duplicates from the system
*/

update
    intakeservreqchildremoval
set
    updatedby = 'CDM-24845',
    updatedon = now(),
    activeflag = 0
where
    intakeservreqchildremovalid = '2007600c-3b7e-48ab-8c3a-870f010752b4';

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-24845',
    updatedon = now()
where
    objectid = '8aaf1a66-3be1-44c8-b0f7-c8604fa3ea1e';


update
    tb_client_eligibility
set
    delete_sw = 'Y',
    update_ts = now(),
    update_user_id = 'CDM-24845' 
where
    removal_id = '254126';