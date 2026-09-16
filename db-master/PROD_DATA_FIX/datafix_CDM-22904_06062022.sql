-- CDM-22904 - Unable to open GAP-Court case
/*
-- Issue Description: 
   User error, Datafix request to re-open the Placement / Child Removal / OOH
   so GAP subsidy can be started prior to court date 06/13/22   
      
-- Case ID: 3230006
-- Client ID: 3738912 (SEBASTIAN ALCUARD JONES) - 4bf5ab19-a258-44b4-bdb1-213d374f4b87
-- Placement ID: 324989 - 2018-01-27 To 2022-02-24 - 331f3981-5cd9-412a-9cdd-4fe0507c2f0a
-- Provider ID: 5013138	(Linda Wilkerson) - Local Department Home
-- Removal ID: 188068 - 2017-11-24 To 2022-02-24 - 1889cc32-6316-49ac-a27d-fbde5a3064a5
-- Eligibility ID: 162221
-- OOH: 2017-11-24 To 2022-02-24 - e0c671cd-ad56-4c74-b7a6-22013ab9678f
 
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
where placementid = '331f3981-5cd9-412a-9cdd-4fe0507c2f0a'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-22904'
where placementid = '331f3981-5cd9-412a-9cdd-4fe0507c2f0a'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '331f3981-5cd9-412a-9cdd-4fe0507c2f0a'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-22904'
where placementid = '331f3981-5cd9-412a-9cdd-4fe0507c2f0a'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 188068
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-22904',
	updatedon = now()
where removalid = 188068
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'e0c671cd-ad56-4c74-b7a6-22013ab9678f'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-22904',
	updatedon = now()
where personprogramid = 'e0c671cd-ad56-4c74-b7a6-22013ab9678f'
	and activeflag = 1 ;
	
-- Legal Custodies are Active in this case
/*
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = ??
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-22904',
	updatedon = now()
where legalcustodyid = ?? 
	and activeflag = 1;
*/
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  188068
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-22904',
	update_ts = now()
where removal_id =  188068
	and delete_sw = 'N' ;
	
/*
Eligibility Period is Active in this case

select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id =  162221
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-22904',
	update_ts = now()
where eligibility_id =  162221
	and delete_sw = 'N' ;
*/
