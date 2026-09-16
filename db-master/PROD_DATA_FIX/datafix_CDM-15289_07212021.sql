-- CDM-15289 - Remove the end date
/*
-- Issue Description: 
   User error, Datafix request to re-open the Placement
   so that user can void the current placement & create new with Pre-Finalized Adoptive Home structure 
   
-- Case ID: 3275159
-- Client ID: 4064588 (KAMDEN NATHANIEL JOHNSON)
-- Placement ID: 330240 - 2018-05-22 To 2021-07-21 - 7d3d2678-e6ac-4aa6-99db-823be3006691
-- Provider ID: 5084791	(Suzette Woodham) 
-- Structure : 9 -Restricted (Relative) Foster Care
    
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
where placementid = '7d3d2678-e6ac-4aa6-99db-823be3006691'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-15289'
where placementid = '7d3d2678-e6ac-4aa6-99db-823be3006691'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '7d3d2678-e6ac-4aa6-99db-823be3006691' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-15289'
where placementid = '7d3d2678-e6ac-4aa6-99db-823be3006691' 
	and exitdate is not null ;
	
-- Update Removal
select removaldate, exitdate, returndate, returntime, updatedby, updatedon  
	from cjams.intakeservreqchildremoval
where removalid = 184462
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	updatedby = 'CDM-15289',
	updatedon = now()
where removalid = 184462
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'e8316bb7-81a4-47f0-8059-1852019cea21'
	and activeflag = 1 ;


update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-15289',
	updatedon = now()
where personprogramid = 'e8316bb7-81a4-47f0-8059-1852019cea21'
	and activeflag = 1 ;
	
-- Legal Custody is active in this case
/*
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = ??
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-15289',
	updatedon = now()
where legalcustodyid = ?? 
	and activeflag = 1;
*/
	
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 159239
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-15289',
	update_ts = now()
where eligibility_id = 159239
	and delete_sw = 'N' ;
	
/*
Eligibility Period is active in this case
select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id = 159239
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-15289',
	update_ts = now()
where eligibility_id = 159239
	and delete_sw = 'N' ;
*/
