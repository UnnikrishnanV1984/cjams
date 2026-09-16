drop table if exists tb_vendor_applicant; 
CREATE TABLE tb_vendor_applicant (
	vendorapplicantid uuid NOT NULL DEFAULT gen_random_uuid(),
	org_nm  varchar(100) NULL,
	primary_prefix_cd varchar(5) NULL,
	primary_first_nm varchar(20) NULL,
	primary_middle_nm varchar(10) NULL,
	primary_last_nm varchar(20) NULL,
	primary_suffix_cd varchar(5) NULL,
	isprimaryadmin boolean null,
	admin_prefix_cd varchar(5) NULL,
	admin_first_nm varchar(20) NULL,
	admin_middle_nm varchar(10) NULL,
	admin_last_nm varchar(20) NULL,
	admin_suffix_cd varchar(5) NULL,
	taxidtype varchar(50) null,
	taxid numeric(9) null,
	is1099indicator boolean null,
	ismedicalaidprov boolean null,
	status varchar(50) null,
	create_ts varchar(30) NOT NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts varchar(30) NOT NULL,
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL
);

drop table if exists tb_vendor_applicant_services; 
CREATE TABLE tb_vendor_applicant_services (
	vendorapplicantservicesid uuid NOT NULL DEFAULT gen_random_uuid(),
	service_id int not null,
	vendorapplicantid uuid not null,
	startdate timestamp null,
    enddate timestamp null,
	create_ts varchar(30) NOT NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts varchar(30) NOT NULL,
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL
);



drop table if exists tb_vendor_addresses; 
CREATE TABLE tb_vendor_addresses (
	vendoraddressid uuid NOT NULL DEFAULT gen_random_uuid(),
	vendorapplicantid uuid not null,
	adr_1  varchar(50) NULL,
	adr_2  varchar(50) NULL,
	adr_city_nm varchar(50) NULL,
	adr_county_cd varchar(5) NULL,
	adr_state_cd varchar(5) NULL,
	adr_type_key varchar(50) null,
	adr_zip_no numeric(5) NULL,
	adr_start_dt date NULL,
	adr_end_dt date NULL,
	ispaymentaddress boolean null,
	create_ts varchar(30) NOT NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts varchar(30) NOT NULL,
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL
);

drop table if exists tb_vendor_phone; 
CREATE TABLE tb_vendor_phone (
	vendorphoneid uuid NOT NULL DEFAULT gen_random_uuid(),
	vendorapplicantid uuid not null,
	phonetypekey varchar(15)  NULL,
	phonenumber varchar(32) NULL, 
	phoneextension varchar(8) NULL, 
	create_ts varchar(30) NOT NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts varchar(30) NOT NULL,
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL
);


drop table if exists tb_vendor_email; 
CREATE TABLE tb_vendor_email (
	vendoremailid uuid NOT NULL DEFAULT gen_random_uuid(),
	vendorapplicantid uuid not null,
    emailtypekey varchar(15)  NULL,
	email varchar(50) NULL,
	create_ts varchar(30) NOT NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts varchar(30) NOT NULL,
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL
);

