-- CDM-22761 - Provider ID missing
/*
-- Issue Description: 
   Provider ID missing from GAP case. Payment did not generate.

-- Case ID: 3307348 - stacey.weimer@maryland.gov
-- Client ID: 4486700 (CAMBREE L BROWER) - 940b51ea-9211-40fb-9809-1e8ceca534f0
-- Provider ID: 6003192	(MONACA F HEDRICK) - Local Department Home
-- GAP ID: 1006002 - 2022-03-22 To 2025-06-08 - f2043268-61b9-4a0e-9783-3ffa7d77db81
-- gapagreementid: 5db0324f-a1db-4173-8999-7ea903873af9
-- gapagreementrateid: b9e5898d-32b3-41e4-80bb-0fb5af0c575f

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6003192	(MONACA F HEDRICK) - Local Department Home
-- Kinship Home Approval: 106810956546
-- 3610	Applicant: (530794) MONACA HEDRICK
-- 3611	Co-Applicant: (530795) VERNON HEDRICK

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'f2043268-61b9-4a0e-9783-3ffa7d77db81'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'MONACA HEDRICK',
	guardianoneid = 530794, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6003192,
	-- primaryrelationshipkey = NULL,
	-- guardiantwoname = 'VERNON HEDRICK',
	guardiantwoid = 530795, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 6003192,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-22761',
	updatedon = now()
where gapid = 'f2043268-61b9-4a0e-9783-3ffa7d77db81'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = '5db0324f-a1db-4173-8999-7ea903873af9' ;

update gapagreementrate
set provider_id = 6003192,
	updatedby = 'CDM-22761',
	updatedon = now()
where gapagreementid = '5db0324f-a1db-4173-8999-7ea903873af9' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = 'f2043268-61b9-4a0e-9783-3ffa7d77db81' ;

update gapratesrevision
set providerid = 6003192,
	approvaldate = now(),
	updatedby = 'CDM-22761',
	updatedon = now()
where guardiansubsidyid = 'f2043268-61b9-4a0e-9783-3ffa7d77db81' ;

-- No On HOLD Payment(s) with NULL provider ID
