-- New Fiscal Category Code: 5121 - Chafee Independent Living
-- April 1, 2020, thru September 30, 2021
-- For Out of Home

Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type
	)
values
	(	169, '5121', 'Chafee Independent Living', '3952', 'A', 
		'4', 'B-107372', 'B-107372', 'N', '2020-04-01', '2021-09-30', 
		now(), now(), NULL, NULL, NULL
	);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'B-107372', now()::date, 'B-107372', 
		now(), 1, NULL, 169, NULL, NULL
	);
