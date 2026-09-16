-- CDM-19095 - Placement and Removal need end dates
/*
-- Issue Description: 
   User request to end date the Child Removal/OOH/Placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21
   
-- Case ID: 3238990
-- Client ID: 1134405 (TYONA S BACKUS) - 047d6748-2e42-497d-8e1d-cfaa9660ac43
-- LA Placement ID: 1559171 - 2020-11-10 To Current - d1956cd2-e2a6-4fba-ba05-232b76e27f97
-- Living Arrangement: Own home/Apartment

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Exit 
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'd1956cd2-e2a6-4fba-ba05-232b76e27f97'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-19095'
where placementid = 'd1956cd2-e2a6-4fba-ba05-232b76e27f97'
	and activeflag = 1 ;
	
select livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon, activeflag
	from livingarrangement 
where placementid = 'd1956cd2-e2a6-4fba-ba05-232b76e27f97'
	and activeflag  = 1 ;

update cjams.livingarrangement
set livingenddate = '2021-09-30 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-19095' 
where placementid = 'd1956cd2-e2a6-4fba-ba05-232b76e27f97'
	and activeflag  = 1 ;

-- Removal 
select removalid, removaldate, exitdate, removalexitreason, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid = 170346
	and activeflag = 1 
	and exitdate is null ;

update cjams.intakeservreqchildremoval 
set exitdate = '2021-09-30 17:00:00',
	removalexitreason = 'EMANIND',
	returntransts = now(),
	updatedby = 'CDM-19095',
	updatedon = now()
where removalid = 170346
	and activeflag = 1	
	and exitdate is null ;	
	
-- OOH
select programkey, startdate, enddate, updatedby, updatedon 
	from personprogramarea 
where personprogramid = 'd875b650-0e7b-4fcf-946f-314ced292799'
	and personid = '047d6748-2e42-497d-8e1d-cfaa9660ac43'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea	
set enddate = '2021-09-30 17:00:00',
	updatedby = 'CDM-19095',
	updatedon = now()
where personprogramid = 'd875b650-0e7b-4fcf-946f-314ced292799'
	and personid = '047d6748-2e42-497d-8e1d-cfaa9660ac43'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 148045
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2021-09-30',
	update_user_id = 'CDM-19095',
	update_ts = now()
where eligibility_id = 148045
	and delete_sw = 'N' ;

