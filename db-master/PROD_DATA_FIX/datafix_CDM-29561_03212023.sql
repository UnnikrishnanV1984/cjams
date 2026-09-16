-- CDM-29561 - Payment
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case and generate the missign payments

-- Case ID: 221040019231
-- Client ID: 200971185 (ADONIS	Noah Webb Hudson) - f6102c9f-2031-4acb-b167-7a73f580529c
-- Adoption ID: 1051656 - 2022-10-19 To 2036-07-10 - 5de9382a-5d9a-4010-8f7f-5542e62b9d3c
-- Provider ID: 5092836	(Madeline Ellis) 
-- adoptionagreementid: 919075ba-c998-407a-8ef5-cfea60de404d
-- adoptionagreementrateid: 9caddba0-026c-4920-a857-1d7d640a2d4d

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: TBD, Adoption Agreement Rate was Approved on 02/10/2023, but no suytem adjustments created. 
-- Fix Providerd: 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Trigger Under/Over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '919075ba-c998-407a-8ef5-cfea60de404d'
 	and adoptionagreementrateid = '9caddba0-026c-4920-a857-1d7d640a2d4d'
	and approvaldate is not null
	and activeflag = 1 ;

update adoptioncaserevision
set approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29561'
where adoptionagreementid = '919075ba-c998-407a-8ef5-cfea60de404d'
 	and adoptionagreementrateid = '9caddba0-026c-4920-a857-1d7d640a2d4d'
	and approvaldate is not null
	and activeflag = 1 ;

