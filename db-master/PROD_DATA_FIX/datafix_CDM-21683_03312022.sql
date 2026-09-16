-- CDM-21683 - GAP issue
/*
-- Issue Description: 
   The provider number does not show up on the GAP case.
   
-- Case ID: 3267776
-- Client ID: 4282204 (Erika S Takacs) - 19282f97-9746-4f0a-b9b0-aad455ca0efe
-- Provider ID: 6001942 (DEBRA CHANEY) - Local Department Home
-- GAP ID: 1005967 - 2022-01-31 To 2036-09-14 - 91f9cce4-aa06-43e9-a15e-c6a6c8db7bd1

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 6001942 (DEBRA CHANEY) - Local Department Home
-- Guardianship Home Approval ID: 109498
-- 3610	Applicant: (530569) DEBRA CHANEY
-- 3611	Co-Applicant: (530568) JOSEPH CHANEY

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '91f9cce4-aa06-43e9-a15e-c6a6c8db7bd1'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'DEBRA CHANEY',
	guardianoneid = 530569, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6001942,
	primaryrelationshipkey = 'MTNLAT',
	-- guardiantwoname = 'JOSEPH CHANEY',
	guardiantwoid = 530568, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 6001942,
	secondaryrelationshipkey = 'MATNLUE',
	updatedby = 'CDM-21683',
	updatedon = now()
where gapid = '91f9cce4-aa06-43e9-a15e-c6a6c8db7bd1'
	and activeflag = 1 ;

