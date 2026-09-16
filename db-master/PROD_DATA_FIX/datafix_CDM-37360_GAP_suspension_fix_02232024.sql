-- CDM-37360 - GAP Error
/*
-- Issue Description: 
	GAP suspension was end dated by the user but there are no payments
	
-- Case ID: 221030014332
-- Client ID: 3835338 (ANTHONY DIONTE WALDRON) - a6b79306-3614-4e16-aa79-2283fcfa7aac
-- GAP ID: 1016129 - c40789df-07cc-468f-b18d-cfd343d08b50
-- Provider ID: 6088900	(Mattie  Flowers)
    	
-- Category/ Module: GAP (Case Management) 
-- Root cause: GAP suspension was end dated by the user and submitted for the approval but no record was inserted in the routing table.  
-- Fix Provided: Datafix has been promoted to fix the GAP suspension data.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To fix GAP suspension data (CDM-37360)
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = 'b1933493-c80b-4c2b-9b7a-53d0cff12e9a' 
	and activeflag = 1 ;
	
update gapsuspension
set startdate = '2023-10-26 04:00:00.000',
	enddate = '2023-10-26 04:00:00.000',
	updatedby = 'CDM-37360',
	updatedon = now()	
where gapsuspensionid  = 'b1933493-c80b-4c2b-9b7a-53d0cff12e9a' 
	and activeflag = 1 ;

select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspensionrevision 
where gapsuspensionrevisionid = '2cb6e98b-c5a6-4246-b6fe-b5d332fe0099' 
	and activeflag = 1;
	
update gapsuspensionrevision
set approvalstatustypekey = '3047', 
	approvaldate = now(),	
	updatedby = 'CDM-37360',
	updatedon = now()
where gapsuspensionrevisionid = '2cb6e98b-c5a6-4246-b6fe-b5d332fe0099' 
	and activeflag = 1;

