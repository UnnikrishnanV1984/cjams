-- CDM-32928 - No Overpayment generated
/*
-- Issue Description: 
    Provider 5000668 rate (#215012629) for program 5002394 (Malaysia w/3 child) was changed to end 10/31/2022. 
	No overpayment was genrated. Provider was overpaid for October 2022. 

-- Case ID: 3167742
-- Client ID: 2353695 (MALASHA D BRADSHAW) - c1f06a82-20b7-425a-a52b-6a97a35a9f1f
-- Private Organization: 5000668 (The Children's Choice Of Maryland, Inc.)
-- Placement ID: 1564943 - 2021-04-07 To Current - 	88b61cd9-8fc1-400d-8351-38bb9b470a85
-- Program ID: 50002394	(Malasha Bradshaw w/3 child) - 2020-04-07 To 2023-06-30

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Root cause: Contract program is having Expired rate slab with start date as 10/24/2022 - $6916.00
-- 			   Oct 2022 rate slab was fixed earlier with CDM-31372, in which the update was missed for this Expired rate slab. 
-- Fix Provided: Datafix has been promoted to fix the Expired rate slab start date as 11/01/2022
--				 and trigger Under/Over batch to recalculate the payments.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix the Contract program Expired Rate Start date (CDM-32928)
-- Update start date as 2022-11-01
-- 215012630	82994.00	6916.00	227.38	2022-10-24	2023-06-30
select program_id, program_rate_id, start_dt, end_dt, per_diem_rate_no, monthly_rate_no, annual_rate_no, 
	update_ts, update_user_id, delete_sw 
from prov.tb_prov_program_rates 
where program_id  = 50002394
	and program_rate_id  = 215012630
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates 
set start_dt = '2022-11-01',
	update_ts = now(),
	update_user_id = 'CDM-32928'
where program_id  = 50002394
	and program_rate_id  = 215012630
	and delete_sw = 'N' ;
	
-- To Trigger Under Over batch
-- 215012629	71123.00	5927.40	195.30	2022-07-01	2022-10-31
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002394
	and program_rate_id = 215012629
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set update_ts = now(),
	update_user_id = 'CDM-32928'
where program_id = 50002394
	and program_rate_id = 215012629
	and delete_sw = 'N' ;

