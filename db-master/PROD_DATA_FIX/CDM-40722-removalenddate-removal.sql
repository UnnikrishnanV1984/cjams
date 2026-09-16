/*
   Issue Description: CDM-40722
   Category/ Module  : Prod data fix to remove the removal endaate 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update
    intakeservreqchildremoval
set
    exitdate = NULL,
    removalexitreason = NULL,
    returntransts = NULL,
    updatedby = 'CDM-40722',
    updatedon = now()
where
    intakeservreqchildremovalid = '90550e82-cd10-4592-b47e-0d6f5c07a782';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-40722',
   update_ts = now()
where
   removal_id = '254045';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-40722',
   updatedon = now()
where
   personprogramid = '16ca70bf-b11c-4ad0-b8c5-d3f47a451d17' and personid = 'a26d76bd-c39f-433d-a060-5e5576e60cf2';