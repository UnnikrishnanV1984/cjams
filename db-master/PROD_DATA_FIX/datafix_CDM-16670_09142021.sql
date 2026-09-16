-- CDM-16670 - Payment code correction
/*
-- Issue Description: 
   Adoption Payments with incorrect Fiscal Category Codes 
    
-- Case ID: 2020023902644
-- Client ID: 200145317 (Cecelia Elizabeth Mcdermott) - 9cd3656f-5da9-44ab-805b-0d0ee622d885
-- Adoption ID: 1050988 - 2020-08-24 To 2034-01-03 - d4fe5a31-4d21-4355-9017-70f7ce9a3db6
-- Provider ID: 5087009 (Patricia  Mcdermott) 

	
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Finance is not able to read the Eligibility Status as Start Date is missing 
--			   in the IV-E table. Code fix will be part of CDM-15927
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Payment Correction for Adoption ID: 1050988
/*
-- Payments 
Detl ID	Pay ID	Pay Date	Start Date	End Date	Amout	Code
----------------------------------------------------------------
4241728	3080657	2021-09-01	2021-08-24	2021-08-31	157.84	7181 
4241729	3080657	2021-09-01	2021-08-01	2021-08-23	453.79	7181 
4224681	3068104	2021-08-01	2021-07-01	2021-07-31	611.63	7181 
4207500	3055364	2021-07-01	2021-06-01	2021-06-30	591.90	7181 
*/

-- 2181 & 7181 - Adoption Subsidy
select payment_detail_id, final_service_start_dt, final_service_end_dt,
	final_fiscal_category_cd, subsidy_agreement_id, client_id, update_ts, update_user_id 
from tb_payment_detail 
where payment_detail_id in (4241728, 4241729, 4224681, 4207500)
	and delete_sw = 'N' ;


update tb_payment_detail
set final_fiscal_category_cd = '2181',
	update_ts = now(),
	update_user_id = 'CDM-16670'
where payment_detail_id in (4241728, 4241729, 4224681, 4207500)
	and delete_sw = 'N' ;
	

-- Generic Datafix for all Adoption Cases
-- Before 
select ce.eligibility_id, ce.adoption_id, ce.start_dt, ce.end_dt, ce.update_ts, ce.update_user_id
	,( select ta.subsidy_start_dt::date  
			from tb_adoption ta 
		where ta.adoption_id = ce.adoption_id 
		and ta.delete_sw = 'N'
	  ) as subsidy_start_dt	
from tb_client_eligibility ce
where delete_sw = 'N'
	and btrim(eligibility_type_cd) = '2934'
	and adoption_id is not null
	and create_user_id not in ('convertw')	
	and start_dt is null ;
	
-- Update
update tb_client_eligibility ce
	set ce.start_dt	= 
			( select ta.subsidy_start_dt::date  
				from tb_adoption ta 
			  where ta.adoption_id = ce.adoption_id 
				and ta.delete_sw = 'N'
			),
		ce.update_ts = now(),
		ce.update_user_id = 'CDM-16670'
where delete_sw = 'N'
	and btrim(eligibility_type_cd) = '2934'
	and adoption_id is not null
	and create_user_id not in ('convertw')	
	and start_dt is null ;
	
-- After 
select ce.eligibility_id, ce.adoption_id, ce.start_dt, ce.end_dt, ce.update_ts, ce.update_user_id
	,( select ta.subsidy_start_dt::date  
			from tb_adoption ta 
		where ta.adoption_id = ce.adoption_id 
		and ta.delete_sw = 'N'
	  ) as subsidy_start_dt	
from tb_client_eligibility ce
where delete_sw = 'N'
	and btrim(eligibility_type_cd) = '2934'
	and	ce.update_user_id = 'CDM-16670' ;