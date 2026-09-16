-- CDM-21078 - Unable to break the link: screenshot included
/*
-- Issue Description: 
   User request to update the placement structure as Pre-Finalized Adoptive Home
   
-- Case ID: 3305304
-- Client ID: 4411440 (OLIVIA ROSE MANKEY) - f0d788a7-8419-40ec-8a53-e338cef41cb6
-- Placement ID: 1570275 - 2022-02-18 To 2022-02-18 - 936a0b0a-0186-4d59-8e8b-747ddee6ba1a
-- Provider ID: 5093482	(Ashley Evans Candy) 
-- New Placement Structure: 500 - Pre-Finalized Adoptive Home
-- Current Placement Structure: 10 - Regular Foster Care

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User Error, incorrect structure was selected and the removal is now closed 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Placement Structure
select alternateid, altproviderid, service_id, ratestructureid, activeflag, updatedby, updatedon 
	from placement 
where placementid = '936a0b0a-0186-4d59-8e8b-747ddee6ba1a'
	and activeflag = 1 ; 

update placement 
set service_id = 500, -- Pre-Finalized Adoptive Home
	updatedby = 'CDM-21078',
	updatedon = now()
where placementid = '936a0b0a-0186-4d59-8e8b-747ddee6ba1a'
	and activeflag = 1 ;
