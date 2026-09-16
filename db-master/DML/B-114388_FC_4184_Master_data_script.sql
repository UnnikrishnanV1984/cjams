-- B-114388 - New CfE fiscal category code addition for emergency care retainer fee

-- New Fiscal Category Code: 4184 Emergency Care Retainer Fees
-- for period October 1, 2021, thru September 30, 2023 
-- Program Assignment: Out of Home

Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type, annual_max_amount
	)
values
	(	173, '4184', 'Emergency Care Retainer Fees', '3952', 'A', 
		'4', 'B-114388', 'B-114388', 'N', '2021-10-01', '2023-09-30', 
		now(), now(), NULL, NULL, NULL, NULL
	);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'B-114388', now()::date, 'B-114388', 
		now(), 1, NULL, 173, NULL, NULL
	);