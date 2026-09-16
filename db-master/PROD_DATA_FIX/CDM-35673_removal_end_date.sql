/*
   Issue Description: CDM-35673
   Category/ Module  : Prod data fix to update removal information
   Root cause: end date is given as Nov17,2023 which needs to be empty
   Resolution: The request was to remove the end date for empty. so updated and provided data fix to make it empty
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/


update intakeservreqchildremoval set exitdate = null, returntransts = null, updatedby = 'CDM-35673', updatedon = now() 
where intakeservreqchildremovalid = '585a4dc0-19a9-4fb8-be05-b2f467c0f7bf';


update tb_client_eligibility set end_dt  = null, update_user_id = 'CDM-35673', update_ts = now() 
where removal_id = '198986';

update personprogramarea set enddate = null, 
updatedby = 'CDM-35673', updatedon = now() 
where personprogramid = '5ae5544d-004e-4bef-9eb3-4c440cfb987a';