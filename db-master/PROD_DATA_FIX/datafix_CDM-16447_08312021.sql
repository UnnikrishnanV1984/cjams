-- CDM-16447 - GAP Successor
/*
-- Issue Description: 
   To change the provider on this GAP case as a Successor Guardian
   
-- Case ID: 3242556
-- Client ID: 3364756 (KALEY ANN CRONIN) - d0900932-918a-4ab4-956a-5dc04ec68b90
-- GAP ID: 5273 - 2019-06-20 To 2026-03-04 - 740fa99f-ead6-4475-a0a0-5a8312ffcfa8
-- Current Provider ID: 5091554	(Tina Bish)
-- Successor Guardian Provider ID: 5089362 (Tammy Welsh)


-- Category/ Module: GAP (Case Management) 
-- Root cause: Provider change functionlaity is currently not available in CJAMS. 
--			   We have a User Story in our backlog.	
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update GAP Info
select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey,
	updatedby, updatedon
from guardianship 
where gapid = '740fa99f-ead6-4475-a0a0-5a8312ffcfa8'
and activeflag = 1 ;

update guardianship 
set guardianonename = 'Tammy Welsh',
	guardianoneid = 523261, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5089362,
	primaryrelationshipkey = 'guardian',
	guardiantwoname = 'John Welsh',
	guardiantwoid = 523263, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = 5089362,
	secondaryrelationshipkey = 'HSBND',
	updatedby = 'CDM-16447',
	updatedon = now()
where gapid = '740fa99f-ead6-4475-a0a0-5a8312ffcfa8'
and activeflag = 1 ;


