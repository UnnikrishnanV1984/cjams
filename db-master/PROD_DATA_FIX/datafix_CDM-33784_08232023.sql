-- CDM-33784 - Non payment after change to co-applicant
/*
-- Issue Description: 
	 Adoption subsidy rate slab has approved for new provider, but payment did not generated  
   
-- Case ID: 3270838
-- client ID: 4005911 (CALEB JOSHUA	CREECH) - 44da13b9-f19c-43eb-86d2-6fb84d419393
-- Adoption ID: 46642 - 2016-09-30 To 2025-03-14 - 5d9f8521-971d-4fc9-9576-c57b814f5ca9
-- Provider ID: 6038500	(Calvin S Anderson) 
-- Rate ID: bcfc4c14-d6d6-415b-9578-ddb81d3e18a8 - 2022-10-01 To 2023-09-29
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Unknown at this time (TBD)
-- The Rate was approved on 05/12/2023, but payment was generated on that day, all data looks good now. And there is no refence of any prior fix on this Adoption case.  
-- Fix Provided: Datafix has been promoted to trigger Under/Over batch to generate the missing Oct 2022 to April 2023 payments.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under Over batch (CDM-33784)
select provider_id, startdate, enddate, paymentamout, status, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = 'bcfc4c14-d6d6-415b-9578-ddb81d3e18a8'
  and activeflag = 1 ;

update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-33784'
where adoptionagreementrateid = 'bcfc4c14-d6d6-415b-9578-ddb81d3e18a8'
  and activeflag = 1 ;
  