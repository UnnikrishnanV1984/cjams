-- Drop table

 -- DROP TABLE cjams.tb_search_client

CREATE TABLE cjams.tb_search_client (
	client_id int4 NULL,
	cis_client_id varchar(10) NULL,
	prefix_cd varchar(5) NULL,
	first_nm varchar(20) NULL,
	middle_nm varchar(10) NULL,
	last_nm varchar(20) NULL,
	suffix_cd varchar(5) NULL,
	formatted_first_nm varchar(20) NULL,
	formatted_last_nm varchar(20) NULL,
	formatted_middle_nm varchar(10) NULL,
	last_nm_soundex varchar(50) NULL,
	first_nm_soundex varchar(50) NULL,
	gender_cd varchar(5) NULL,
	ssn_no numeric(9) NULL,
	dob_dt date NULL,
	approximate_dob_sw bpchar(1) NULL,
	primary_race_cd varchar(5) NULL,
	hipanic_sw bpchar(1) NULL,
	approximate_age_no int4 NULL,
	create_user_id varchar(50) NULL,
	create_ts timestamp NULL,
	update_user_id varchar(50) NULL,
	update_ts timestamp NULL,
	delete_sw bpchar(1) NULL,
	fnm_soundex varchar(30) NULL,
	lnm_soundex varchar(30) NULL
);