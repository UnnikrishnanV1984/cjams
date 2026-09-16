-- CIDM-8124 - CJAMS Interfaces Status Monitoring Batch job modifications

-- Master Data Interfaces Status Monitoring Table

-- cjams.interfacestatusmonitoring definition
DROP TABLE if EXISTS cjams.interfacestatusmonitoring ;
CREATE TABLE cjams.interfacestatusmonitoring (
	interfacestatusmonitoringid bigserial NOT NULL,
	run_date date NULL,
	interface_ref_key character varying NOT NULL,
	interface_status_text character varying NULL, 
	interface_data_count character varying NULL, 
	displayorder int4 NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	CONSTRAINT interfacestatusmonitoring_pk PRIMARY KEY (interfacestatusmonitoringid)
	);
CREATE INDEX interfacestatusmonitoring_idx ON cjams.interfacestatusmonitoring USING btree (run_date);

COMMENT ON COLUMN cjams.interfacestatusmonitoring.interfacestatusmonitoringid IS 'Primary key - unique idetifier for interfaces status monitoring table.';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.run_date IS 'Data of interfaces status monitoring data capture.';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.interface_ref_key IS 'Unique reference value for cjams interface trasnaction.';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.interface_status_text IS 'Interface message for daily status monitoring email.';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.interface_data_count IS 'Interface data count for daily status monitoring email';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.displayorder IS 'The sort-order number to determine the order to be displayed on daily email';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.interfacestatusmonitoring.activeflag IS 'Status of the record - active or inactive.';

