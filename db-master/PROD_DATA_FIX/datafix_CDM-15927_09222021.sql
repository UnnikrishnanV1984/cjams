-- CDM-15927 - Needs payment correction
/*
-- Issue Description: 
   Adoption Payments with incorrect Fiscal Category Codes 
    
-- Case ID: 2020024002667
-- Client ID: 200145627 (Susan Love	Brown) - d908c51e-f912-4ca3-8505-9231f2e7eef3
-- Adoption ID: 1050994 - 2020-08-24 To 2031-09-04 - 789217db-d49b-4e33-8c80-52c0b276b2c6
-- Provider ID: 5081104	(Christine Lynn Queen Brown) 
	
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Finance is not able to read the Eligibility Status as Start Date is missing 
--			   in the IV-E table. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 09/22 Build
*/

-- Payment Correction for Adoption ID: 1050993
/*
-- Payments 
Detl ID	Pay ID	Pay Date	Start Date	End Date	Amout	Code
----------------------------------------------------------------
4241424	3080432	2021-09-01	2021-08-24	2021-08-31	237.52	7181 
4241425	3080432	2021-09-01	2021-08-01	2021-08-23	682.87	7181 
4224373	3067880	2021-08-01	2021-07-01	2021-07-31	920.39	7181 
4207196	3055139	2021-07-01	2021-06-01	2021-06-30	890.70	7181 
4190315	3042845	2021-06-01	2021-05-01	2021-05-31	920.39	7181 
*/


-- 2181 & 7181 - Adoption Subsidy
select payment_detail_id, final_service_start_dt, final_service_end_dt,
	final_fiscal_category_cd, subsidy_agreement_id, client_id, 
	update_ts, update_user_id 
from tb_payment_detail 
where payment_detail_id in (4241424, 4241425, 4224373, 4207196, 4190315)
	and delete_sw = 'N' 
order by final_service_start_dt;

update tb_payment_detail
set final_fiscal_category_cd = '2181',
	update_ts = now(),
	update_user_id = 'CDM-15927'
where payment_detail_id in (4241424, 4241425, 4224373, 4207196, 4190315)
	and delete_sw = 'N' ;
