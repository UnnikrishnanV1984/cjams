-- B-129555 - Health - Nature of Exam - Dental (CIDM-4759)

/*
Master Data to add new "Nature of Exam"

picklist_type_id: 320

New Code: 32926 - Dental
*/

-- Before
select picklist_value_cd , value_tx, create_user_id, create_ts
	from cjams.tb_picklist_values
where picklist_type_id = 320
	order by value_tx ;

-- Insert 
insert into cjams.tb_picklist_values
	(	picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, 
		sort_order_no, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, category_tx
	)
values
	(	'32926', 320, 'Dental', 'Dental', 'Y', 
		0, now(), 'B-129555', now(), 'B-129555', 
		'N', NULL
	);
	
-- After
select picklist_value_cd , value_tx, create_user_id, create_ts
	from cjams.tb_picklist_values
where picklist_type_id = 320
	order by value_tx ;

