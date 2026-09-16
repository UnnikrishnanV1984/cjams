-- CDM-30154 - Incorrect subsidy rate
/*
-- Issue Description: 
   User Request to change GAP subsidy rate 
   Provider, Robin Perry-5095279, has been paid incorrect diem of $1042 ($34.26) from 01/05/21-02/28/23. 
   Correct diem for should be $1024 ($33.66).
   
-- Case ID: 3146683
-- Client ID: 1788396 (ALEATHIA	L CONNER) - ebd9afcc-69b0-4425-a4e8-e85cd562201a
-- GAP ID: 1005654 - 2021-01-05 To 2026-03-21 - 0af83a14-0496-4696-ac17-789c9fd353c3
-- Providre ID: 5095279	(Robin Perry)

-- Rate Fix to $1024.00 (old value is $1042.00)
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the GAP rate as $1024.00
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rates
/*
1164da7f-fc53-4b75-ba03-15f8bc26f55a	2021-01-05	2022-01-04	1042
7433d9a0-92d2-468e-b837-0b4b6b8c72ea	2022-01-05	2023-01-04	902		-- Rejected
8305941d-a954-4360-ac9e-f8e92006713b	2022-01-05	2023-01-04	1042
48026946-a6f5-4d6c-a831-749d3415f16a	2023-01-05	2024-01-04	1042
*/
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid 
		in ('48026946-a6f5-4d6c-a831-749d3415f16a',
			'8305941d-a954-4360-ac9e-f8e92006713b',
			'1164da7f-fc53-4b75-ba03-15f8bc26f55a'
			)
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 1024.00,
	updatedby = 'CDM-30154',
	updatedon = now()
where gapagreementrateid 
		in ('48026946-a6f5-4d6c-a831-749d3415f16a',
			'8305941d-a954-4360-ac9e-f8e92006713b',
			'1164da7f-fc53-4b75-ba03-15f8bc26f55a'
			)
	and activeflag = 1 ;


-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid in ('48026946-a6f5-4d6c-a831-749d3415f16a',
					'8305941d-a954-4360-ac9e-f8e92006713b',
					'1164da7f-fc53-4b75-ba03-15f8bc26f55a'
					) ;

update gapratesrevision 
set paymentamt = 1024.00,
	approvaldate = now(),
	updatedby = 'CDM-30154',
	updatedon = now()
where gaprateid in ('48026946-a6f5-4d6c-a831-749d3415f16a',
					'8305941d-a954-4360-ac9e-f8e92006713b',
					'1164da7f-fc53-4b75-ba03-15f8bc26f55a'
					) ;

