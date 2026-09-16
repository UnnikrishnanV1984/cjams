-- CDM-10223 -- Removal End Issue
/*
-- Issue Description: 
   Datafix request to end date the child Removal as of 11/18/2020
   
   Case ID: 3267142 
   Client ID: 3952417 
    
-- Category/ Module: Removal (Case Management) 
-- Root cause: CJAMS is currently not allowing the user to end date the removal beyond max Service Log end date. 
			   We need a User Story to modify the code and remove that validation 	 
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Datafix to update Removal End date as 11/18/2020 (Old value was Null - Active Removal)
-- Update Removal, OOH & IV-E

-- Update Removal
select removaldate, exitdate, returndate, returntime, updatedby, updatedon  
	from cjams.intakeservreqchildremoval
where intakeservreqchildremovalid = '37856ba1-cdd1-4dc5-81ad-ad625576561f'
	and activeflag = 1 ;
	
	
update cjams.intakeservreqchildremoval
set exitdate = '2020-11-18 00:00:00',
	returndate = '2020-11-18 00:00:00',
	returntime = '2020-11-18 00:00:00',
	updatedby = 'CDM-10223',
	updatedon = now()
where intakeservreqchildremovalid = '37856ba1-cdd1-4dc5-81ad-ad625576561f'
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'eb38951f-fcd7-4631-8395-b117a90c5890'
	and activeflag = 1 ;


update cjams.personprogramarea 
	set enddate = '2020-11-18 00:00:00', 
		updatedby = 'CDM-10223',
		updatedon = now()
where personprogramid = 'eb38951f-fcd7-4631-8395-b117a90c5890'
	and activeflag = 1 ;
	
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 10000805
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
	set end_dt = '2020-11-18'::date,
		update_user_id = 'CDM-10223',
		update_ts = now()
where eligibility_id = 10000805
	and delete_sw = 'N' ;
	
select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id = 10000805
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
	set end_dt = '2020-11-18'::date,
		update_user_id = 'CDM-10223',
		update_ts = now()
where eligibility_id = 10000805
	and delete_sw = 'N' ;

