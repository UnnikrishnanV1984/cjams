
DROP TABLE IF EXISTS cjams.tb_prov_program_facility;

CREATE TABLE cjams.tb_prov_program_facility (
	facility_id int4 NOT NULL, -- System generated identity for each contract facility
	provider_id int4 NULL, -- Identity of the associated provider (Facility)
	program_id int4 NULL, -- Identity of the associated contract program
	start_dt date NULL, -- Start date for affiliation
	end_dt date NULL, -- End date for affiliation
	create_ts timestamp NULL, -- timestamp when the record is created
	create_user_id varchar(50) NOT NULL, -- Login user who created this record
	update_ts timestamp NULL, -- Timestamp when the Record was last updated
	update_user_id varchar(50), -- Login user who last updated the record
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar, -- Flag to indicate if the record is marked for delete  - Values 'Y' - Deleted 'N' - Not deleted
	related_site_id int4 NULL -- Related Identity for each program site
);

CREATE INDEX ix_f364 ON cjams.tb_prov_program_facility USING btree (program_id);
COMMENT ON TABLE cjams.tb_prov_program_facility IS 'Entity to represent the affiliation of providers at the contract level';

-- Column comments

COMMENT ON COLUMN cjams.tb_prov_program_facility.facility_id IS 'System generated identity for each contract facility';
COMMENT ON COLUMN cjams.tb_prov_program_facility.provider_id IS 'Identity of the associated provider (Facility)';
COMMENT ON COLUMN cjams.tb_prov_program_facility.program_id IS 'Identity of the associated contract program';
COMMENT ON COLUMN cjams.tb_prov_program_facility.start_dt IS 'Start date for affiliation';
COMMENT ON COLUMN cjams.tb_prov_program_facility.end_dt IS 'End date for affiliation';
COMMENT ON COLUMN cjams.tb_prov_program_facility.create_ts IS 'timestamp when the record is created';
COMMENT ON COLUMN cjams.tb_prov_program_facility.create_user_id IS 'Login user who created this record';
COMMENT ON COLUMN cjams.tb_prov_program_facility.update_ts IS 'Timestamp when the Record was last updated';
COMMENT ON COLUMN cjams.tb_prov_program_facility.update_user_id IS 'Login user who last updated the record';
COMMENT ON COLUMN cjams.tb_prov_program_facility.delete_sw IS 'Flag to indicate if the record is marked for delete  - Values ''Y'' - Deleted ''N'' - Not deleted';
COMMENT ON COLUMN cjams.tb_prov_program_facility.related_site_id IS 'Related Identity for each program site';

-- Sequence set up
DROP SEQUENCE IF EXISTS SQ_PROV_PROGRAM_FACILITY CASCADE;	
CREATE SEQUENCE SQ_PROV_PROGRAM_FACILITY
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 10000001
CACHE 1;

ALTER TABLE tb_prov_program_facility ALTER COLUMN facility_id SET DEFAULT nextval('SQ_PROV_PROGRAM_FACILITY');
