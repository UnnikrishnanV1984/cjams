-- Drop table

-- DROP TABLE cjams.hospitaldetails;

DROP TABLE if exists cjams.hospitaldetails;

CREATE TABLE if not exists cjams.hospitaldetails (
	id uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	name varchar(500) NULL,
	addresss1 varchar(500) NULL,
	addresss2 varchar(500) NULL,
	city varchar(500) NULL,
	state varchar(500) NULL,
	zipcode varchar(500) NULL,
	county varchar(500) NULL,
	phoneno varchar(500) NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	CONSTRAINT pk_hospitaldetails PRIMARY KEY (id)
);

COMMENT ON COLUMN cjams.hospitaldetails.id IS 'Primary key for the table';
COMMENT ON COLUMN cjams.hospitaldetails.name IS 'Name of the hospilization';
COMMENT ON COLUMN cjams.hospitaldetails.addresss1 is 'Hospital address 1';
COMMENT ON COLUMN cjams.hospitaldetails.addresss2 is 'Hospital address 2';
COMMENT ON COLUMN cjams.hospitaldetails.city is 'Hospital city';
COMMENT ON COLUMN cjams.hospitaldetails.state is 'State of the hospital';
COMMENT ON COLUMN cjams.hospitaldetails.zipcode is 'Hospital zip code';
COMMENT ON COLUMN cjams.hospitaldetails.county is 'County name for the state';
COMMENT ON COLUMN cjams.hospitaldetails.phoneno is 'Hospital phone number';
COMMENT ON COLUMN cjams.hospitaldetails.insertedby IS 'User who inserted the record';
COMMENT ON COLUMN cjams.hospitaldetails.insertedon IS 'Record inserted Date';
COMMENT ON COLUMN cjams.hospitaldetails.updatedby IS 'User who updated the record';
COMMENT ON COLUMN cjams.hospitaldetails.updatedon IS 'Record updated date';
COMMENT ON COLUMN cjams.hospitaldetails.activeflag IS 'Active record flag';

