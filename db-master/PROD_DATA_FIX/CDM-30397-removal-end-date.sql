/*
   Issue Description: CDM-30397
   Category/ Module  : Prod data fix to Remove Child Removal end date
   Root cause: 
   Pull request# for code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update
    intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-30397',
    updatedon = now()
where
    intakeservreqchildremovalid = '055175e2-31fa-4088-aa20-c73da9d8d7fa';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-30397',
   update_ts = now()
where
   removal_id = '257481';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-30397',
   updatedon = now()
where
   personprogramid = '5e14a032-2603-4778-a7ce-9766ea79e39b';