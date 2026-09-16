-- B-108432 - Addition of Fiscal Category Code 4170

-- New Fiscal Category Code: 4170 - Promoting Safe & Stable Families - CRRSAA PSSF
-- Oct 1, 2020, thru September 30, 2022 Funds must be disbursed by Dec 30, 2022
-- For Out of Home

Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type
	)
values
	(	170, '4170', 'Promoting Safe & Stable Families - CRRSAA PSSF', '3952', 'A', 
		'4', 'B-108432', 'B-108432', 'N', '2020-10-01', '2022-09-30', 
		now(), now(), NULL, NULL, NULL
	);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'B-108432', now()::date, 'B-108432', 
		now(), 1, NULL, 170, NULL, NULL
	);

-- In-Home Services/Family Preservation - a79ae0dd-69d0-472a-bedd-07a776f7d3db
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'a79ae0dd-69d0-472a-bedd-07a776f7d3db', 'B-108432', now()::date, 'B-108432', 
		now(), 1, NULL, 170, NULL, NULL
	);
	
-- CPS - 55d88702-193b-40b5-9b98-93d8c492ba4f
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '55d88702-193b-40b5-9b98-93d8c492ba4f', 'B-108432', now()::date, 'B-108432', 
		now(), 1, NULL, 170, NULL, NULL
	);
	
-- Auxiliary Services - 91e94942-8d90-4e53-a8e9-751469738dab
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '91e94942-8d90-4e53-a8e9-751469738dab', 'B-108432', now()::date, 'B-108432', 
		now(), 1, NULL, 170, NULL, NULL
	);

	
	