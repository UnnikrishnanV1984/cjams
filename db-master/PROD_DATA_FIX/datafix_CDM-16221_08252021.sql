-- CDM-16221 - Multiple placements
/*
-- Issue Description: 
   User request delete the Duplicate Placements for 2 clients under Srevice Case # 3294848
   
-- Case ID: 3294848 - 7b5c8471-0d06-47ee-ad6d-a2ae75200bd1 
-- Client ID: 2267015 (IZAIA L DORSEY) - 1d066609-0fb2-42e3-a301-53f92d735b2d
-- Placement ID: 1565621 - 2021-08-18 To Current - 3fd7532e-ec3c-41cb-b6dc-5084d18a84f6
-- Provider ID: 5095139	(Anna Stewart)

-- Client ID: 4493908 (SHAWNA ADEDIPE) - 8086d054-13ca-4168-8980-50f801caef99
-- Placement ID: 1565613 - 2021-08-17 To Current - b1d49133-5a28-47cc-818d-a1b470fd9a66
-- Provider ID: 5095233	(Cynthia Grabenstein)

-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-16221',
	updatedon = now()
where placementid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	exitdate = entrydate,
	updatedby = 'CDM-16221',
	updatedon = now()
where placementid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and activeflag = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	livingenddate = livingstartdate,
	updatedby = 'CDM-16221',
	updatedon = now()
where placementid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and activeflag = 1 ;	
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-16221',
	updatedon = now()
where objectid in ('b1d49133-5a28-47cc-818d-a1b470fd9a66','3fd7532e-ec3c-41cb-b6dc-5084d18a84f6')
	and eventcode = 'PLTR'
	and activeflag = 1 ;

select placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
	validation_status_cd, update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id in (1565621, 1565613)
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16221'
where placement_id in (1565621, 1565613)
	and delete_sw  = 'N';
