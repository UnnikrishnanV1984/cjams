-- CDM-19405 - PROVIDER SPOUSE DECEASED
/*
-- Issue Description: 
   To change the provider on this GAP cases as a Successor Guardian

-- Case ID: 3250041 - mavis.asare-dwamenah@maryland.gov
-- Successor Provider ID: 6005182 (EDSON FULLENWILDER)
-- Old Provider ID: 5076369	(Brenda Fullenwilder)

-- GAP ID: 4351 - 2016-09-26 To 2032-01-24 -  466bc742-40b0-478b-b38d-c3c70d472b72
-- Client ID: 3757714 (SENDAL S	FORD) - 256f23df-2dd4-4f0f-a83c-21f3229b0fa2

-- GAP ID: 4352 - 2016-09-26 To 2034-01-04 - c7b8fcbc-abfa-4c8f-b36a-a252f0aec753
-- Client ID: 3757715 (SYRA	S FORD) - 17ae1bc1-fa07-4c06-bcaa-3462007c2d2a

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Successor Provider ID: 6005182 (EDSON FULLENWILDER) - Local Department Home
-- 3610	Applicant - (528840) EDSON FULLENWILDER
-- 3611	Co-Applicant - None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in ( '466bc742-40b0-478b-b38d-c3c70d472b72',
				 'c7b8fcbc-abfa-4c8f-b36a-a252f0aec753'
			    )	 
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'EDSON FULLENWILDER',
	guardianoneid = 528840, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6005182,
	-- primaryrelationshipkey = ??, -- 'DACRCHLD'
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-19405',
	updatedon = now()
where gapid in ( '466bc742-40b0-478b-b38d-c3c70d472b72',
				 'c7b8fcbc-abfa-4c8f-b36a-a252f0aec753'
			    )	 
	and activeflag = 1 ;

	