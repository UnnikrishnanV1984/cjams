-- CDM-16395 - Children leaving care and custody
/*
-- Issue Description: 
   User error, Datafix request to re-open the Placement / Child Removal / OOH of 2 Clients
   GAP setup were done for these kids in error; user is enddating & suspending the GAPs.
   
-- Case ID: 3252249
-- Provider ID: 5075618	(Deanna Rae Neely)

-- Client ID: 3823194 (GABRIEL RICHARD MURPHY) - a45721d5-cf31-49f8-98b3-84e423866cf7
-- GAP ID: 1005808 - dade2513-8214-4d51-abb5-df79536df599
-- Placement ID: 337832 - 2019-10-30 To	2021-07-21 - cce566c6-a535-4aff-8a42-464cb45101d9
-- Removal ID: 197647
-- IV-E : 169915
-- OOH: 2019-10-30 To 2021-07-21 - 38548be5-669b-42dd-9255-4b5cb97ebce2
 
-- Client ID: 4077689 (SAVANNAH MURPHY) - 684b9d31-b31f-4c4f-83ea-381e282293a9
-- GAP ID: 1005809 - f1dda8d3-3615-4067-b70f-695dd55a275e
-- Placement ID: 337831 - 2019-10-30 To 2021-07-21 - 973ab411-c769-4998-84c8-2089f1c4a3e8
-- Removal ID: 197761
-- IV-E : 169993
-- OOH: 2019-10-30 To 2021-07-21 - 9ae388a7-3fba-4919-a6bc-d321395319da 
 
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
where placementid in ('cce566c6-a535-4aff-8a42-464cb45101d9',  '973ab411-c769-4998-84c8-2089f1c4a3e8')
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-16395'
where placementid in ('cce566c6-a535-4aff-8a42-464cb45101d9',  '973ab411-c769-4998-84c8-2089f1c4a3e8')
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid in ('cce566c6-a535-4aff-8a42-464cb45101d9',  '973ab411-c769-4998-84c8-2089f1c4a3e8')
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-16395'
where placementid in ('cce566c6-a535-4aff-8a42-464cb45101d9',  '973ab411-c769-4998-84c8-2089f1c4a3e8')
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid in (197647, 197761)
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-16395',
	updatedon = now()
where removalid in (197647, 197761)
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid in ('38548be5-669b-42dd-9255-4b5cb97ebce2', '9ae388a7-3fba-4919-a6bc-d321395319da')
	and activeflag = 1 ;


update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-16395',
	updatedon = now()
where personprogramid in ('38548be5-669b-42dd-9255-4b5cb97ebce2', '9ae388a7-3fba-4919-a6bc-d321395319da')
	and activeflag = 1 ;
	
-- Legal Custodies are Active in this case
/*
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = ??
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-16395',
	updatedon = now()
where legalcustodyid = ?? 
	and activeflag = 1;
*/
	
-- Update Eligibility
select client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id in (169915, 169993)
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-16395',
	update_ts = now()
where eligibility_id in (169915, 169993)
	and delete_sw = 'N' ;
	
/*
Eligibility Periods are Active in this case

select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id in (169915, 169993)
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-16395',
	update_ts = now()
where eligibility_id in (169915, 169993)
	and delete_sw = 'N' ;
*/

-- Call to generate missing Placement Vlaidations
select al_sqlcode, as_mess  
from cjams.sp_placement_validation_datafix(current_date, current_date, 'CDM-16395'::character varying ) ;

