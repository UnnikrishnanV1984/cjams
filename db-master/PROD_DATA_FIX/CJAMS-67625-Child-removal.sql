/*
-- Issue Description: 
        Need data fix to remove the highlighted record from child removal
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error,User request to delete child removal which was under wrong PID.
-- Fix Provided: Datafix has been promoted to delete the requested  child removal.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CJAMS-67625',
	updatedon = now()
where removalid = 375273
	and activeflag = 1;



update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CJAMS-67625',
	updatedon = now()
where intakeservreqchildremovalid = 'ace4cc8a-1ac5-4a17-ba39-f8097de5e716'
and activeflag = 1;


update routing
set activeflag = 0,
	updatedby = 'CJAMS-67625',
	updatedon = now()
where objectid = 'ace4cc8a-1ac5-4a17-ba39-f8097de5e716'
and eventcode = 'CHRR'
and activeflag = 1;



update personprogramarea
set activeflag = 0,
	updatedby = 'CJAMS-67625',
	updatedon = now()
where personid = 'e03d37fb-c132-4285-bd55-b49bd017da02'
and personprogramid='8f29b62a-af2f-43fd-8fec-002c4ff14cc0' and  programkey = 'OOH';


update tb_client_eligibility
set delete_sw = 'Y',
    update_user_id = 'CJAMS-67625',
    update_ts = now()
where removal_id = 385385
and delete_sw = 'N' ;