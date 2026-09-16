
/*
 * CIDM-10709 - B-226708 Fiscal Category Codes for Hotel Stays
 * Focus Area:Purchase Authorization Form
 */

delete  FROM cjams.tb_fiscal_category_master
WHERE fiscal_category_id = 1000179;

Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type, annual_max_amount
	)
values
	(	1000179, '7160', 'Hotel Stays', '3952', 'A', 
		'4', 'CIDM-10709', 'CIDM-10709', 'N', '2025-07-01', null, 
		now(), now(), NULL, NULL, NULL, null
	);

delete  FROM cjams.programcategorylink
WHERE fiscalcategoryid in ( 1000179);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'CIDM-10709', now()::date, 'CIDM-10709', 
		now(), 1, NULL, 1000179, NULL, NULL
	);
	


delete  FROM cjams.tb_fiscal_category_master
WHERE fiscal_category_id = 1000180;

Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type, annual_max_amount
	)
values
	(	1000180, '7161', 'Hotel Stays-Additional Costs', '3952', 'A', 
		'4', 'CIDM-10709', 'CIDM-10709', 'N', '2025-07-01', null, 
		now(), now(), NULL, NULL, NULL, null
	);

delete  FROM cjams.programcategorylink
WHERE fiscalcategoryid in ( 1000180);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'CIDM-10709', now()::date, 'CIDM-10709', 
		now(), 1, NULL, 1000180, NULL, NULL
	);