/*
    Issue Description: CDM-41693
  Category/ Module  : Placement
  Root cause: Data fix, updated the Living arrangement exit type to CIP , also removed the child removal and OOH end date
  case# 231030079332
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

-- Placement
/*
select alternateid, startdatetime, starttime, enddatetime, enddatetime,endtime,
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '62c399be-45ee-408a-a525-8497b6c670d4'
	and activeflag = 1 ;
*/

update cjams.placement  
set
	exittypekey = 'CIP',
	updatedon = now(), 
	updatedby = 'CDM-41693'
where placementid = '62c399be-45ee-408a-a525-8497b6c670d4'
	and activeflag  = 1 ;

-- Placement Revision
/*
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '62c399be-45ee-408a-a525-8497b6c670d4'
*/

update cjams.placementrevision  
set exittypekey = 'CIP',
	updatedon = now(), 
	updatedby = 'CDM-41693'
where placementid = '62c399be-45ee-408a-a525-8497b6c670d4';
	
-- Update Removal date
/*
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 271259
	and activeflag = 1 ;
*/
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	 returntransts = NULL,
	removalexitreason = NULL,
	updatedby = 'CDM-41693',
	updatedon = now()
where removalid = 271259
	and activeflag = 1 ;
	
-- Update OOH
/*select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '01591d59-57a6-47c1-a7d6-97cb94770339'
	and activeflag = 1 ;
*/

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-41693',
	updatedon = now()
where personprogramid = '01591d59-57a6-47c1-a7d6-97cb94770339'
	and activeflag = 1 ;
	
-- Update Eligibility
/*select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  271259
	and delete_sw = 'N' ;*/

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-41693',
	update_ts = now()
where removal_id =  271259
	and delete_sw = 'N' ;