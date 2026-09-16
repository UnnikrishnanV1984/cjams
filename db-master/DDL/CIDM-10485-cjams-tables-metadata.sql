-- CIDM-10485 - Used for DevDB masking (Table level)
DROP table if exists cjams.cjams_tables_metadata CASCADE;

CREATE table if not exists cjams.cjams_tables_metadata (
    id serial PRIMARY KEY,
	table_schema varchar(150) NULL,
	table_name varchar(150) NULL,
	column_count int4 NULL,
	table_type varchar(150) NULL,
	primary_key varchar(150) NULL,
	needed_in_dev varchar(150) NULL,
	reason_not_needed_in_dev varchar(150) NULL,
	activeflag int4 NOT NULL DEFAULT 1, 
  	insertedby varchar(50) NOT NULL, 
  	insertedon timestamp NOT NULL DEFAULT now(), 
	updatedby varchar(50) NULL, 
	updatedon timestamp NULL DEFAULT now()
);