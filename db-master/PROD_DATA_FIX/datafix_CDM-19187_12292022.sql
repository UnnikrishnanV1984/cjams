-- CDM-19187 - Generation of Payments
/*
-- Issue Description: 
	The provider name was changed and corrected however the payments are not generating. 
	Please review to repair. Thank You

-- Case ID: 3124185
-- Client ID: 1645157 (LACHELLE	STEWART) - 4496d46a-0227-497f-b18f-d3ca23ded580
-- GAP ID: 1306 - 2010-07-26 To 2023-09-01 - 5ccf8626-cd96-4a91-8bd4-9ec67533fa4b
-- Provider ID: 5012560	(Brenda Diaby)

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module side Data Issue.
-- Fix Provided: Data fix has been promoted to fix the provider name discrepancy.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5012560 (Brenda Diaby) - Local Department Home
-- Old Name: Brenda Stewart

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5012560
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-19187'
where provider_id = 5012560
	and delete_sw  = 'N' ;
	

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '5ccf8626-cd96-4a91-8bd4-9ec67533fa4b'
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Brenda Diaby',
	-- guardianoneid = 120356, -- (approval_person_id -> tb_prov_approval_person )
	-- guardianoneproviderid = 5012560,
	-- primaryrelationshipkey = NULL, -- MATNLUE
	-- guardiantwoname = NULL,
	-- guardiantwoid = 120358, -- (approval_person_id -> tb_prov_approval_person )
	-- guardiantwoproviderid = NULL,
	-- secondaryrelationshipkey = NULL,
	updatedby = 'CDM-19187',
	updatedon = now()
where gapid = '5ccf8626-cd96-4a91-8bd4-9ec67533fa4b'
	and activeflag = 1 ;	
