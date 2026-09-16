/*
   Issue Description: CDM-27801
   Category/ Module  : Prod data fix to Remove Child Removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2022-03-22 09:01:00
update
    intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-27801',
    updatedon = now()
where
    intakeservreqchildremovalid = 'd7f06949-ee0a-494a-b78d-dd84b66e8f9d';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-27801',
   update_ts = now()
where
   removal_id = '184353';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-27801',
   updatedon = now()
where
   personprogramid = '162e86a3-c68a-43cc-830d-cd50583504bf';