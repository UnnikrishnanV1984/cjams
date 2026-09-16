-- B-113799 - Family First: Pregnant and Parenting Youth in Foster Care documentation

-- New Services	( 4909 Statewide )
/*
5511	Kinship Services
Kinship Navigation (Paid)
Kinship Navigation (Non-Paid)

5510	Parenting
In-home parent skill-based service/program (Paid)
In-home parent skill-based service/program (Non-Paid)

5501	Substance-Abuse Services
Substance abuse prevention and treatment service/program (Paid)
Substance abuse prevention and treatment service/program (Non-Paid)

5509	Mental Health Services
Mental health service/program (Paid)									
Mental health service/program (Non-Paid)			
*/


-- 5511 Kinship Services (New Code)
insert into cjams.tb_picklist_values
	(	picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, 
		sort_order_no, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, category_tx
	)
values
	(	'5511', 1196, 'Kinship Services', 'Kinship Services', 'Y', 
		0, now(), 'B-113799', now(), 'B-113799', 
		'N', 'NULL'
	);


-- 5511	Kinship Services
-- 3334 Paid
-- Kinship Navigation (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13032, 'Kinship Navigation (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5511', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	

-- 3335	Non-Paid
-- Kinship Navigation (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13033, 'Kinship Navigation (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5511', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- 5510	Parenting
-- 3334 Paid
-- In-home parent skill-based service/program (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13034, 'In-home parent skill-based service/program (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- 3335	Non-Paid	
-- In-home parent skill-based service/program (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13035, 'In-home parent skill-based service/program (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- 5501	Substance-Abuse Services	
-- 3334 Paid
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13036, 'Substance abuse prevention and treatment service/program (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5501', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	

-- 3335	Non-Paid	
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13037, 'Substance abuse prevention and treatment service/program (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5501', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- 5509	Mental Health Services
-- 3334 Paid
-- Mental health service/program (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13038, 'Mental health service/program (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	

-- 3335	Non-Paid	
-- Mental health service/program (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13039, 'Mental health service/program (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-113799', now(), 'B-113799', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);