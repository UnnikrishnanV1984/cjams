-- CDM-20096 - Payment not interfacing
/*
-- Issue Description: 
   Subsidy rate has been entered, but payment is not interfacing.
   
-- Case ID: 3174577
-- Client ID: 1153180 (JAMESE PRESTON CAMPBELL) - 4209e640-b0e2-4c35-b793-ed6e2a5d4377
-- GAP ID: 3457 - 2014-06-17 To 2021-10-27 - c5076b23-3bc7-41cb-830d-03b5717b2fdf
-- Provider ID: 5070608	(Faye Johnson)

-- Category/ Module: GAP (Case Management) 
-- Root cause: Data migration issue.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- To nullify Guardian Two details
select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'c5076b23-3bc7-41cb-830d-03b5717b2fdf'
	and activeflag = 1 ;

update guardianship 
set guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-20096',
	updatedon = now()
where gapid = 'c5076b23-3bc7-41cb-830d-03b5717b2fdf'
	and activeflag = 1 ;
