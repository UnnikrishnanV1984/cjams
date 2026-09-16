-- New Fiscal Category Code: 7111 - Foster Care Matched Savings Plan
-- Program Assignment: Out of Home
Delete from cjams.programcategorylink  where fiscalcategoryid =176;
Delete from cjams.tb_fiscal_category_master where fiscal_category_id = 176;


Insert into cjams.tb_fiscal_category_master
( fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw,
payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt,
create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type
)
values
( 176, '7111', 'Foster Care Matched Savings Plan', '3952', 'A',
'4', 'B-100907', 'B-100907', 'N', NULL, NULL,
now(), now(), NULL, NULL, NULL
);

-- Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
( programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby,
updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
)
values
( gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'B-100907', now()::date, 'B-100907',
now(), 1, NULL, 176, NULL, NULL
);