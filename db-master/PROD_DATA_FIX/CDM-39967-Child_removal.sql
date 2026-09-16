/*
   Issue Description: CDM-39967
   Category/ Module  : Child removal
   Root cause: The rejected child removal created in-error and need to be removed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval
set activeflag =0, updatedby ='CDM-39967', updatedon =NOW()
where intakeservreqchildremovalid ='57099cd5-8459-4a1d-8485-81fe5d74e144' and activeflag =1;

update intakeservreqchildremoval_history 
set activeflag =0,updatedby ='CDM-39967',updatedon=NOW()
where servicecaseid ='9a6850f4-e62d-47c1-8e1e-e41d6c8952e2' and activeflag =1;

UPDATE tb_client_eligibility 
SET delete_sw = 'Y', update_user_id = 'CDM-39967', update_ts = now()
WHERE removal_id ='316838' and delete_sw = 'N';

update placement
set intakeservreqchildremovalid = null ,updatedby ='CDM-39967',updatedon=NOW()
where placementid ='96048227-b639-49e9-86bc-8ea6f331292e' and activeflag = 1;

update routing 
set activeflag = 0,updatedby ='CDM-39967',updatedon =now()
where objectid ='57099cd5-8459-4a1d-8485-81fe5d74e144' and activeflag =1;

update personprogramarea
set activeflag =0,updatedby ='CDM-39967',updatedon =now()
where personprogramid='884b905b-f1e4-4cf2-848a-da265f9c623d' and activeflag=1;