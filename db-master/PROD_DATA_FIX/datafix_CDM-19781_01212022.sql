-- CDM-19781 - Disclosure Date
/*
-- Issue Description: 
   User error, Datafix request to re-open the Child Removal / OOH 
   
-- Case ID: 2020014301277
-- Client ID: 4419092 (RALEIGH KEYSHAWN	CHAPPELL) - 02aabbe1-d457-4a3f-ac8c-d2fe93914f03
-- Removal ID: 250919 - 2020-09-15 To 2021-11-23 - 6b079135-ca40-4096-853b-39c13a17519c

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
where removalid = 250919
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-19781',
	updatedon = now()
where removalid = 250919
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where  personprogramid  = '3a9edd30-f73c-4f62-9972-8e69d69ad7a2'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-19781',
	updatedon = now()
where  personprogramid  = '3a9edd30-f73c-4f62-9972-8e69d69ad7a2'
	and activeflag = 1 ;
	
	
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 10000998
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-19781',
	update_ts = now()
where eligibility_id = 10000998
	and delete_sw = 'N' ;
	
/*
Eligibility Periods are Active in this case
*/

-- Legal Custody
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = 'a62d6044-33a1-4e52-be72-fd50aa89828a'
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-19781',
	updatedon = now()
where legalcustodyid = 'a62d6044-33a1-4e52-be72-fd50aa89828a'
	and activeflag = 1;

-- GAP ID: 1005915 - 2021-11-23 To 2035-07-04 - de5a2b9b-4f98-47a5-9e64-b2e31e040801
-- Delete Duplicate GAP
select alternateid, activeflag,  updatedby, updatedon 
	from guardianship 
where gapid = 'de5a2b9b-4f98-47a5-9e64-b2e31e040801'
	and activeflag = 1 ;

update guardianship
set activeflag = 0,
	updatedby = 'CDM-19781',
	updatedon = now()
where gapid = 'de5a2b9b-4f98-47a5-9e64-b2e31e040801'
	and activeflag = 1 ;

select activeflag, gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid  = 'de5a2b9b-4f98-47a5-9e64-b2e31e040801'
	and activeflag = 1;

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-19781',
	updatedon = now()
where gapid = 'de5a2b9b-4f98-47a5-9e64-b2e31e040801'
	and activeflag = 1;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = '62c8877a-612c-48c7-a535-c33cfb1b6bb2'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
	updatedby = 'CDM-19781',
	updatedon = now()
where objectid = '62c8877a-612c-48c7-a535-c33cfb1b6bb2'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
