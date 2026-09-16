-- B-109434 - Service Log Category - Editing of Family First EBP Service Categories (FAMILY FIRST)

-- Disable Existing EBP Services - Update Active_sw = 'N'
select service_id, service_nm, active_sw, update_ts, update_user_id 
	from prov.tb_services 
where delete_sw = 'N'
	and active_sw = 'Y'
	and service_id 
		in ( 
			11685, 11636, 11638, 11637, 11680, 11624, 11626, 11625, 11663, 11665, 
			11582, 11584, 11583, 11690, 11558, 11560, 11559, 11688, 11645, 11647, 
			11646, 11686, 11639, 11641, 11640, 11687, 11642, 11644, 11643, 11563, 
			11562, 11691, 11561, 11677, 11681, 11627, 11629, 11628, 11692, 11564, 
			11566, 11565, 11666, 11585, 11587, 11586, 11693, 11567, 11569, 11568, 
			11591, 11593, 11592, 11668, 11667, 11588, 11590, 11589, 11694, 11570, 
			11572, 11571, 11657, 11537, 11539, 11538, 11540, 11542, 11541, 11658, 
			11543, 11545, 11544, 11546, 11548, 11547, 11659, 11660, 11695, 11573, 
			11575, 11574, 11597, 11599, 11598, 11669, 11594, 11596, 11595, 11670, 
			11671, 11600, 11602, 11601, 11672, 11603, 11605, 11604, 11673, 11606, 
			11608, 11607, 11679, 11618, 11620, 11619, 11689, 11648, 11650, 11649, 
			11651, 11653, 11652, 11684, 11621, 11623, 11622, 11682, 11630, 11632, 
			11631, 11674, 11609, 11611, 11610, 11552, 11662, 11554, 11553, 11661, 
			11549, 11551, 11550, 11697, 11675, 11612, 11614, 11613, 11676, 11615, 
			11617, 11616, 11664, 11555, 11557, 11556, 11707, 11683, 11633, 11635, 
			11634, 11696, 11579, 11581, 11580, 11678, 11654, 11656, 11655, 11706, 
			11708
			) ;

update prov.tb_services 
set active_sw = 'N',
	update_ts = now(),
	update_user_id = 'B-109434'
where delete_sw = 'N'
	and active_sw = 'Y'
	and service_id 
		in ( 
			11685, 11636, 11638, 11637, 11680, 11624, 11626, 11625, 11663, 11665, 
			11582, 11584, 11583, 11690, 11558, 11560, 11559, 11688, 11645, 11647, 
			11646, 11686, 11639, 11641, 11640, 11687, 11642, 11644, 11643, 11563, 
			11562, 11691, 11561, 11677, 11681, 11627, 11629, 11628, 11692, 11564, 
			11566, 11565, 11666, 11585, 11587, 11586, 11693, 11567, 11569, 11568, 
			11591, 11593, 11592, 11668, 11667, 11588, 11590, 11589, 11694, 11570, 
			11572, 11571, 11657, 11537, 11539, 11538, 11540, 11542, 11541, 11658, 
			11543, 11545, 11544, 11546, 11548, 11547, 11659, 11660, 11695, 11573, 
			11575, 11574, 11597, 11599, 11598, 11669, 11594, 11596, 11595, 11670, 
			11671, 11600, 11602, 11601, 11672, 11603, 11605, 11604, 11673, 11606, 
			11608, 11607, 11679, 11618, 11620, 11619, 11689, 11648, 11650, 11649, 
			11651, 11653, 11652, 11684, 11621, 11623, 11622, 11682, 11630, 11632, 
			11631, 11674, 11609, 11611, 11610, 11552, 11662, 11554, 11553, 11661, 
			11549, 11551, 11550, 11697, 11675, 11612, 11614, 11613, 11676, 11615, 
			11617, 11616, 11664, 11555, 11557, 11556, 11707, 11683, 11633, 11635, 
			11634, 11696, 11579, 11581, 11580, 11678, 11654, 11656, 11655, 11706, 
			11708
			) ;	
			

-- New Services	( 4909 Statewide )

-- 5495	Housing Assistance - Housing (Paid)
-- 3334 Paid
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13000, 'Housing (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5495', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);

-- 5494	Employment Services - Job Training (Non-Paid)
-- 3335	Non-Paid
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13001, 'Job Training (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5494', NULL, 'N', 
		'N', NULL, NULL, NULL
	);


-- 5509	Mental Health Services
-- 3334 Paid
-- Functional Family Therapy - EBP - PSSF (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13002, 'Functional Family Therapy - EBP - PSSF (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Functional Family Therapy - EBP - Other Funds (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13003, 'Functional Family Therapy - EBP - Other Funds (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Multisystemic Therapy - EBP - PSSF (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13004, 'Multisystemic Therapy - EBP - PSSF (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Multisystemic Therapy - EBP - Other Funds (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13005, 'Multisystemic Therapy - EBP - Other Funds (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- PCIT - EBP - PSSF (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13006, 'PCIT - EBP - PSSF (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- PCIT - EBP - Other Funds (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13007, 'PCIT - EBP - Other Funds (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);

-- 5509	Mental Health Services
-- 3335	Non-Paid
-- Functional Family Therapy - EBP - FFPSA (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13008, 'Functional Family Therapy - EBP - FFPSA (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Funcational Family Therapy - EBP - PSSF (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13009, 'Funcational Family Therapy - EBP - PSSF (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Functional Family Therapy - EBP- Other Funds (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13010, 'Functional Family Therapy - EBP - Other Funds (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Multisystemic Therapy - EBP - FFPSA (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13011, 'Multisystemic Therapy - EBP - FFPSA (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Multisystemic Therapy - EBP - PSSF (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13012, 'Multisystemic Therapy - EBP - PSSF (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Mulitsystemic Therapy - EBP- Other Funds (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13013, 'Mulitsystemic Therapy - EBP - Other Funds (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- PCIT - EBP - FFPSA (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13014, 'PCIT - EBP - FFPSA (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- PCIT - EBP - PSSF (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13015, 'PCIT - EBP - PSSF (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- PCIT - EBP- Other Funds (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13016, 'PCIT - EBP - Other Funds (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5509', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);


-- 5501	Substance-Abuse Services
-- 3334 Paid
-- Multisystemic Therapy - EBP - PSSF (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13017, 'Multisystemic Therapy - EBP - PSSF (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5501', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Multisystemic Therapy - EBP - Other Funds (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13018, 'Multisystemic Therapy - EBP - Other Funds (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5501', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- 5501	Substance-Abuse Services
-- 3335	Non-Paid
-- Multisystemic Therapy - EBP - FFPSA (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13019, 'Multisystemic Therapy - EBP - FFPSA (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5501', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Multisystemic Therapy - EBP - PSSF (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13020, 'Multisystemic Therapy - EBP - PSSF (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5501', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Mulitsystemic Therapy - EBP- Other Funds (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13021, 'Mulitsystemic Therapy - EBP - Other Funds (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5501', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	

-- 5510 Parenting (New Code)
insert into cjams.tb_picklist_values
	(	picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, 
		sort_order_no, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, category_tx
	)
values
	(	'5510', 1196, 'Parenting', 'Parenting', 'Y', 
		0, now(), 'B-109434', now(), 'B-109434', 
		'N', 'NULL'
	);

-- 3334 Paid
-- Healthy Families America -EBP - PSSF (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13022, 'Healthy Families America - EBP - PSSF (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Healthy Families America -EBP - Other Funds (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13023, 'Healthy Families America - EBP - Other Funds (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Nurse-Family Partnership - EBP - PSSF (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13024, 'Nurse-Family Partnership - EBP - PSSF (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- Nurse-Family Partnership - EBP - Other Funds (Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13025, 'Nurse-Family Partnership - EBP - Other Funds (Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);

-- 3335	Non-Paid
-- Healthy Families America - EBP - FFPSA (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13026, 'Healthy Families America - EBP - FFPSA (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Healthy Families America -EBP - PSSF (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13027, 'Healthy Families America - EBP - PSSF (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Healthy Families America -EBP- Other Funds (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13028, 'Healthy Families America - EBP - Other Funds (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Nurse-Family Partnership - EBP - FFPSA (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13029, 'Nurse-Family Partnership - EBP - FFPSA (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Nurse-Family Partnership - EBP - PSSF (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13030, 'Nurse-Family Partnership - EBP - PSSF (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
	
-- Nurse-Family Partnership - EBP- Other Funds (Non-Paid)
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	13031, 'Nurse-Family Partnership - EBP - Other Funds (Non-Paid)', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '5510', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	


/*
-- paid
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	1300?, '?', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3334', '??', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);
	
-- non-paid
insert into prov.tb_services
	(	service_id, service_nm, payment_category_cd, placement_sw, affiliated_sw, 
		support_sw, create_ts, create_user_id, update_ts, update_user_id, 
		delete_sw, educational_sw, structure_service_cd, state_ldss_cd, active_sw, 
		placement_structure_id, paid_non_paid_cd, service_category_cd, comar_sw, child_account_sw, 
		iv_e_allowable_sw, etl_userid, etl_load_date, teamtypekey
	)
values
	(	130??, '?', NULL, NULL, NULL, 
		NULL, now(), 'B-109434', now(), 'B-109434', 
		'N', NULL, 'S', '4909', 'Y', 
		NULL, '3335', '??', NULL, 'N', 
		'Y', NULL, NULL, NULL
	);	
*/	