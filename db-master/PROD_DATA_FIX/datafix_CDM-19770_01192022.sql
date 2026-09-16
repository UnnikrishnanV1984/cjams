-- CDM-19770 - GAP Application
/*
-- Issue Description: 
   To change the provider on this GAP case as a Successor Guardian
   
-- Case ID: 3149765
-- Client ID: 1794282 (BRANDON D JAMES) - 8c8c8933-9012-469b-88d5-6df22e420e9a  
-- GAP ID: 1129 - 2009-11-03 To 2025-02-08 - 77c9f20f-9219-486f-8c24-d09cec8edd70
-- Successor Provider ID: 6005100 (Kimberly Morris) - Local Department Home
-- Old Provider ID: 5042120 (Patricia Morris) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Successor Provider ID: 6005100 (Kimberly Morris) - Local Department Home
-- 3610	Applicant - 528535 Kimberly Morris
-- 3611	Co-Applicant - None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '77c9f20f-9219-486f-8c24-d09cec8edd70'
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Kimberly Morris',
	guardianoneid = 528535, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6005100,
	-- primaryrelationshipkey = ??, -- 'DACRCHLD'
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-19770',
	updatedon = now()
where gapid = '77c9f20f-9219-486f-8c24-d09cec8edd70'
	and activeflag = 1 ;
