-- CDM-34486 - A. ANCELL AND C.WEBER
/*
-- Issue Description: 
   To fix the GAP case data (Provider switch)  

-- Case ID: 3260057
-- New Provider ID: 6062329	(JOHN SHIPE) 
-- Old Provider ID: 5085937 (Gloria Shipe) 
-- Client ID: 4051820 (CASTIELLE MICHAEL WEBER) - 215b8e9b-e485-454e-bc50-912b58577441
-- GAP ID: 5393 - 2019-12-16 To 2034-12-29 - 45afeedb-b8fe-415a-901d-37e6f62ff52b

-- Category/ Module: GAP (Case Management) 
-- Root cause: Application code flaw, CIDM ticket was created ot fix the issue.
-- Fix provided: Datafix has been promoted to fix the GAP data, Old Provider ID and End date of the most recent GAP rate. GAP Agreement info was also reverted to reflect Old Provider ID.
-- After this data fix deployment, please ask the user to wait for one day to verify the system adjustment payment for the Old Provider ID 5085937 (Gloria Shipe) for June 2023 services (up to 06/25/2023).
-- And then only switch the GAP to New Provider 6062329 (JOHN SHIPE) and create new rate starting 06/26/2023.

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- To fix the GAP case data (CDM-34486) 
select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '45afeedb-b8fe-415a-901d-37e6f62ff52b'
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Gloria Shipe', -- 'JOHN SHIPE'
	guardianoneid = 306779, -- 583422 (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5085937, -- 6062329
	-- primaryrelationshipkey = 'DACRCHLD',
	guardiantwoname = 'John	Shipe', -- NULL
	guardiantwoid = 306782, -- NULL (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 5085937, -- NULL
	-- secondaryrelationshipkey = 'HSBND', 
	updatedby = 'CDM-34486', -- 65184bef-4775-4122-9bf0-45e2761b9292
	updatedon = now() -- 2023-08-04 10:31:49
where gapid = '45afeedb-b8fe-415a-901d-37e6f62ff52b'
	and activeflag = 1 ;
	
-- To fix GAP Rate slabs
-- Update End Date as 2023-06-25 04:00:00
-- 5085937	2023-03-01 15:00:00	2024-02-29 15:00:00		b35e3b0a-b3cf-4554-b15e-5873f1c428ef
select provider_id, startdate, enddate, paymentamout, gapagreementrateid, activeflag, updatedby, updatedon 
	from gapagreementrate
where gapagreementrateid = 'b35e3b0a-b3cf-4554-b15e-5873f1c428ef'
	and activeflag = 0 ;
	
update gapagreementrate
set enddate = '2023-06-25 04:00:00',
	activeflag = 1,
	updatedby = 'CDM-34486', 
	updatedon = now() 	
where gapagreementrateid = 'b35e3b0a-b3cf-4554-b15e-5873f1c428ef'
	and activeflag = 0 ;

select providerid, ratestartdate, rateenddate, approvalstatustypekey, approvaldate, paymentamt, 
	activeflag, updatedby, updatedon
from gapratesrevision  
where gaprateid = 'b35e3b0a-b3cf-4554-b15e-5873f1c428ef'
	and activeflag = 1 ;	

update gapratesrevision
set rateenddate = '2023-06-25 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-34486', 
	updatedon = now() 	
where gaprateid = 'b35e3b0a-b3cf-4554-b15e-5873f1c428ef'
	and activeflag = 1 ;	
	
-- Delete rate ID: 90febbd3-0e6a-4743-ba7b-8f2a15a74883
select provider_id, startdate, enddate, paymentamout, gapagreementrateid, activeflag, updatedby, updatedon 
	from gapagreementrate
where gapagreementrateid = '90febbd3-0e6a-4743-ba7b-8f2a15a74883'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-34486', 
	updatedon = now() 
where gapagreementrateid = '90febbd3-0e6a-4743-ba7b-8f2a15a74883'
	and activeflag = 1 ;

select providerid, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon
	from gapratesrevision  
where gaprateid = '90febbd3-0e6a-4743-ba7b-8f2a15a74883'
	and activeflag = 1 ;
	
update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-34486', 
	updatedon = now() 
where gaprateid = '90febbd3-0e6a-4743-ba7b-8f2a15a74883'
	and activeflag = 1 ;

select routingid, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon
	from routing
where objectid = '90febbd3-0e6a-4743-ba7b-8f2a15a74883'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-34486', 
	updatedon = now() 
where objectid = '90febbd3-0e6a-4743-ba7b-8f2a15a74883'
	and eventcode = 'GARR'
	and activeflag = 1 ;

