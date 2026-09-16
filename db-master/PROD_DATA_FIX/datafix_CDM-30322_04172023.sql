-- CDM-30322 - Adoption Date Timestamp Error
/*
-- Issue Description: 
   Data issue, Adoption Finalization date before client's date of birth

-- Case ID: 3199181
-- Client ID: 3585755 (Aden	B Silva) - 0aa045d4-ab11-42bf-88c6-304906708049
-- Client ID: 3775155 (Rachel Silva) - 40e6018e-cae2-4e94-a764-4caaa584b080
 	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data issue, Adoption Finalization date before client's date of birth.
-- Fix Provided: Datafix has been promoted to update finalization Date as 01/19/2023
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update finalization Date as 01/19/2023 (old value 2013-09-12 00:00:00)
-- Client ID: 3585755 (Aden	B Silva) - 0aa045d4-ab11-42bf-88c6-304906708049
select adoptionbreakthelinkid, finalizationdate, updatedby, updatedon
	from adoptionbreakthelink
where adoptionbreakthelinkid  = 'b910850b-ff2f-4d9a-91a8-eae52e9a594b'
	and activeflag = 1 ;

update adoptionbreakthelink
set finalizationdate = '2023-01-19 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-30322'
where adoptionbreakthelinkid  = 'b910850b-ff2f-4d9a-91a8-eae52e9a594b'
	and activeflag = 1 ;


-- Client ID: 3775155 (Rachel Silva) - 40e6018e-cae2-4e94-a764-4caaa584b080
select adoptionbreakthelinkid, finalizationdate, updatedby, updatedon
	from adoptionbreakthelink
where adoptionbreakthelinkid  = 'ad6f1027-5ebf-4a76-8982-e22b40582532'
	and activeflag = 1 ;

update adoptionbreakthelink
set finalizationdate = '2023-01-19 00:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-30322'
where adoptionbreakthelinkid  = 'ad6f1027-5ebf-4a76-8982-e22b40582532'
	and activeflag = 1 ;
