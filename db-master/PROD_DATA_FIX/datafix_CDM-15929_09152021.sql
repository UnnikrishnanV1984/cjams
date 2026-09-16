-- CDM-15929 - Need payment correction
/*
-- Issue Description: 
   Adoption Payments with incorrect Fiscal Category Codes 
    
-- Case ID: 2020024002670
-- Client ID: 200145656	(Madilynn Jane Brown) - 426d4531-3529-4c79-8e8a-8a481bc98db4
-- Adoption ID: 1050993 - 2020-08-24 To 2030-11-06 - 9a30426d-f4f9-4eb5-afc1-3b77d69a9791
-- Provider ID: 5081104 (Christine Lynn Queen Brown) 
	
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Finance is not able to read the Eligibility Status as Start Date is missing 
--			   in the IV-E table. Code fix will be part of CDM-15927
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Payment Correction for Adoption ID: 1050993
/*
-- Payments 
Detl ID	Pay ID	Pay Date	Start Date	End Date	Amout	Code
----------------------------------------------------------------
4241422	3080432	2021-09-01	2021-08-24	2021-08-31	237.52	7181 
4241423	3080432	2021-09-01	2021-08-01	2021-08-23	682.87	7181 
4224374	3067880	2021-08-01	2021-07-01	2021-07-31	920.39	7181 
4207197	3055139	2021-07-01	2021-06-01	2021-06-30	890.70	7181 
*/


-- 2181 & 7181 - Adoption Subsidy
select payment_detail_id, final_service_start_dt, final_service_end_dt,
	final_fiscal_category_cd, subsidy_agreement_id, client_id, update_ts, update_user_id 
from tb_payment_detail 
where payment_detail_id in (4241422, 4241423, 4224374, 4207197)
	and delete_sw = 'N' ;


update tb_payment_detail
set final_fiscal_category_cd = '2181',
	update_ts = now(),
	update_user_id = 'CDM-15929'
where payment_detail_id in (4241422, 4241423, 4224374, 4207197)
	and delete_sw = 'N' ;
