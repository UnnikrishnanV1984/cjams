-- CDM-24181 - Wrong Payment Generated
/*
-- Issue Description: 
	Provider 6002823 for Sara G. (payment ID 3209835) paid using the wrong rate. 
	The December payment used the correct rate of $900 
	but the January payment used a rae of $850. 
	Please review and generate the correct adjustment. Program ID 50002467.

-- Private Organization: 6002823 (Lakeland Behavioral Health System Residential Treatment Center)
-- Program ID: 50002467	(Sara Gifford-)
	
-- Rate slab 2) 01/31/2022 to 02/28/2022 - $850.00
-- Rate slab 1) 12/01/2021 to 01/30/2022 - $900.00

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Not an issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- User request to fix the Contract Program Rate strat and end dates

-- 215009249	50002467	164250.00	13688.00	850.00	2022-01-31	2022-03-31
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002467
	and program_rate_id = 215009249
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set start_dt = '2022-02-01',
	-- rate_status = 'Active',
	update_ts = now(),
	update_user_id = 'CDM-24181'
where program_id = 50002467
	and program_rate_id = 215009249
	and delete_sw = 'N' ;

-- 215009220	50002467	164250.00	13688.00	850.00	2022-01-31	2022-02-28
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002467
	and program_rate_id = 215009220
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set start_dt = '2022-02-01',
	-- rate_status = 'Expired',
	update_ts = now(),
	update_user_id = 'CDM-24181'
where program_id = 50002467
	and program_rate_id = 215009220
	and delete_sw = 'N' ;

-- 215009219	50002467	164250.00	13688.00	900.00	2021-12-01	2022-01-30
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002467
	and program_rate_id = 215009219
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set end_dt = '2022-01-31',
	-- rate_status = 'Active',
	update_ts = now(),
	update_user_id = 'CDM-24181'
where program_id = 50002467
	and program_rate_id = 215009219
	and delete_sw = 'N' ;
