-- CDM-20934 - Provider Placement
/*
-- Issue Description: 
	We are trying to close this service case to custody Guardianship however are unable to create a Provider Placement 
	for a previous date and removal that was ended 2/23/22. 
    User error, Datafix request to re-open the Child Removal / OOH 
   
-- Case ID: 2020011101134
-- Client ID: 200007085	(Spring Marie Joan Folsom) - 1b6f046a-4766-419a-b4e6-e6105f0c5ea2
-- Removal ID: 251615 - 2021-02-24 To 2022-02-23 - 37a46224-91ef-42a8-9819-3dc09da3bd3b

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
where removalid = 251615
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-20934',
	updatedon = now()
where removalid = 251615
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid  = 'cffeee00-af0c-4854-9a57-0bdebe168082'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-20934',
	updatedon = now()
where  personprogramid  = 'cffeee00-af0c-4854-9a57-0bdebe168082'
	and activeflag = 1 ;
	
	
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id  = 251615
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-20934',
	update_ts = now()
where removal_id  = 251615
	and delete_sw = 'N' ;
	
/*
Eligibility Periods are Active in this case
*/
