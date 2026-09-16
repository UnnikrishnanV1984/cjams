/*
   Issue Description: CDM-34204
   Category/ Module  : Child Removal
   Root cause: user requested to change the end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update intakeservreqchildremoval
set
    exitdate = '2023-08-28 11:00:00.000',
    updatedby = 'CDM-34204',
    updatedon = now()
where intakeservreqchildremovalid = '742b0e7f-1623-42a8-97ad-c490f29e647e';

update tb_client_eligibility
set
   end_dt = '2023-08-28',
   update_user_id = 'CDM-34204',
   update_ts = now()
where removal_id = '251170';

update personprogramarea
set
   enddate = '2023-08-28 00:00:00.000',
   updatedby = 'CDM-34204',
   updatedon = now()
where personprogramid = '073ca29e-ebf7-4ef6-9eb1-6b21b0bfc514';