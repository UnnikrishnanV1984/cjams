/*
   Issue Description: CDM-27470
   Category/ Module  : Child Removal - Client: Adrianna- CJAMS PID# 4139016
   Root cause: user wants to  remove end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

--select * from person where cjamspid = '4139016';

select 	intakeservreqchildremovalid, removalid, exitdate, removalexitreason, personid,  * from intakeservreqchildremoval
where 	intakeservreqchildremovalid = 'ac7b00b4-081f-421f-9334-7c6883ce292e' and activeflag = 1 ;

update 	cjams.intakeservreqchildremoval
set 	exitdate = NULL,
		removalexitreason = NULL,
		updatedby = 'CDM-27470',
		updatedon = now()
where 	intakeservreqchildremovalid ='ac7b00b4-081f-421f-9334-7c6883ce292e' and activeflag = 1 ;

select 	personprogramid, enddate, activeflag, * 
from 	personprogramarea where personid = 'a5624610-59ed-4784-9d30-ef768ffff569' and programkey = 'OOH';

update 	cjams.personprogramarea 
set 	enddate = NULL, 
		updatedby = 'CDM-27470',
		updatedon = now()
where 	personprogramid = '7ea00c69-8b89-49b1-aae8-af91263d59b3' and activeflag = 1 ;

select 	end_dt, * from tb_client_eligibility
where 	removal_id =  253854 and delete_sw = 'N' ;

update 	cjams.tb_client_eligibility
set 	end_dt = NULL,
		update_user_id = 'CDM-27470',
		update_ts = now()
where removal_id =  253854 and delete_sw = 'N' ;