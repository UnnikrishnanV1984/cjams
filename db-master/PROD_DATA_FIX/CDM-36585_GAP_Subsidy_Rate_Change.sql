-- CDM-36585 - Incorrect subsidy rate
/*
-- Issue Description: 
   User Request to change GAP subsidy rate 
   Provider, Mary Floyd-5057863, has been paid incorrect amount of $850.00 from 06/05/22-06/04/24. 
   Correct rate for should be $950.
   
-- Case ID: 3183334
-- Client ID: 2914264 (DAJUAN FLOYD) - 5300f160-cdcf-43de-afc2-35cc87fa820d
-- GAP ID: 2848 - 2013-06-06 To 2028-01-23 - a3241946-2618-4d88-947c-80f386b4cae9
-- Providre ID: 5057863	(Mary Floyd)

-- Rate Fix to $950.00 (old value is $850.00)
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the GAP rate as $950.00
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rates
/*
96ddce44-2c4f-4b4c-be68-f3a6f030b28c	2022-06-05	2023-06-04	850
2bdfb626-626c-46c5-bd99-3d9c8a840eca	2023-06-05	2024-06-04	850
*/
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid 
		in ('96ddce44-2c4f-4b4c-be68-f3a6f030b28c',
			'2bdfb626-626c-46c5-bd99-3d9c8a840eca'
			)
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 950.00,
	updatedby = 'CDM-36585',
	updatedon = now()
where gapagreementrateid 
		in ('96ddce44-2c4f-4b4c-be68-f3a6f030b28c',
			'2bdfb626-626c-46c5-bd99-3d9c8a840eca'
			)
	and activeflag = 1 ;


-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid in ('96ddce44-2c4f-4b4c-be68-f3a6f030b28c',
					'2bdfb626-626c-46c5-bd99-3d9c8a840eca'
					) ;

update gapratesrevision 
set paymentamt = 950.00,
	approvaldate = now(),
	updatedby = 'CDM-36585',
	updatedon = now()
where gaprateid in ('96ddce44-2c4f-4b4c-be68-f3a6f030b28c',
					'2bdfb626-626c-46c5-bd99-3d9c8a840eca'
					) ;