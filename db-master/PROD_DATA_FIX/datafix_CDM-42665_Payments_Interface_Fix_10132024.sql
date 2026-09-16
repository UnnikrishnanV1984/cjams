-- CDM-42665 - Payments Didn't Interface to D365
/*
-- Issue Description: 
   Provider 6103436 never received system adjustment payments. Provider payments doesn't have a worker 
   or local department listed. The case belongs to Baltimore City and a worker was assigned, but the isseue remains. 

-- Adoption Case ID: 231040234110 - tiffany.stancil@maryland.gov
-- Client ID: 202304872	(Veranika Miller) - 9d8b6d66-5061-4cab-a9d5-b5bb5c0727b8
-- Adoption ID: 1068500 -  2020-05-18 To 2037-04-01 - 707ff7d9-d8e3-420a-8738-30f991c1a979
-- Provider ID: 6103436	(RYAN MILLER) - Local Department Home
-- 1429	Baltimore City

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Payments generated without populating the County code in the tb_payment_detail table. 
--			   Adoption case was not having any Family case assignment until 11/01/2024
-- Fix Provided: Datafix has been promoted to update the County code in the tb_payment_detail table. 
-- Pull request# N/A 
-- Is Code fix Required?: TDB, any open case must have an active Family case assignment.
--	Code fix ticket#: N/A
--	Reason why no related code fix: N/A
--  Regression Impacts: N/A
*/

-- To update the county code in tb_payment_detail table (CDM-42665) 
update tb_payment_detail 
set county_cd = '1429', -- Baltimore City
	update_user_id  = 'CDM-42665',
	update_ts = now()
where subsidy_agreement_id = 1068500
	and delete_sw = 'N'
	and county_cd is null ;

