/*
   Issue Description: CDM-41981
   Category/ Module  : Removing Removal end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select updatedby, updatedon, exitdate,* from intakeservreqchildremoval where intakeservreqchildremovalid  = '8e5af86b-ee07-428b-801f-190439e18ce9' and activeflag =1;
*/

update intakeservreqchildremoval
set 
	exitdate  = NULL,
	removalexitreason = NULL,
    returntransts = NULL,
	updatedby = 'CDM-41981', 
	updatedon = now() 
where intakeservreqchildremovalid  = '8e5af86b-ee07-428b-801f-190439e18ce9' and activeflag =1;

/*
select * from personprogramarea p where personprogramid = '99db1bdd-28fe-4800-a13b-9bab2827769a' and activeflag = 1;
*/
update personprogramarea 
set enddate = null, 
    updatedby = 'CDM-41981', 
    updatedon = now() 
where personprogramid = '99db1bdd-28fe-4800-a13b-9bab2827769a' and activeflag =1;

/*
select * from tb_client_eligibility tce where client_id = '200772630'
*/
update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-41981',
   update_ts = now()
where
   removal_id = '252205';