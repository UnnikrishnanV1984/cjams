/*
   Issue Description: CDM-23289
   Category/ Module  : Prod data fix to remove the duplicate removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update placement set intakeservreqchildremovalid = '4ba6f9ea-6de0-4de3-b07f-762b82bb9c2b', updatedby = 'CDM-23289', updatedon = now() 
where intakeservreqchildremovalid = '879a97ef-3dd1-4320-bc2d-2945659ad8d7';

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-23289', updatedon = now()
where removalid  = '252943' and activeflag = 1;

update tb_client_eligibility set delete_sw = 'Y', update_user_id = 'CDM-23289', update_ts = now() 
where removal_id = '252943';