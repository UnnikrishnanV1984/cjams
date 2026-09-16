/*
   Issue Description: CDM-34154
   Category/ Module  : Child Removal
   Root cause: user requested to remove child removal enddate.
   Pull request# for code fix: 8735
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update intakeservreqchildremoval
set
    exitdate = Null,
    returntransts =null,
    updatedby = 'CDM-34154',
    updatedon = now()
where intakeservreqchildremovalid = '5d52c1bd-be10-4265-9200-3bd9f832c9a1';


update tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-34154',
   update_ts = now()
where removal_id = '278569';

update personprogramarea
set
   enddate = null,
   updatedby = 'CDM-34154',
   updatedon = now()
where personprogramid = '89925a2b-3151-4373-bd19-9abc9af6a249';