-- CDM-36906 - Child Removal
/*
-- Issue Description: 
   User request to delete child removal which was under wrong PID.

-- Case ID: 3274590

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error,User request to delete child removal which was under wrong PID.
-- Fix Provided: Datafix has been promoted to delete the requested  child removal.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the requested child removal (CDM-36906)
select *
	from cjams.intakeservreqchildremoval
where removalid = 290955
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-36906',
	updatedon = now()
where removalid = 290955
	and activeflag = 1;

select * from intakeservreqchildremoval_history
where intakeservreqchildremovalid = 'c4a2bb47-ec0c-42cf-bd7d-326ad52fbdbf'
and activeflag = 1;

update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CDM-36906',
	updatedon = now()
where intakeservreqchildremovalid = 'c4a2bb47-ec0c-42cf-bd7d-326ad52fbdbf'
and activeflag = 1;

select * from routing
where objectid = 'c4a2bb47-ec0c-42cf-bd7d-326ad52fbdbf'
and eventcode = 'CHRR'
and activeflag = 1;

update routing
set activeflag = 0,
	updatedby = 'CDM-36906',
	updatedon = now()
where objectid = 'c4a2bb47-ec0c-42cf-bd7d-326ad52fbdbf'
and eventcode = 'CHRR'
and activeflag = 1;

select programkey, startdate, enddate, *
from personprogramarea
where personid = 'bdfb2c9c-42d0-4267-a51f-0dc7699102ee'
and activeflag = 1
and programkey = 'OOH';

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-36906',
	updatedon = now()
where personid = 'bdfb2c9c-42d0-4267-a51f-0dc7699102ee'
and activeflag = 1
and programkey = 'OOH';

select *
from tb_client_eligibility
where removal_id  = 290955
and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
    update_user_id = 'CDM-36906',
    update_ts = now()
where removal_id = 290955
and delete_sw = 'N' ;