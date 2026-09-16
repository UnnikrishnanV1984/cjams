-- B-178498 - CfE Differential Board Rates Extension upto 03/31/2024 - CIDM-8046

-- Update Differential Board Rate expenditure availability until 03/31/2024

-- Fiscal Category Code: 4185 Differential Board Rate - fiscal_category_id: 174

select fiscal_category_id, fiscal_category_cd, fiscal_category_desc, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_fiscal_category_master 
where fiscal_category_id = 174
	and delete_sw = 'N' ;
	
update cjams.tb_fiscal_category_master
set end_dt = '2024-03-31',
	update_user_id = 'CIDM-8046',
	update_ts = now()
where fiscal_category_id = 174
	and delete_sw = 'N' ;

