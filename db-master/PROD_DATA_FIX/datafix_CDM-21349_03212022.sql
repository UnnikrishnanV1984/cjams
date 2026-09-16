-- CDM-21349 - Gap Info Saving
/*
-- Issue Description: 
   Guardian's provider info is missing for GAP case.
   
-- Case ID: 3220151
-- Client ID: 3146638 (SHANE HEINE) - 5c9df557-3b5b-4af9-aa5a-b8886a4ae81f
-- GAP ID: 1005993 - 2022-02-01 To 2028-01-14 - f887f3b8-e29c-4345-bfd4-6ae9b79b9693
-- Provider ID: 6003992 (ELOISE TANGAE RAY) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update Provider Info
-- Provider ID: 6003992 (ELOISE TANGAE RAY) - Local Department Home
-- 4990	Guardianship Home Approval: provider_approval_id 109484
-- 3610 - 530535 ELOISE RAY
-- 3611 - None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'f887f3b8-e29c-4345-bfd4-6ae9b79b9693'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'ELOISE RAY',
	guardianoneid = 530535, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6003992,
	-- primaryrelationshipkey = 'GDNLGL',
	-- guardiantwoname = NULL, 
	-- guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21349',
	updatedon = now()
where gapid = 'f887f3b8-e29c-4345-bfd4-6ae9b79b9693'
	and activeflag = 1 ;
