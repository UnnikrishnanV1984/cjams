-- CDM-37354 - Child Removal
/*
-- Issue Description: 
   User request to delete child removal which was under wrong PID.

-- Case ID: 3224422
-- CJAMS PID: 200830889 (Khloe Carr) (e51a35ce-26d3-4b0d-bc17-705c800a2d73)

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error,User request to delete child removal which was under wrong PID.
-- Fix Provided: Datafix has been promoted to delete the requested  child removal.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the requested child removal (CDM-37354)
select *
	from cjams.intakeservreqchildremoval
where removalid = 304338
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-37354',
	updatedon = now()
where removalid = 304338
	and activeflag = 1;

select * from intakeservreqchildremoval_history
where intakeservreqchildremovalid = '59380726-715a-41c7-92ed-a7a876cd1e84'
and activeflag = 1;

update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CDM-37354',
	updatedon = now()
where intakeservreqchildremovalid = '59380726-715a-41c7-92ed-a7a876cd1e84'
and activeflag = 1;

select * from routing
where objectid = '59380726-715a-41c7-92ed-a7a876cd1e84'
and eventcode = 'CHRR'
and activeflag = 1;

update routing
set activeflag = 0,
	updatedby = 'CDM-37354',
	updatedon = now()
where objectid = '59380726-715a-41c7-92ed-a7a876cd1e84'
and eventcode = 'CHRR'
and activeflag = 1;

select programkey, startdate, enddate, *
from personprogramarea
where personid = 'e51a35ce-26d3-4b0d-bc17-705c800a2d73'
and activeflag = 1
and programkey = 'OOH';

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-37354',
	updatedon = now()
where personid = 'e51a35ce-26d3-4b0d-bc17-705c800a2d73'
and activeflag = 1
and programkey = 'OOH';

select *
from tb_client_eligibility
where removal_id  = 304338
and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
    update_user_id = 'CDM-37354',
    update_ts = now()
where removal_id = 304338
and delete_sw = 'N' ;