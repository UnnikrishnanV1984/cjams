-- CDM-32987 - Incorrect Provider
/*
-- Issue Description: 
	Incorrect Provider on the most recent GAP rate 
    
-- Case ID: 3298445
-- Client ID: 200161415 (Julian	James Hayes) - bd00f68e-1f55-4358-aa84-23412e7b27cf
-- Provider ID: 6005656	(Kenyatta Carter)
-- GAP ID: 1006036 - 2022-03-21 To 2038-10-13 - 00d5d291-ddb0-4e42-818c-cca2e292b709

-- Delete Rate
-- 5036069	9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7	2024-03-21 12:00:00	2025-03-20 12:00:00	887

-- End date the GAP suspesnion
-- 3c37dbc6-4a47-460f-83c5-5798db792ee7	2023-03-01 05:00:00 To Currrent 

-- Wrong Provider ID: 5036069	(Tonya Tillman)

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB, Incorrect Provider got selecetd on the moste recent GAP rate slab.
-- Fix Provided: Datafix has been promoted to fix the GAP Rate and ned date the suspension. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Change the GAP Suspension Start date (CDM-32987)

-- Update GAP suspesnion Start date as 2023-03-21
-- 3c37dbc6-4a47-460f-83c5-5798db792ee7	2023-03-01 05:00:00 To Currrent 
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' 
	and activeflag = 1 ;
	
update gapsuspension
set startdate = '2023-03-21'::date,
	updatedby = 'CDM-32987',
	updatedon = now()	
where gapsuspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' 
	and activeflag = 1 ;

select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspensionrevision 
where suspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' ;
	
update gapsuspensionrevision
set startdate = '2023-03-21'::date,
	approvaldate = now(),	
	updatedby = 'CDM-32987',
	updatedon = now()
where suspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' ;

