-- CDM-21002 - Incorrect provider information preventing opening GAP
/*
-- Issue Description: 
   Guardian's provider info and the Start dates is missing for GAP case.
   
-- Case ID: 3196523 - cornella.johnson@maryland.gov
-- Client ID: 1935568 (DAYONA HAYMAN) - 279ce730-2c2d-47e3-9d51-bd3bf61302a0
-- Provider ID: 6001613	(KASHI Lamarr WALKER) - Local Department Home
-- GAP ID: 1005926 - Null To 2022-09-08 - 05c16ba1-1729-41c9-a40e-45b06fe8b81e

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update Provider Info and GAP Start Date as 12/08/2021
-- Provider ID: 6001613	(KASHI Lamarr WALKER) - Local Department Home
-- Guardianship Home Approval ID: 103001
-- 3610	Applicant: 506666 KASHI WALKER
-- 3611	Co-Applicant: 506665 Mechelle Porter-Walker

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '05c16ba1-1729-41c9-a40e-45b06fe8b81e'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'KASHI WALKER',
	guardianoneid = 506666, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6001613,
	primaryrelationshipkey = 'CUSLG',
	guardiantwoname = 'Mechelle Porter-Walker',
	guardiantwoid = 506665, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 6001613,
	secondaryrelationshipkey = 'CUSLG',
	updatedby = 'CDM-21002',
	updatedon = now()
where gapid = '05c16ba1-1729-41c9-a40e-45b06fe8b81e'
	and activeflag = 1 ;

-- Update GAP Start Date as 2021-12-08 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '05c16ba1-1729-41c9-a40e-45b06fe8b81e'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-12-08 04:00:00',
	updatedby = 'CDM-21002',
	updatedon = now()
where gapid = '05c16ba1-1729-41c9-a40e-45b06fe8b81e'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '05c16ba1-1729-41c9-a40e-45b06fe8b81e' ;	

update gapagreementrevision
set startdate = '2021-12-08 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21002',
	updatedon = now()
where gapid = '05c16ba1-1729-41c9-a40e-45b06fe8b81e' ;	
