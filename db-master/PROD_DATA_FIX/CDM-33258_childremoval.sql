/*
   Issue Description: CDM-33258
   Category/ Module  : Child Removal
   Root cause: user requested to remove the end date for creating adoption subsidy
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-33258',
    updatedon = now()
where intakeservreqchildremovalid = '18d970d3-ca73-423c-ab8e-c90b60bd1ad5';


update tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-33258',
   update_ts = now()
where removal_id = '199907';

update personprogramarea
set
   enddate = null,
   updatedby = 'CDM-33258',
   updatedon = now()
where personprogramid = '215ace11-bf8f-453c-8e80-ef9a6269f243';