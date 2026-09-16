/*
   Issue Description: CDM-28330
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
    updatedby = 'CDM-28330',
    updatedon = now()
where
    intakeservreqchildremovalid = '5247a50b-c4b1-42bd-af9c-0b855253f936';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-28330',
   update_ts = now()
where
   removal_id = '254086';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-28330',
   updatedon = now()
where
   personprogramid = '65eea80a-16fe-4516-bc4b-59f86a66286b';