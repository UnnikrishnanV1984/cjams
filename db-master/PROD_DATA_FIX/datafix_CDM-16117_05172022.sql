-- CDM-16117 -- Removal ended for the wrong child
/*
-- Issue Description: 
   User error to Remove the duplicate PA for Client ID: 4317794 (Alejandro Vernono)
   and re-open the removal for CJAMS PID# : 200673400 (Rickey Jeffrey)
   
-- Case ID: 211030008530 - imani.booker@maryland.gov

-- Client ID: 4317794 (Alejandro Vernono Ramirez) - 2de6fef8-fb01-4757-8004-84c1b935212b
-- OOH ID: 2021-06-03 to Current - 90765ea8-bcbe-4434-b672-202e7f7e4e0c

-- Client ID: 200673400	(Rickey Jeffrey	Myles) - 8640d24b-e31b-4915-b2e2-1701a6fb0c4b
-- Removal ID: 252166 - 2021-06-03 To 2021-08-03 (Re-open)

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 4317794 (Alejandro Vernono Ramirez) - 2de6fef8-fb01-4757-8004-84c1b935212b
-- Delete Duplicate Out of Home
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid  = '90765ea8-bcbe-4434-b672-202e7f7e4e0c'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = startdate, 
	activeflag = 0,
	updatedby = 'CDM-16117',
	updatedon = now()
where personprogramid  = '90765ea8-bcbe-4434-b672-202e7f7e4e0c'
	and activeflag = 1 ;

-- End date Eligibility -- 2021-08-03
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id  = 252165
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2021-08-03'::date,
	update_user_id = 'CDM-16117',
	update_ts = now()
where removal_id  = 252165
	and delete_sw = 'N' ;
	
	
select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id = 10002539
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = '2021-08-03'::date,
	update_user_id = 'CDM-16117',
	update_ts = now()
where eligibility_id = 10002539
	and delete_sw = 'N' ;	

-- Client ID: 200673400	(Rickey Jeffrey	Myles) - 8640d24b-e31b-4915-b2e2-1701a6fb0c4b
-- Datafix to re-open the Removal
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252166
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null, -- 2021-08-03 12:30:00
	returndate = Null,
	returntime = Null,  
	removalexitreason = NULL, -- REUNIF
	updatedby = 'CDM-16117',
	updatedon = now()
where removalid = 252166
	and activeflag = 1 ;
	
-- OOH is active
