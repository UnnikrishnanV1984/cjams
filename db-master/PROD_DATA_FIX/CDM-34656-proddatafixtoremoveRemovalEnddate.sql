/*
   Issue Description: CDM-34119
   Category/ Module  : Prod data fix to remove the pending assignment
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
    updatedby = 'CDM-34656',
    updatedon = now()
where
    intakeservreqchildremovalid = 'b25b3e59-72e8-46ac-9eb3-0eabaf3aa76b';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-34656',
   update_ts = now()
where
   removal_id = '253581';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-34656',
   updatedon = now()
where
   personprogramid = '22ca3e03-6fa7-4876-8ce1-ae5101e71e2e' and personid = '3d57f18b-fb89-42dd-abc6-d70b890a6969';