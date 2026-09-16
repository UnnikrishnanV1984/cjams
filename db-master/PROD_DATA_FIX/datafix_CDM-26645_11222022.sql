-- CDM-26645 - Re-opening a GAP
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 3260139
-- Client ID: 3957255 (TAELYN NICOLE MARTIN) - 54d7e593-cc70-4362-8965-4af1a7205f55
-- Placement ID: 1574416 - 2021-05-12 To 2022-10-31 - 59ff59ba-6389-4727-94d3-ddb52208bc6a
-- Provider ID: 6007016	(Latoyia Denay Carroll) - Local Department Home
-- Removal ID: 252027 - 2021-05-12 To 2022-10-31  - b03eb201-8be9-414b-a13c-3ea9a8f6bcab
-- OOH: 2021-05-12 To 2022-10-31 - edbe8940-e4e9-4b2a-b166-9426fb40c68f 
-- GAP: 2022-09-14 To Current - a1f5cff6-024c-4b90-8dff-1f2558452223 (end date as 03/14/2030)

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
where placementid = '59ff59ba-6389-4727-94d3-ddb52208bc6a'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-26645'
where placementid = '59ff59ba-6389-4727-94d3-ddb52208bc6a'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '59ff59ba-6389-4727-94d3-ddb52208bc6a'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-26645'
where placementid = '59ff59ba-6389-4727-94d3-ddb52208bc6a'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252027
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-26645',
	updatedon = now()
where removalid = 252027
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'edbe8940-e4e9-4b2a-b166-9426fb40c68f'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-26645',
	updatedon = now()
where personprogramid = 'edbe8940-e4e9-4b2a-b166-9426fb40c68f'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  252027
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-26645',
	update_ts = now()
where removal_id =  252027
	and delete_sw = 'N' ;
	
-- Update GAP
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'a1f5cff6-024c-4b90-8dff-1f2558452223'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = '2030-03-14'::date, 
	updatedby = 'CDM-26645',
	updatedon = now()
where personprogramid = 'a1f5cff6-024c-4b90-8dff-1f2558452223'
	and activeflag = 1 ;

