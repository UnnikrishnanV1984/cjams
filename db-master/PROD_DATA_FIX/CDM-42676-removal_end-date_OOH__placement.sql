/*
    Issue Description: CDM-42676
  Category/ Module  : Placement
  Root cause: Data fix, updated the Living arrangement exit type to CIP , also removed the child removal and OOH end date
  case# 2020024802846
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/
--objectid: d6d776e2-e2a7-431a-813e-307b1a412dfa
-- Placement
/*
select placementid, startdatetime, starttime, enddatetime, enddatetime,endtime,
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'ace77397-fa2f-4b5d-91dd-069c00ca1b8c'
	and activeflag = 1;
*/
update cjams.placement  
set
	exittypekey = 'CIP',
	updatedon = now(), 
	updatedby = 'CDM-42676'
where placementid = 'ace77397-fa2f-4b5d-91dd-069c00ca1b8c'
	and activeflag  = 1;

-- Placement Revision
/*
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon,activeflag
	from cjams.placementrevision  
where placementid = 'ace77397-fa2f-4b5d-91dd-069c00ca1b8c'
*/

update cjams.placementrevision  
set exittypekey = 'CIP',
	updatedon = now(), 
	updatedby = 'CDM-42676'
where placementid = 'ace77397-fa2f-4b5d-91dd-069c00ca1b8c'
and activeflag = 1;
	
-- Update Removal date
/*
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag,*
	from cjams.intakeservreqchildremoval
where removalid = 250828
	 and activeflag = 1 
	and intakeservreqchildremovalid = 'e8bb208c-e96d-4172-8ac3-634b4f39d40e'	
*/

update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	 returntransts = NULL,
	removalexitreason = NULL,
	updatedby = 'CDM-42676',
	updatedon = now()
where removalid = 250828
	and activeflag = 1;
	
-- Update OOH
/*select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '0dc5762b-4493-40f1-b912-24cfc67da677'
	and activeflag = 1;
*/

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-42676',
	updatedon = now()
where personprogramid = '0dc5762b-4493-40f1-b912-24cfc67da677'
	and activeflag = 1;
	
-- Update Eligibility
/*select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  250828
	and delete_sw = 'N';*/

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-42676',
	update_ts = now()
where removal_id =  250828
	and delete_sw = 'N';