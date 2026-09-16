CREATE TABLE cjams.tb_conv_inv_finding (
	inv_finding_id int4 NOT NULL,
	referral_id int4 NULL,
	maltreatment_type_cd varchar(5) NULL,
	investigation_finding_cd varchar(5) NULL,
	worker_id varchar(10) NULL,
	ldss_id varchar(5) NULL,
	close_dt date NULL,
	expungement_processed_sw bpchar(1) NULL
);
ALTER TABLE cjams.tb_conv_inv_finding ALTER COLUMN referral_id TYPE varchar(50) USING referral_id::varchar;
ALTER TABLE cjams.tb_conv_inv_finding ALTER COLUMN maltreatment_type_cd TYPE varchar(100) USING maltreatment_type_cd::varchar;
ALTER TABLE cjams.tb_conv_inv_finding ALTER COLUMN investigation_finding_cd TYPE varchar(100) USING investigation_finding_cd::varchar;
ALTER TABLE cjams.tb_conv_inv_finding ALTER COLUMN worker_id TYPE varchar(100) USING worker_id::varchar;
ALTER TABLE cjams.tb_conv_inv_finding ALTER COLUMN ldss_id TYPE varchar(100) USING ldss_id::varchar;
ALTER TABLE intakeservicerequest ADD hascisdata bool NULL DEFAULT false;
alter type getdsdsactionsummarydtls_type add attribute hascisdata bool