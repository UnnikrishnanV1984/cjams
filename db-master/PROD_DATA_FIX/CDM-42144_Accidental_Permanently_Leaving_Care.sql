
/*
    Issue Description: CDM-42144
  Category/ Module  : Placement
  Root cause: Data fix, updated the Living arrangement exit type to CIP , also removed the child removal and OOH end date
  case# 3259408
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/
--objectid: 2037a381-ea87-4625-b733-e925c9aae2c2
-- Placement
/*
select placementid, startdatetime, starttime, enddatetime, enddatetime,endtime,
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'ba58ac4a-092a-4f6b-ad92-9f9d714941e8'
	and activeflag = 1 ;
*/
update cjams.placement  
set
	exittypekey = 'CIP',
	updatedon = now(), 
	updatedby = 'CDM-42144'
where placementid = 'ba58ac4a-092a-4f6b-ad92-9f9d714941e8'
	and activeflag  = 1 ;

-- Placement Revision
/*
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon,activeflag
	from cjams.placementrevision  
where placementid = 'ba58ac4a-092a-4f6b-ad92-9f9d714941e8'
*/

update cjams.placementrevision  
set exittypekey = 'CIP',
	updatedon = now(), 
	updatedby = 'CDM-42144'
where placementid = 'ba58ac4a-092a-4f6b-ad92-9f9d714941e8'
and activeflag = 1;
	
-- Update Removal date
/*
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 298593
	and activeflag = 1 ;
	and intakeservreqchildremovalid = '1018ea0c-5a81-4acc-9155-99c59db7e004'	
*/

update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	 returntransts = NULL,
	removalexitreason = NULL,
	updatedby = 'CDM-42144',
	updatedon = now()
where removalid = 298593
	and activeflag = 1 ;
	
-- Update OOH
/*select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'ab37c931-13dd-4728-97cb-1ab9167bb5e5'
	and activeflag = 1 ;
*/

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-42144',
	updatedon = now()
where personprogramid = 'ab37c931-13dd-4728-97cb-1ab9167bb5e5'
	and activeflag = 1 ;
	
-- Update Eligibility
/*select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  298593
	and delete_sw = 'N' ;*/

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-42144',
	update_ts = now()
where removal_id =  298593
	and delete_sw = 'N' ;