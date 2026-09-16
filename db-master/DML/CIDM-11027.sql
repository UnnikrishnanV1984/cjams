/*
 * CIDM-11027 - B-238260 Addition of Fiscal Category Code 7113
 * Focus Area:Purchase Authorization Form
 */

DELETE  FROM cjams.tb_fiscal_category_master
WHERE fiscal_category_id = 1000181;

INSERT INTO cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt,
		additional_description,
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type, annual_max_amount
	)
VALUES
	(	1000181, '7113', 'Emergency Respite Care - Foster Care', '3952', 'A', 
		'4', 'CIDM-11027', 'CIDM-11027', 'N', '2026-02-15', null, 
		'This Fiscal Category Code is to track Emergency Respite Care - Foster Care payments',
		now(), now(), NULL, NULL, NULL, null
	);

DELETE  FROM cjams.programcategorylink
WHERE fiscalcategoryid in ( 1000181);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
INSERT into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'CIDM-11027', now()::date, 'CIDM-11027', 
		now(), 1, NULL, 1000181, NULL, NULL
	);