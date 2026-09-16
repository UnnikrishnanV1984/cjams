-- CDM-29825 - Incorrect Removal Date
/*
-- Issue Description: 
   User request to change the Removal Date from 12/29/2022 to 12/22/2022. 

-- Case ID: 3113399
-- Client ID: 200996788 (Janea Bell) - 7bfd1a47-75f9-4a30-9258-72c8ea25d45f
-- Removal ID: 258348 - 2022-12-29 To Current - ae72e47a-6d12-41b3-b2e2-0d0a03822fbd
-- OOH : 30002151-0d07-4033-ad8b-87528723b50c
-- IV-E ID: 10011418
    
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Removal date changes
select removaldate, exitdate, returndate, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where intakeservreqchildremovalid = 'ae72e47a-6d12-41b3-b2e2-0d0a03822fbd'
	and activeflag = 1 ;

update cjams.intakeservreqchildremoval
set removaldate = '2022-12-22 00:00:00',
	updatedby = 'CDM-29825',
	updatedon = now()
where intakeservreqchildremovalid = 'ae72e47a-6d12-41b3-b2e2-0d0a03822fbd'
	and activeflag = 1 ;

-- OOH End date changes
select personid, programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '30002151-0d07-4033-ad8b-87528723b50c'
	and activeflag = 1 ;

update cjams.personprogramarea
set startdate = '2022-12-22 00:00:00',
	updatedby = 'CDM-29825',
	updatedon = now()
where personprogramid = '30002151-0d07-4033-ad8b-87528723b50c'
	and activeflag = 1 ;
	
-- Eligibility End date changes
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 10011418
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set start_dt = '2022-12-22'::date,
	update_user_id = 'CDM-29825',
	update_ts = now()
where eligibility_id = 10011418
	and delete_sw = 'N' ;
	
select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id = 10011418
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set start_dt = '2022-12-22'::date,
	update_user_id = 'CDM-29825',
	update_ts = now()
where eligibility_id = 10011418
	and delete_sw = 'N' ;
	