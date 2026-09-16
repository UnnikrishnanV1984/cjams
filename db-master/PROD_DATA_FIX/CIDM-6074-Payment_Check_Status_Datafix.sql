-- B-150256 - Provider Withhold Payment functionality modifications - CIDM-6074
/*
Check Status Master Data (Picklist values)
picklist_type_id: 37

To update all existing records with below check status codes with 4849	Returned
581  	Returned-Incorrect Address
4850	Returned-Incorrect Provider Name
*/

-- Before
select payment_id, payment_dt, check_status_cd, check_status_dt, update_ts, update_user_id 
	from tb_payment_header 
where delete_sw = 'N'
	and btrim(check_status_cd) in ('581', '4850') ;

-- Insert 
update tb_payment_header
set check_status_cd = '4849', -- Returned
	update_user_id = 'CIDM-6074',
	update_ts = now()
where delete_sw = 'N'
	and btrim(check_status_cd) in ('581', '4850') ;
	
-- After
select payment_id, payment_dt, check_status_cd, check_status_dt, update_ts, update_user_id 
	from tb_payment_header 
where delete_sw = 'N'
	and btrim(check_status_cd) in ('581', '4850') ;
