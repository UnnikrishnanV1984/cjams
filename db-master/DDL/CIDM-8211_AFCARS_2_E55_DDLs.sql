-- CIDM-8211 - AFCARS - Foster Care - E55 Element needs to be updated based on latest Business Logic

-- New Table to capture QRTP Providers for Element 55

-- cjams.afcars_fc_qrtp_providers definition
DROP TABLE if EXISTS cjams.afcars_fc_qrtp_providers ;
CREATE TABLE cjams.afcars_fc_qrtp_providers (
	afcars_fc_qrtp_providers_id bigserial NOT NULL,
	provider_id bigint NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	CONSTRAINT afcars_fc_qrtp_providers_pk PRIMARY KEY (afcars_fc_qrtp_providers_id)
	);
CREATE INDEX afcars_fc_qrtp_providers_idx ON cjams.afcars_fc_qrtp_providers USING btree(provider_id);

COMMENT ON COLUMN cjams.afcars_fc_qrtp_providers.afcars_fc_qrtp_providers_id IS 'Primary key - unique idetifier for interfaces QRTP providers table.';
COMMENT ON COLUMN cjams.afcars_fc_qrtp_providers.provider_id IS 'Foreign key - PK of prov.tb_provider table';
COMMENT ON COLUMN cjams.afcars_fc_qrtp_providers.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.afcars_fc_qrtp_providers.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.afcars_fc_qrtp_providers.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.afcars_fc_qrtp_providers.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.afcars_fc_qrtp_providers.activeflag IS 'Status of the record - active or inactive.';
