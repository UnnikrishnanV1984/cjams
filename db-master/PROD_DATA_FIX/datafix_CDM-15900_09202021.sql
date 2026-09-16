-- CDM-15900 - Break the Link Issue
/*
-- Issue Description: 
   User error, Datafix request to re-open the Child Removal / OOH 
   
-- Case ID: 3240220
-- Client ID: 3670525 (AYDEN SHERARD DEANS) - 1ab5bfba-2a4e-4dbe-ba96-cac058164e48
-- Placement ID: 332707 - 2021-08-04 To 2021-08-04 - 25def71e-a538-4dc9-8189-18ecd79c3448
-- Provider ID: 5071124 (Angelia Page) - Local Department Home

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Removal, OOH & IV-E

-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 168288
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-15900',
	updatedon = now()
where removalid = 168288
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where  personprogramid  = 'd1aa60d0-07c7-48c4-94e4-fc04d14e766b'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-15900',
	updatedon = now()
where  personprogramid  = 'd1aa60d0-07c7-48c4-94e4-fc04d14e766b'
	and activeflag = 1 ;
	
	
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 146285
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-15900',
	update_ts = now()
where eligibility_id = 146285
	and delete_sw = 'N' ;
	
/*
Eligibility Periods are Active in this case
Legal Custody is Active in this case
*/

