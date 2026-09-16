-- CDM-31478 - Need child placement added
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 3162272
-- Client ID: 4051369 (TRISTAN TREUELLE	JOHNSON-MITCHELL) - 41d6fcbc-d2f1-4dfb-961c-8ee2e1e6e622
-- Placement ID: 1667909 - 2023-02-16 To 2023-05-04 - 0f6927d5-a71a-4769-a429-f49312623c73
-- Provider ID: 6040362	(AINA HORTON) - Local Department Home

-- Removal ID: 251840 - 2021-04-02 To 2023-05-04 - db0c3630-c119-46a5-871b-52f7dbe29e0b
-- OOH: 2021-04-02 To 2023-05-04 - e25e5e19-4359-45b8-a107-c39346cab283

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Placement / Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E
-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '0f6927d5-a71a-4769-a429-f49312623c73'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-31478'
where placementid = '0f6927d5-a71a-4769-a429-f49312623c73'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '0f6927d5-a71a-4769-a429-f49312623c73'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-31478'
where placementid = '0f6927d5-a71a-4769-a429-f49312623c73'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 251840
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-31478',
	updatedon = now()
where removalid = 251840
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'e25e5e19-4359-45b8-a107-c39346cab283'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-31478',
	updatedon = now()
where personprogramid = 'e25e5e19-4359-45b8-a107-c39346cab283'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  251840
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-31478',
	update_ts = now()
where removal_id =  251840
	and delete_sw = 'N' ;
