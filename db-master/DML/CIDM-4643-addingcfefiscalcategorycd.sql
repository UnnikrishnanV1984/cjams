-- B-126595 - Add Fiscal Category Code 4181-CfE Respite Services (CfE)

-- New Fiscal Category Code: 4181 - CfE Respite Services
-- for period May 15, 2022 or after September 30 2023.
-- Program Assignment: Out of Home

Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type
	)
values
	(	175, '4181', 'CfE Respite Services', '3952', 'A', 
		'4', 'CIDM-4643', 'CIDM-4643', 'N', '2022-05-15', '2023-09-30', 
		now(), now(), NULL, NULL, NULL
	) ON CONFLICT DO NOTHING;

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'CIDM-4643', now()::date, 'CIDM-4643', 
		now(), 1, NULL, 175, NULL, NULL
	) ON CONFLICT DO NOTHING;
