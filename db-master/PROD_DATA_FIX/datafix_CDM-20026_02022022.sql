-- CDM-20026 Submit for approval
/*
-- Issue Description: 
   To update the provider info and the Start date on 3 GAP cases

-- Case ID: 3214353
-- Client ID: 3386300 (QAMAR ALI-LAWSON	LILLY) - f40c3dc1-54a8-4c63-8b4f-16c5d3f5ee4a
-- GAP ID: 1005955 - Null To 2023-12-21 - 532d2895-b890-4269-a7ce-1cdc11f4b2d6
-- The last date it was finalized in court or the GAP start date is November 17, 2021

-- Provider ID: 5048305 (Joyce Taylor) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider Approval ID: 109046
-- 3610	Applicant - (529070) Joyce Taylor
-- 3611	Co-Applicant - (N/A) N/A

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '532d2895-b890-4269-a7ce-1cdc11f4b2d6' 
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Joyce Taylor',
	guardianoneid = 528311, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5048305,
	primaryrelationshipkey = 'GDNLGL',
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-20026',
	updatedon = now()
where gapid = '532d2895-b890-4269-a7ce-1cdc11f4b2d6'
	and activeflag = 1 ;
	
-- Update GAP Start Date as 12/02/2021 (old value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '532d2895-b890-4269-a7ce-1cdc11f4b2d6';
--	and activeflag = 1 

update gapagreement 
set startdate = '2021-11-17 00:00:00',
	updatedby = 'CDM-20026',
	updatedon = now()
where gapid = '532d2895-b890-4269-a7ce-1cdc11f4b2d6';
--	and activeflag = 1 

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '532d2895-b890-4269-a7ce-1cdc11f4b2d6'; 

update gapagreementrevision
set startdate = '2021-11-17 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20026',
	updatedon = now()
where gapid = '532d2895-b890-4269-a7ce-1cdc11f4b2d6'; 

select programkey, startdate, enddate, updatedby, updatedon 
	from personprogramarea
where personprogramid = '874185f3-35e2-419a-be43-7b427aa42d8b'
	and activeflag  = 1 ;

update personprogramarea
set startdate = '2021-11-17 04:00:00',
	updatedby = 'CDM-20026',
	updatedon = now()
where personprogramid = '874185f3-35e2-419a-be43-7b427aa42d8b'
	and activeflag  = 1 ;

