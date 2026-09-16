-- CDM-37746 -- Overpayment error
/*
-- Issue Description: 
   An overpayment report (FM210R report) showed up for William Boggs, provider# 6005837 for Simon Boggs, 
   but there is no overpayment balance under his accts.
   
-- Case ID: 3172187 
-- Client ID: 2574032 (SIMON PAUL BOGGS) - 8dcfb34d-5169-4fa4-9f3f-8b56590fa1dc
-- Adoption ID: 20605 - 2009-04-01 To 2024-11-17 - 20c87335-f552-492d-8496-d0386cc5167f
-- Current Provider ID: 5020983	(Jessica Anne Freeman)
-- Prior Provider ID: 6005837 (WIlliam Howard Boggs)

-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: The Current  Adoptive parent on this subsidy is Provider # 5020983	(Jessica Anne Freeman)
--             This Adoption was having Provider # 6005837 as adoptive parent from April 2022 to Nov 2023.
--			   On 12/12/2023 suspension was created on this adoption for 11/30/2023 to 12/01/2023
--             Issue: System has created the AR  correctly but linked to current provider (AR data issue). 
-- Fix Provided: DataFix has been promoted to move the AR for correct provider # 6005837
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Proider ID in Receivable table (CDM-37746)

select receivable_id, provider_id, balance_no, update_user_id, update_ts  
	from tb_receivable_header 
where receivable_id = 1251398
	and delete_sw = 'N';

update tb_receivable_header
set provider_id = 6005837, -- old 5020983
	update_ts = now(), -- 2023-12-12 19:19:38.718
	update_user_id = 'CDM-37746' -- finance
where receivable_id = 1251398
	and provider_id = 5020983 
	and delete_sw = 'N'	;