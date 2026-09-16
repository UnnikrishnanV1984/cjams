-- CDM-19092 - Removal and Placement do not have end dates
/*
-- Issue Description: 
   User request to end date the Child Removal/OOH/Placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21
   
-- Case ID: 3230720
-- Client ID: 3390914 (WYKEBA TANAY	WOODFOLK-BLUE) - e458799a-276f-4ae9-834f-92effd4130e6
-- LA Placement ID: 1524381 - 2019-11-04 To Current - 23ea6462-ad9b-4df8-a478-2f7e2b0e87bc
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
where placementid = '23ea6462-ad9b-4df8-a478-2f7e2b0e87bc'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-19092'
where placementid = '23ea6462-ad9b-4df8-a478-2f7e2b0e87bc'
	and activeflag = 1 ;
	
select livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon, activeflag
	from livingarrangement 
where placementid = '23ea6462-ad9b-4df8-a478-2f7e2b0e87bc'
	and activeflag  = 1 ;

update cjams.livingarrangement
set livingenddate = '2021-09-30 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-19092' 
where placementid = '23ea6462-ad9b-4df8-a478-2f7e2b0e87bc'
	and activeflag  = 1 ;

-- Removal 
select removalid, removaldate, exitdate, removalexitreason, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid = 179589
	and activeflag = 1 
	and exitdate is null ;

update cjams.intakeservreqchildremoval 
set exitdate = '2021-09-30 17:00:00',
	removalexitreason = 'EMANIND',
	returntransts = now(),
	updatedby = 'CDM-19092',
	updatedon = now()
where removalid = 179589
	and activeflag = 1	
	and exitdate is null ;	
	
-- OOH
select programkey, startdate, enddate, updatedby, updatedon 
	from personprogramarea 
where personprogramid = '32c57253-bf50-4b96-923f-fd702c5349b2'
	and personid = 'e458799a-276f-4ae9-834f-92effd4130e6'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea	
set enddate = '2021-09-30 17:00:00',
	updatedby = 'CDM-19092',
	updatedon = now()
where personprogramid = '32c57253-bf50-4b96-923f-fd702c5349b2'
	and personid = 'e458799a-276f-4ae9-834f-92effd4130e6'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 155537
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2021-09-30',
	update_user_id = 'CDM-19092',
	update_ts = now()
where eligibility_id = 155537
	and delete_sw = 'N' ;
