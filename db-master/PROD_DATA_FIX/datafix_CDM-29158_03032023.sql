-- CDM-29158 - Remove end date for placement/removal
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 221030014226
-- Client ID: 4197130 (ZOEY ANNALYNN SMITH) - 554b37d3-33ec-4180-aab4-6bbd024c6d95
-- Placement ID: 1587478 - 2022-08-24 TO 2023-03-02 - 867c6580-a928-4689-ba40-5c29b75c65cb
-- Provider ID: 6012390 (Deborah Ann Smith) - Local Department Home

-- Removal ID: 254050 - 2022-05-18 To 2023-03-02 - 2d683596-d7fe-427e-ab5f-a6c1c9ec1d1d
-- OOH: 2022-05-18 To 2023-03-02 - b515bdf1-bb05-4bb7-8b81-b3aaa6edeb8a

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E
-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '867c6580-a928-4689-ba40-5c29b75c65cb'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-29158'
where placementid = '867c6580-a928-4689-ba40-5c29b75c65cb'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '867c6580-a928-4689-ba40-5c29b75c65cb'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-29158'
where placementid = '867c6580-a928-4689-ba40-5c29b75c65cb'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 254050
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-29158',
	updatedon = now()
where removalid = 254050
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'b515bdf1-bb05-4bb7-8b81-b3aaa6edeb8a'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-29158',
	updatedon = now()
where personprogramid = 'b515bdf1-bb05-4bb7-8b81-b3aaa6edeb8a'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  254050
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-29158',
	update_ts = now()
where removal_id =  254050
	and delete_sw = 'N' ;
