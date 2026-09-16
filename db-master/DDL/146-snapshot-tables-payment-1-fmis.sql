-- Drop table

-- DROP TABLE cjams.tb_provider_addresses_fss

CREATE TABLE cjams.tb_provider_addresses_fss (
	address_id serial NOT NULL,
	parent_key_id varchar(15) NULL,
	adr_type_cd varchar(5) NULL,
	adr_format_cd varchar(5) NULL,
	adr_street_no int4 NULL,
	adr_box_no int4 NULL,
	adr_pre_dir_cd varchar(5) NULL,
	adr_street_nm varchar(50) NULL,
	adr_street_suffix_cd varchar(5) NULL,
	adr_post_dir_cd varchar(5) NULL,
	adr_unit_type_cd varchar(5) NULL,
	adr_unit_no_tx varchar(5) NULL,
	adr_city_nm varchar(50) NULL,
	adr_county_cd varchar(5) NULL,
	adr_state_cd varchar(5) NULL,
	adr_zip5_no numeric(5) NULL,
	adr_zip4_no numeric(4) NULL,
	adr_direction_tx varchar(500) NULL,
	adr_foreign_tx varchar(500) NULL,
	adr_foreign_state_tx varchar(50) NULL,
	adr_country_tx varchar(50) NULL,
	adr_postal_code_tx varchar(10) NULL,
	adr_default_sw bpchar(1) NULL,
	adr_start_dt date NULL,
	adr_end_dt date NULL,
	create_ts varchar(30) NULL,
	create_user_id varchar(50) NOT NULL,
	update_ts varchar(30) NULL,
	update_user_id varchar(50) NOT NULL,
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	adr_street_tx varchar(10) NULL,
	run_no varchar(9) NULL
);

-- Permissions

ALTER TABLE cjams.tb_provider_addresses_fss OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_provider_addresses_fss TO welfareadmin;

DROP TABLE cjams.tb_placement_fss;

CREATE TABLE cjams.tb_placement_fss (
	placement_id int4 NOT NULL,
	case_id int4 NULL,
	client_id int4 NOT NULL,
	removal_id int4 NULL,
	provider_organization_id int4 NULL,
	provider_id int4 NULL,
	contract_program_id int4 NULL,
	facility_id int4 NULL,
	medicaid_paid_sw bpchar(1) NULL,
	entry_dt date NULL,
	entry_tm varchar(30) NULL,
	other_services_tx varchar(500) NULL,
	exit_dt date NULL,
	exit_tm varchar(30) NULL,
	exit_explanation_tx varchar(500) NULL,
	exit_reason_cd varchar(5) NULL,
	over_under_sw bpchar(1) NULL,
	approval_status_cd varchar(5) NULL,
	placement_structure_id int4 NULL,
	void_sw bpchar(1) NULL,
	void_reason_cd varchar(5) NULL,
	exit_type_cd varchar(5) NULL,
	court_ordered_sw bpchar(1) NULL,
	icpc_approved_sw bpchar(1) NULL,
	create_ts varchar(30) NOT NULL DEFAULT now(),
	create_user_id varchar(10) NOT NULL,
	update_ts varchar(30) NOT NULL DEFAULT now(),
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	short_list_id int4 NULL,
	payment_header_id int4 NULL,
	placement_change_dt date NULL,
	fiscal_category_cd bpchar(5) NULL,
	rate_structure_id int4 NULL,
	conversion_sw bpchar(1) NULL,
	orig_placement_id int4 NULL,
	data_valid_sw bpchar(1) NULL,
	client_merge_id uuid NULL,
	run_no varchar(9) NULL
);

-- Permissions

ALTER TABLE cjams.tb_placement_fss OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_placement_fss TO welfareadmin;

-- Drop table

-- DROP TABLE cjams.tb_provider_approval_fss

CREATE TABLE cjams.tb_provider_approval_fss (
	provider_approval_id int4 NOT NULL,
	provider_id int4 NULL,
	approval_type_cd varchar(5) NULL,
	approval_status_cd varchar(5) NULL,
	recommend_cd varchar(5) NULL,
	entry_dt date NULL,
	effective_dt date NULL,
	next_recon_dt date NULL,
	approved_beds_no int4 NULL,
	approval_dt date NULL,
	approval_comments_tx varchar(2000) NULL,
	request_apprvoal_sw bpchar(1) NULL,
	no_household_sw bpchar(1) NULL,
	no_pets_sw bpchar(1) NULL,
	fire_request_dt date NULL,
	fire_complete_dt date NULL,
	health_request_dt date NULL,
	health_complete_dt date NULL,
	original_mot_tx varchar(1000) NULL,
	change_mot_tx varchar(1000) NULL,
	home_desc_tx varchar(1000) NULL,
	app_person_info_cd varchar(5) NULL,
	co_personal_info_cd varchar(5) NULL,
	app_background_cd varchar(5) NULL,
	co_background_cd varchar(5) NULL,
	app_childhood_cd varchar(5) NULL,
	co_childhood_cd varchar(5) NULL,
	app_adulthood_cd varchar(5) NULL,
	co_adulthood_cd varchar(5) NULL,
	household_cd varchar(5) NULL,
	pets_cd varchar(5) NULL,
	checklist_cd varchar(5) NULL,
	motivation_cd varchar(5) NULL,
	child_eval_cd varchar(5) NULL,
	family_system_cd varchar(5) NULL,
	reference_cd varchar(5) NULL,
	backup_cd varchar(5) NULL,
	recon_check_cd varchar(5) NULL,
	recon_eval_cd varchar(5) NULL,
	create_ts varchar(30) NULL,
	create_user_id varchar(50) NULL,
	update_ts varchar(30) NULL,
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	ref_approval_id int4 NULL,
	app_clearance_cd varchar(5) NULL,
	co_clearance_cd varchar(5) NULL,
	fam_clearance_cd varchar(5) NULL,
	effective_end_dt date NULL,
	comar_regulation_tx varchar(50) NULL,
	ha_approval_status_cd varchar(5) NULL,
	ha_approval_dt date NULL,
	ha_revoke_approval_status_cd varchar(5) NULL,
	ha_revoke_approval_dt date NULL,
	family_assessment_cd varchar(5) NULL,
	co_applicant_sw bpchar(1) NULL,
	recommended_children_tx varchar(2000) NULL,
	daycare_ok_sw bpchar(1) NULL,
	more_than_eight_sw bpchar(1) NULL,
	checklist_comments_tx varchar(2000) NULL,
	approval_reason_cd varchar(5) NULL,
	active_sw bpchar(1) NULL,
	training_completion_dt date NULL,
	run_no varchar(9) NULL
);

-- Permissions

ALTER TABLE cjams.tb_provider_approval_fss OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_provider_approval_fss TO welfareadmin;

-- Drop table

-- DROP TABLE cjams.tb_provider_services_fss

CREATE TABLE cjams.tb_provider_services_fss (
	provider_service_id bigserial NOT NULL,
	provider_id int8 NOT NULL,
	program_id int8 NULL,
	service_id int4 NULL,
	start_dt date NULL,
	end_dt date NULL,
	paid_cd varchar(5) NULL,
	primary_sw bpchar(1) NULL,
	location_sw bpchar(1) NULL,
	create_ts varchar(30) NULL,
	create_user_id varchar(100) NOT NULL,
	update_ts varchar(30) NULL,
	update_user_id varchar(100) NOT NULL,
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	run_no varchar(9) NULL
);

-- Permissions

ALTER TABLE cjams.tb_provider_services_fss OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_provider_services_fss TO welfareadmin;

-- Drop table

-- DROP TABLE cjams.tb_prov_program_rates_fss

CREATE TABLE cjams.tb_prov_program_rates_fss (
	program_rate_id serial NOT NULL,
	program_id int4 NULL,
	annual_rate_no numeric(10,2) NULL,
	monthly_rate_no numeric(10,2) NULL,
	per_diem_rate_no numeric(10,2) NULL,
	start_dt date NULL,
	end_dt date NULL,
	create_ts varchar(100) NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts varchar(100) NULL,
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	prov_program_actual_max_cd varchar(5) NULL,
	run_no varchar(9) NULL
);

-- Permissions

ALTER TABLE cjams.tb_prov_program_rates_fss OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_prov_program_rates_fss TO welfareadmin;

-- Drop table

-- DROP TABLE cjams.tb_adoption_subsidy_agreement_fss

CREATE TABLE cjams.tb_adoption_subsidy_agreement_fss (
	subsidy_agreement_id serial NOT NULL,
	agreement_type_cd varchar(5) NULL,
	father_agreement_sw bpchar(1) NULL,
	mother_agreement_sw bpchar(1) NULL,
	designee_agreement_sw bpchar(1) NULL,
	adoption_id int4 NULL,
	agreement_start_dt date NULL,
	create_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	agreement_end_dt date NULL,
	calculate_board_rate_sw bpchar(1) NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	negotiated_percentage_no numeric(5,2) NULL,
	payment_amount_no numeric(10,2) NULL,
	update_user_id varchar(10) NOT NULL,
	court_hearing_id int4 NULL,
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	comments_tx varchar(5000) NULL,
	approval_status_cd varchar(5) NULL,
	provider_id int4 NULL,
	rate_overwritten_sw bpchar(1) NULL,
	admin_approval_status_cd varchar(5) NULL,
	child_medically_fragile_sw bpchar(1) NULL,
	run_no varchar(9) NULL,
	CONSTRAINT pk_adpn_sub_agmt_fss PRIMARY KEY (subsidy_agreement_id)
);

-- Permissions

ALTER TABLE cjams.tb_adoption_subsidy_agreement_fss OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_adoption_subsidy_agreement_fss TO welfareadmin;
