-- CDM-18872 - Adding placement- adoption
/*
-- Issue Description: 
   User request to re-open the child removal
   
-- Case ID: 3269372 - 8c238542-e496-4430-abea-1ad8c9c24550
-- Client ID: 4332839 (BROOKE BIANCHI) - b7863abc-edc0-4528-b6a5-754a30124dc2
  
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Removals 
-- Re-open -- 199931	2020-06-02 To 2021-11-18 - ca8bc7dc-d335-4b40-94f7-83d8c6afd77c
-- Delete  -- 253116	2020-06-02 To 2021-11-18 - ef860ea2-75b1-4159-82ed-8921624d414e

-- Placement
select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = 'ef860ea2-75b1-4159-82ed-8921624d414e'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= 'ca8bc7dc-d335-4b40-94f7-83d8c6afd77c',
	updatedby = 'CDM-18872',
	updatedon = now() 	
where intakeservreqchildremovalid = 'ef860ea2-75b1-4159-82ed-8921624d414e'
	and activeflag = 1 ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 199931 ;
	
update cjams.intakeservreqchildremoval
set activeflag = 1,
	exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-18872',
	updatedon = now()
where removalid = 199931 ;
--	and activeflag = 1 
		
-- update exit date as 2021-11-18 13:00:00 and Delete (to revert CDM-19062)
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from intakeservreqchildremoval 
where removalid  = 253116 ;

update cjams.intakeservreqchildremoval
set exitdate = '2021-11-18 13:00:00',
	activeflag = 0,
	updatedby = 'CDM-18872',
	updatedon = now()
where removalid = 253116 ;
	
-- Delete 
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = 'ef860ea2-75b1-4159-82ed-8921624d414e'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-18872',
	updatedon = now()
where objectid = 'ef860ea2-75b1-4159-82ed-8921624d414e'
	and activeflag = 1 ;

-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '9028e002-734f-47bf-845f-4c04a482b73c'
	and activeflag = 1 ;

update cjams.personprogramarea 
set activeflag = 0,
	updatedby = 'CDM-18872',
	updatedon = now()
where personprogramid = '9028e002-734f-47bf-845f-4c04a482b73c'
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '762dbb42-b6e2-4e58-b4c1-2c7dbb24a131'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = null,
	updatedby = 'CDM-18872',
	updatedon = now()
where personprogramid = '762dbb42-b6e2-4e58-b4c1-2c7dbb24a131'
	and activeflag = 1 ;
	
-- Update Eligibility
select eligibility_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 199931
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-18872',
	update_ts = now()
where removal_id = 199931
	and delete_sw = 'N' ;
	
-- Delete 	
select eligibility_id, client_id, start_dt, end_dt, update_ts, update_user_id, delete_sw 
	from cjams.tb_client_eligibility
where removal_id = 253116
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-18872',
	update_ts = now()
where removal_id = 253116
	and delete_sw = 'N' ;
