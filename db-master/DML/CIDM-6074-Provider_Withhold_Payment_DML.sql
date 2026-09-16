-- B-150256 - Provider Withhold Payment functionality modifications - CIDM-6074
/*
Check Status Master Data (Picklist values)
picklist_type_id: 37

4269	Cancelled
4270	Interfaced
4849	Returned
580  	Remailed
581  	Returned-Incorrect Address
4850	Returned-Incorrect Provider Name
*/

-- Delete 
-- 581  Returned-Incorrect Address
-- 4850	Returned-Incorrect Provider Name

-- Before
select picklist_value_cd, value_tx, delete_sw, update_ts, update_user_id 
	from cjams.tb_picklist_values
where picklist_type_id = 37
	and delete_sw = 'N'
order by value_tx ;

-- Insert 
update cjams.tb_picklist_values
set delete_sw = 'Y',
	update_user_id = 'CIDM-6074',
	update_ts = now()
where picklist_type_id = 37
	and delete_sw = 'N'
	and btrim(picklist_value_cd) in ('581', '4850') ;
	
-- After
select picklist_value_cd, value_tx, delete_sw, update_ts, update_user_id 
	from cjams.tb_picklist_values
where picklist_type_id = 37
	and delete_sw = 'N'
order by value_tx ;