-- CDM-19099 - Removal and Placements not end dated
/*
-- Issue Description: 
   User request to end date the Child Removal/OOH/Placement as of 09/30/2021
   Exception scenario: Youth is 21 and was allowed to remain in care beyond 21

-- Case ID: 3114392
-- Client ID: 1714865 (DAVID A BATES) - 3eb5ff5d-6c76-403f-ad70-7affbf7223c5
-- LA Placement ID: 1491071 - 2020-06-07 To Current - 56514683-2452-461f-8786-e3481aa9fc58
-- Living Arrangement: Adult Correctional Institution

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
where placementid = '56514683-2452-461f-8786-e3481aa9fc58'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-09-30 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-19099'
where placementid = '56514683-2452-461f-8786-e3481aa9fc58'
	and activeflag = 1 ;
	
select livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon, activeflag
	from livingarrangement 
where placementid = '56514683-2452-461f-8786-e3481aa9fc58'
	and activeflag  = 1 ;

update cjams.livingarrangement
set livingenddate = '2021-09-30 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-19099' 
where placementid = '56514683-2452-461f-8786-e3481aa9fc58'
	and activeflag  = 1 ;

-- Removal 
select removalid, removaldate, exitdate, removalexitreason, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid = 177959
	and activeflag = 1 
	and exitdate is null ;

update cjams.intakeservreqchildremoval 
set exitdate = '2021-09-30 17:00:00',
	removalexitreason = 'EMANIND',
	returntransts = now(),
	updatedby = 'CDM-19099',
	updatedon = now()
where removalid = 177959
	and activeflag = 1	
	and exitdate is null ;	
	
-- OOH
select programkey, startdate, enddate, updatedby, updatedon 
	from personprogramarea 
where personprogramid = 'b02a1849-ea74-496c-8ee4-fa79c9b4669b'
	and personid = '3eb5ff5d-6c76-403f-ad70-7affbf7223c5'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea	
set enddate = '2021-09-30 17:00:00',
	updatedby = 'CDM-19099',
	updatedon = now()
where personprogramid = 'b02a1849-ea74-496c-8ee4-fa79c9b4669b'
	and personid = '3eb5ff5d-6c76-403f-ad70-7affbf7223c5'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where eligibility_id = 154211
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = '2021-09-30',
	update_user_id = 'CDM-19099',
	update_ts = now()
where eligibility_id = 154211
	and delete_sw = 'N' ;
