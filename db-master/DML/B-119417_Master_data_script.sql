-- B-119417 - 7108 Fiscal Category Code (CIDM-4072)
-- (Enhancement User Story for B-114387)
/* 
Need to add the following services in the service log "services" drop down.

Hospital Overstay - ER Medical (Paid) 
Hospital Overstay - ER Psychiatric (Paid) 
Hospital Overstay - Inpatient Medical (Paid)
Hospital Overstay - Inpatient Psychiatric (Paid)
*/

-- Service Category: 5497 (Medical Services)

-- Before
select service_id, service_nm, active_sw, update_ts, update_user_id 
	from prov.tb_services 
where service_id in ( 13040, 13041, 13042, 13043 ) ;

-- Hospital Overstay - ER Medical (Paid) 
Insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13040, 'Hospital Overstay - ER Medical (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-119417', now(), 'B-119417', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5497', NULL, 'N', 
		NULL, NULL, NULL, NULL
	);
	
-- Hospital Overstay - ER Psychiatric (Paid) 
Insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13041, 'Hospital Overstay - ER Psychiatric (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-119417', now(), 'B-119417', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5497', NULL, 'N', 
		NULL, NULL, NULL, NULL
	);
	
-- Hospital Overstay - Inpatient Medical (Paid)
Insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13042, 'Hospital Overstay - Inpatient Medical (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-119417', now(), 'B-119417', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5497', NULL, 'N', 
		NULL, NULL, NULL, NULL
	);
	
-- Hospital Overstay - Inpatient Psychiatric (Paid)
Insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13043, 'Hospital Overstay - Inpatient Psychiatric (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-119417', now(), 'B-119417', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5497', NULL, 'N', 
		NULL, NULL, NULL, NULL
	);
	
-- After
select service_id, service_nm, active_sw, update_ts, update_user_id 
	from prov.tb_services 
where service_id in ( 13040, 13041, 13042, 13043 ) ;
