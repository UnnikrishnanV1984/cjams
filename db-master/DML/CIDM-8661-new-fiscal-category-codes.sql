-- B-135292 - PI24Q2_Sprint01:CJAMS-CW-Add QI Assessment to the Assessments Tab - Part B-CM-1 ( CIDM-8661 )

-- Placement Structure
------------------------------------
-- 11410	Qualified Residential Treatment Program

-- Code           Description
------------------------------------
-- 2106 -         Qualified Residential Treatment Pgm
-- 7106 -         Qualified Residential Treatment Pgm
	
Delete from cjams.tb_placement_stru_category_link where fiscal_category_id in ( 177, 178 );	 
Delete from cjams.tb_fiscal_category_master where fiscal_category_id in ( 177, 178 );	 

Insert into cjams.tb_fiscal_category_master
	( 	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw,
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt,
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type
	)
values
	(	177, '2106', 'Qualified Residential Treatment Pgm', '3951', 'M',
		'6', 'CIDM-8661', 'CIDM-8661', 'N', NULL, NULL,
		now(), now(), NULL, NULL, NULL
	);

Insert into cjams.tb_fiscal_category_master
	( 	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw,
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt,
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type
	)
values
	(	178, '7106', 'Qualified Residential Treatment Pgm', '3952', 'M',
		'6', 'CIDM-8661', 'CIDM-8661', 'N', NULL, NULL,
		now(), now(), NULL, NULL, NULL
	);
	
-- Placement Structure & Fiscal Category Code link
	
INSERT INTO cjams.tb_placement_stru_category_link
	(	service_id, fiscal_category_id, create_user_id, update_user_id, delete_sw, 
		create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	11410, 177, 'CIDM-8661', 'CIDM-8661', 'N', 
		now(), now(), NULL, NULL
	);


INSERT INTO cjams.tb_placement_stru_category_link
	(	service_id, fiscal_category_id, create_user_id, update_user_id, delete_sw, 
		create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	11410, 178, 'CIDM-8661', 'CIDM-8661', 'N', 
		now(), now(), NULL, NULL
	);