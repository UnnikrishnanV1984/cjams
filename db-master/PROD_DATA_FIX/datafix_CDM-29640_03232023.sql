-- CDM-29640 - Adoptions Subsidy Payments
/*
-- Issue Description: 
   The case was updated on 2/10/2. Finance did not receive notification of the update. 
   As a result, payment has been delayed. 

-- Case ID: 3184443
-- Client ID: 2965919 (KYLE	AIDAN POWELL) - 1ed0ad2e-35d4-4170-87fd-a8d1b940065b
-- Adoption ID: 24901 - 2010-03-10 To 2024-02-24 - 666f13e3-6bce-40d5-b5c7-150f526358af
-- Provider ID: 5037756	(Trina Powell)
-- adoptionagreementid: 9a2cd9b9-d1a6-4f5e-aad9-d764c405af0a
-- adoptionagreementrateid: 98ae1bb1-5efa-4a90-a7d9-f0f8ed4dc07c


-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Adoption Agreement Rate was Approved on 02/10/2023, but no suytem adjustments created. 
--			   Adoption under over SP errored out for some data issue, we have verified only 2 caes are impacted.
			   One case was fixed with CDM-29561. 	
-- Fix Providerd: Datafix has been provided to Trigger Under/Over job for this Adoption case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Trigger Under/Over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '9a2cd9b9-d1a6-4f5e-aad9-d764c405af0a'
 	and adoptionagreementrateid = '98ae1bb1-5efa-4a90-a7d9-f0f8ed4dc07c'
	and approvaldate is not null
	and activeflag = 1 ;

update adoptioncaserevision
set approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29640'
where adoptionagreementid = '9a2cd9b9-d1a6-4f5e-aad9-d764c405af0a'
 	and adoptionagreementrateid = '98ae1bb1-5efa-4a90-a7d9-f0f8ed4dc07c'
	and approvaldate is not null
	and activeflag = 1 ;

