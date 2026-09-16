-- CDM-21270 - Wrong provider information in GAP
/*
-- Issue Description: 
   GAP is havign wrong Provider info, The correct Provider, Davina Carter #5082065 

-- Case ID: 3236291 - deborah.richard@maryland.gov
-- Client ID: 4026875 (BLESSING MURDOCK-VALENTINE) - 270d9e4a-58b1-4c71-b4f5-5d60b74c06d9
-- GAP ID: 1005985 - 2022-01-21 To 2034-11-05 - 1efac70f-61ec-4540-9a72-a4142498ea6c
-- Provider ID: 5082065 (Davina Carter) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: 5082065 (Davina Carter) - Local Department Home
-- 3610	Applicant - (529180) Davina Carter
-- 3611	Co-Applicant - None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '1efac70f-61ec-4540-9a72-a4142498ea6c'	 
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Davina Carter',
	guardianoneid = 529180, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5082065,
	-- primaryrelationshipkey = ??, -- NULL
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21270',
	updatedon = now()
where gapid = '1efac70f-61ec-4540-9a72-a4142498ea6c'	 	 
	and activeflag = 1 ;

-- Update End date for the Voided Placement perventing GAP setup
select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = '6f06ab17-b3b3-40da-88f3-7af8ac1063ca'
	and activeflag = 1 ;
	
update placement 
set enddatetime = startdatetime,
	updatedby = 'CDM-21270',
	updatedon = now()
where placementid = '6f06ab17-b3b3-40da-88f3-7af8ac1063ca'
	and activeflag = 1 ;

