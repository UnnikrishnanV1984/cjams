/*
   Issue Description: CDM-30588
   Category/ Module  : Prod data fix to Remove Child Removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update
    intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-30588',
    updatedon = now()
where
    intakeservreqchildremovalid = '920285dd-278e-44b0-b5d9-27651ea3d0f5';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-30588',
   update_ts = now()
where
   removal_id = '197625';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-30588',
   updatedon = now()
where
   personprogramid = 'e2d54d98-9feb-40a1-945f-0d186fe0b970';