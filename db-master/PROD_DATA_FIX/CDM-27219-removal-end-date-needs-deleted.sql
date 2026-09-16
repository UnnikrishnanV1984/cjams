/*
   Issue Description: CDM-27219
   Category/ Module  : Child Removal  
   Root cause: User requested to update the child removal end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
	intakeservreqchildremoval
set
	exitdate = Null,
	updatedby = 'CDM-27219',
	updatedon = now()
where
	intakeservreqchildremovalid = '78ee2299-a3e2-46f3-b5e6-afbe1c224e1a';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-27219',
   update_ts = now()
where
   removal_id = '253856';


update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-27219',
   updatedon = now()
where
   personprogramid = '0fd527f8-0ee7-4005-8b13-c8181b10c3c5';