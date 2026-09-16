-- CDM-23077 - Cinthia Castellanos
/*
-- Issue Description: 
	The entry date of child, Cinthia Castellanos, of incorrect. 
	
	User error, Datafix request to change the Child Removal / OOH start date as 07/06/2020.
   
-- Case ID: 2020019901874
-- Client ID: 786594 (CINTHIA CASTELLANOS) - 2ddb2062-dfcd-460e-95c0-d5a92c0477f5
-- Removal ID: 250584 - 07/07/2020 To Current 
-- OOH: 204c691c-1919-464e-9837-6968383273e9 - 07/07/2020 To Current

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update the Removal, OOH & IV-E Start Dates as 07/06/2020
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 250584
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set removaldate = '2020-07-06 00:00:00',
	updatedby = 'CDM-23077',
	updatedon = now()
where removalid = 250584
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid  = '204c691c-1919-464e-9837-6968383273e9'
	and activeflag = 1 ;

update cjams.personprogramarea 
set startdate = '2020-07-06 00:00:00', 
	updatedby = 'CDM-23077',
	updatedon = now()
where  personprogramid  = '204c691c-1919-464e-9837-6968383273e9'
	and activeflag = 1 ;
	
	
-- Update Eligibility
select eligibility_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id  = 250584
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set start_dt = '2020-07-06',
	update_user_id = 'CDM-23077',
	update_ts = now()
where removal_id  = 250584
	and delete_sw = 'N' ;
	
select start_dt, end_dt, update_ts, update_user_id, delete_sw 
	from tb_eligibility_period
where eligibility_id = 10000671 ;

update cjams.tb_eligibility_period
set start_dt = '2020-07-06',
	update_user_id = 'CDM-23077',
	update_ts = now()
where eligibility_id = 10000671 ;
