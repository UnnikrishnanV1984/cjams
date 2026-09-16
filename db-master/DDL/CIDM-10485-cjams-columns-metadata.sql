-- CIDM-10485 - Used for DevDB masking (Column level)
drop TABLE IF EXISTS cjams.cjams_columns_metadata CASCADE;

CREATE TABLE IF NOT EXISTS cjams.cjams_columns_metadata (
   	id SERIAL PRIMARY KEY,
	table_schema varchar(150) NULL,
	table_name varchar(150) NULL,
	column_name varchar(150) NULL,
	column_default varchar(150) NULL,
	data_type varchar(150) NULL,
	primary_key varchar(150) NULL,
	is_pii varchar(150) NULL,
	pii_type varchar(150) NULL,
	pii_default varchar(150) NULL,
	pii_format varchar(150) NULL,
	json_path text NULL,
	json_key text NULL,
	activeflag int4 DEFAULT 1 NOT NULL,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp DEFAULT now() NOT NULL,
	updatedby varchar(50) NOT NULL,
	updatedon timestamp DEFAULT now() NULL
);