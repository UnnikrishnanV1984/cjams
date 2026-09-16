-- B-114387 - Adding fiscal category code 7108 to CJAMs for payment of hospital overstays

-- New Fiscal Category Code: 7108 Hospital/Psych Overstay
-- For Out of Home
Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type
	)
values
	(	172, '7108', 'Hospital/Psych Overstay', '3952', 'A', 
		'4', 'B-114387', 'B-114387', 'N', NULL, NULL, 
		now(), now(), NULL, NULL, NULL
	);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'B-114387', now()::date, 'B-114387', 
		now(), 1, NULL, 172, NULL, NULL
	);

-- Add / Updates to Living Arrangement Types

-- IMC - Inpatient Medical Care 
-- No Changes 

-- PSYH - Psychiatric hospital  
-- Update this value as "Inpatient Psychiatric Hospital"
select * 
	from referencevalues 
where referencetypeid = 76 
	and ref_key = 'PSYH'
	and activeflag = 1 ;

update referencevalues
set value_text = 'Inpatient Psychiatric Hospital', 
	description = 'Inpatient Psychiatric Hospital', 
	updatedby = 'B-114387', 
	updatedon = now()
where referencetypeid = 76 
	and ref_key = 'PSYH'
	and activeflag = 1 ;

-- ADD
-- ER Medical
INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, teamtypekey, 
		activeflag, displayorder, insertedby, insertedon, updatedby, 
		updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ERM', 76, 'ER Medical', 'ER Medical', 'CW', 
		1, 38, 'B-114387', now(), 'B-114387', 
		now(), NULL, NULL, NULL
	);

-- ADD
-- ER Psychiatric
 INSERT INTO cjams.referencevalues
	(	ref_key, referencetypeid, value_text, description, teamtypekey, 
		activeflag, displayorder, insertedby, insertedon, updatedby, 
		updatedon, parenttypeid, parentkey, mdmcode
	)
VALUES
	(	'ERP', 76, 'ER Psychiatric', 'ER Psychiatric', 'CW', 
		1, 39, 'B-114387', now(), 'B-114387', 
		now(), NULL, NULL, NULL
	);
