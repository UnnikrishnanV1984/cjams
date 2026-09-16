/*
   Issue Description: CDM-30586
   Category/ Module  : Child Removal
   Root cause: user requested to remove the end date for creating gap and perm plan
   Pull request# for code fix: 8735
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-30586',
    updatedon = now()
where intakeservreqchildremovalid = '187b2657-b916-40d1-b5f4-554b9dbcd958';


update tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-30586',
   update_ts = now()
where removal_id = '250688';

update personprogramarea
set
   enddate = null,
   updatedby = 'CDM-30586',
   updatedon = now()
where personprogramid = '3dfd3bcd-750a-49ff-83d3-916e09da3303';