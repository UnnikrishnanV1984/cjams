
/*
 Issue Description: CDM-43276
-- Category/ Module: Child removal and Living arrangement
-- Root cause: User requested to remove the child removal and placement
-- Fix Provided: Datafix has been promoted to update the approval flag.
-- Pull request# N/A
-- Reason why no related code fix: User error : User requested to remove the service plan.
*/


update personhospitalization 
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
where personid = '34f35f54-7b0a-4bf7-ba9d-6afa5523acd9' and activeflag = 1;


update placement 
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
where placementid = 'fe56816b-7b3e-47c6-bd3b-7d2b531e4c14' and  personid = '34f35f54-7b0a-4bf7-ba9d-6afa5523acd9' and activeflag =1;


update personprogramarea 
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
where  personid = '34f35f54-7b0a-4bf7-ba9d-6afa5523acd9' and personprogramid = '76aaef3c-20fb-482e-84c8-1bc49e1126b5' and activeflag = 1;


update intakeservreqchildremoval
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
WHERE intakeservreqchildremovalid = '13098161-60bd-4313-a124-f57cfe8d478b' and activeflag =1;


update livingarrangement 
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
where placementid = 'fe56816b-7b3e-47c6-bd3b-7d2b531e4c14' and activeflag =1;

update placementrevision 
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
where placementid = 'fe56816b-7b3e-47c6-bd3b-7d2b531e4c14' and activeflag =1;

update tb_client_eligibility
set delete_sw = 'Y', update_user_id = 'CDM-33265', update_ts = now()
where removal_id = '332408';

update intakeservreqchildremoval_history
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
WHERE intakeservreqchildremovalid = '13098161-60bd-4313-a124-f57cfe8d478b' and activeflag =1;

update routing
set activeflag = 0,updatedby='CDM-43276',updatedon= now() 
WHERE objectid = '13098161-60bd-4313-a124-f57cfe8d478b' and activeflag =1;