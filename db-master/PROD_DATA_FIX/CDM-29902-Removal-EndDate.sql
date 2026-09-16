/*
 Issue Description:CDM-29902
 Category/ Module: Child Removal
 Root cause: Might be glitch from user side/ Asked to update the end date of removal
 Pull request# 8454
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: data fix
 */

update intakeservreqchildremoval 
set exitdate = '2023-01-23 00:00:00', 
	updatedby = 'CDM-29902', 
	updatedon = now() 
where intakeservreqchildremovalid = 'd9e4a823-7ba8-453d-beac-65e86f81da36';


update tb_client_eligibility
set end_dt = '2023-01-23 00:00:00',
    update_user_id = 'CDM-29902',
    update_ts = now()
where removal_id = 251038;