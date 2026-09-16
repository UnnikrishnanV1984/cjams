
DROP TABLE IF EXISTS cjams.tb_provider_approval CASCADE;

CREATE TABLE cjams.tb_provider_approval (
	provider_approval_id int4 NULL,
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
	pre_revoke_status_cd varchar(5) NULL,
	pre_revoke_active_sw bpchar(1) NULL,
	providerapprovalid uuid NOT NULL DEFAULT gen_random_uuid()
);

-- Permissions

ALTER TABLE cjams.tb_provider_approval OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_provider_approval TO welfareadmin;


-----

DROP TABLE IF EXISTS cjams.publicproviderreferencecheck CASCADE;

CREATE TABLE cjams.publicproviderreferencecheck (
	reference_check_id uuid NOT NULL DEFAULT gen_random_uuid(),
	object_id varchar(50) NULL,
	reference_check_date date NULL,
	is_relative bool NULL,
	is_reference_recommends bool NULL,
	narrative varchar(2500) NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	reference_first_nm varchar(50) NULL,
	reference_middle_nm varchar(50) NULL,
	reference_last_nm varchar(50) NULL,
	relationship_to_application varchar(50) NULL,
	type_of_contact varchar(50) NULL,
	is_school_recommends bool NULL DEFAULT false,
	household_member_id jsonb NULL,
	CONSTRAINT pk_publicproviderreferencecheck PRIMARY KEY (reference_check_id)
);

-- Permissions

ALTER TABLE cjams.publicproviderreferencecheck OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.publicproviderreferencecheck TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.providerformdetails CASCADE;

CREATE TABLE cjams.providerformdetails (
	form_detail_id uuid NOT NULL DEFAULT gen_random_uuid(),
	template_id uuid NULL,
	provider_id varchar(50) NULL,
	form_data jsonb NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	object_id varchar(50) NULL,
	CONSTRAINT pk_providerformdetails PRIMARY KEY (form_detail_id)
);

-- Permissions

ALTER TABLE cjams.providerformdetails OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.providerformdetails TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.tb_public_provider_applicant CASCADE;

CREATE TABLE cjams.tb_public_provider_applicant (
	applicant_id varchar(50) NOT NULL,
	prgram varchar(50) NULL,
	create_ts varchar(30) NULL,
	create_user_id varchar(50) NULL,
	update_ts varchar(30) NULL,
	delete_sw varchar(1) NULL,
	update_user_id varchar(50) NULL,
	application_status varchar(50) NULL,
	organization_first_nm varchar(100) NULL,
	organization_tax_id int4 NULL,
	individual_applicant_first_nm varchar(100) NULL,
	individual_applicant_ssn int4 NULL,
	individual_applicant_dob date NULL,
	individual_applicant_background_check varchar(10) NULL,
	co_applicant_first_nm varchar(50) NULL,
	co_applicant_ssn int4 NULL,
	co_applicant_dob date NULL,
	co_applicant_background_check varchar(10) NULL,
	medical_info_license_no int4 NULL,
	medical_info_speciality varchar(150) NULL,
	payment_info_medicaid_provider bool NULL,
	payment_info_payee_first_nm varchar(100) NULL,
	payment_info_1099_indicator varchar(10) NULL,
	individual_applicant_middle_nm varchar(100) NULL,
	individual_applicant_last_nm varchar(100) NULL,
	organization_middle_nm varchar(100) NULL,
	organization_last_nm varchar(100) NULL,
	co_applicant_middle_nm varchar(100) NULL,
	co_applicant_last_nm varchar(100) NULL,
	payment_info_payee_middle_nm varchar(100) NULL,
	payment_info_payee_last_nm varchar(100) NULL,
	applicantion_decision varchar(50) NULL,
	communication_medium varchar(50) NULL,
	date_of_contact date NULL,
	applicant_decision varchar(50) NULL,
	provider_program_type varchar(500) NULL,
	individual_applicant_prefix varchar(50) NULL,
	individual_applicant_suffix varchar(50) NULL,
	co_applicant_prefix varchar(50) NULL,
	co_applicant_suffix varchar(50) NULL,
	is_home_water bool NULL,
	home_info_children_no varchar(50) NULL,
	home_info_bedroom_no varchar(50) NULL,
	is_home_swimming_pool bool NULL,
	home_info_pool_location varchar(50) NULL,
	home_is_other_agency bool NULL,
	home_info_agency_nm varchar(50) NULL,
	is_child_care_provider bool NULL,
	home_info_child_care_details varchar(50) NULL,
	individual_applicant_hm_phone varchar NULL,
	individual_applicant_cell_nm varchar NULL,
	individual_applicant_email varchar NULL,
	individual_applicant_employer_nm varchar NULL,
	individual_applicant_phone_nm varchar NULL,
	individual_applicant_us_citizen bool NULL,
	co_applicant_hm_phone varchar NULL,
	co_applicant_cell_nm varchar NULL,
	co_applicant_email varchar NULL,
	co_applicant_employer_nm varchar NULL,
	co_applicant_phone_nm varchar NULL,
	co_applicant_us_citizen bool NULL,
	age_group jsonb NULL,
	inquiry_source varchar(50) NULL,
	inquiry_source_details varchar(50) NULL,
	jurisdiction varchar(100) NULL,
	phase varchar(50) NULL,
	application_received_date timestamp NULL,
	home_study_completion_date timestamp NULL,
	individual_information json NULL,
	home_information json NULL,
	placement_structures jsonb NULL,
	training_info jsonb NULL,
	co_app_information jsonb NULL,
	app_information jsonb NULL
);

-- Permissions

ALTER TABLE cjams.tb_public_provider_applicant OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_public_provider_applicant TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.tb_public_provider_referral CASCADE;

CREATE TABLE cjams.tb_public_provider_referral (
	referral_id varchar(50) NOT NULL,
	prgram varchar(50) NULL,
	create_ts varchar(30) NULL,
	create_user_id varchar(50) NULL,
	update_ts varchar(30) NULL,
	delete_sw varchar(1) NULL,
	update_user_id varchar(50) NULL,
	referral_status varchar(50) NULL,
	organization_first_nm varchar(100) NULL,
	organization_tax_id int4 NULL,
	individual_applicant_first_nm varchar(100) NULL,
	individual_applicant_ssn int4 NULL,
	individual_applicant_dob date NULL,
	individual_applicant_background_check varchar(10) NULL,
	co_applicant_first_nm varchar(50) NULL,
	co_applicant_ssn int4 NULL,
	co_applicant_dob date NULL,
	co_applicant_background_check varchar(10) NULL,
	medical_info_license_no int4 NULL,
	medical_info_speciality varchar(150) NULL,
	payment_info_medicaid_provider bool NULL,
	payment_info_payee_first_nm varchar(100) NULL,
	payment_info_1099_indicator varchar(10) NULL,
	individual_applicant_middle_nm varchar(100) NULL,
	individual_applicant_last_nm varchar(100) NULL,
	organization_middle_nm varchar(100) NULL,
	organization_last_nm varchar(100) NULL,
	co_applicant_middle_nm varchar(100) NULL,
	co_applicant_last_nm varchar(100) NULL,
	payment_info_payee_middle_nm varchar(100) NULL,
	payment_info_payee_last_nm varchar(100) NULL,
	communication_medium varchar(50) NULL,
	date_of_contact date NULL,
	referral_decision varchar(50) NULL,
	provider_program_type varchar(500) NULL,
	individual_applicant_prefix varchar(50) NULL,
	individual_applicant_suffix varchar(50) NULL,
	co_applicant_prefix varchar(50) NULL,
	co_applicant_suffix varchar(50) NULL,
	home_info_children_no varchar(50) NULL,
	home_info_bedroom_no varchar(50) NULL,
	is_home_water bool NULL,
	is_home_swimming_pool bool NULL,
	home_info_pool_location varchar(50) NULL,
	home_is_other_agency bool NULL,
	home_info_agency_nm varchar(50) NULL,
	is_child_care_provider bool NULL,
	home_info_child_care_details varchar(50) NULL,
	individual_applicant_hm_phone varchar NULL,
	individual_applicant_cell_nm varchar NULL,
	individual_applicant_email varchar NULL,
	individual_applicant_employer_nm varchar NULL,
	individual_applicant_phone_nm varchar NULL,
	individual_applicant_us_citizen bool NULL,
	co_applicant_hm_phone varchar NULL,
	co_applicant_cell_nm varchar NULL,
	co_applicant_email varchar NULL,
	co_applicant_employer_nm varchar NULL,
	co_applicant_phone_nm varchar NULL,
	co_applicant_us_citizen bool NULL,
	age_group jsonb NULL,
	inquiry_source varchar(50) NULL,
	inquiry_source_details varchar(50) NULL,
	jurisdiction varchar(100) NULL
);

-- Permissions

ALTER TABLE cjams.tb_public_provider_referral OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_public_provider_referral TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.providerorientationtraining CASCADE;

CREATE TABLE cjams.providerorientationtraining (
	orientation_training_id uuid NOT NULL DEFAULT gen_random_uuid(),
	training_number varchar(50) NULL,
	training_type varchar(50) NULL,
	training_date date NULL,
	start_datetime timestamp NULL,
	end_datetime timestamp NULL,
	duration numeric(10,2) NULL,
	medium varchar(50) NULL,
	addr_line1 varchar(50) NULL,
	addr_line2 varchar(50) NULL,
	addr_city varchar(50) NULL,
	addr_state varchar(50) NULL,
	addr_zip varchar(50) NULL,
	training_url varchar(250) NULL,
	narrative varchar(2500) NULL,
	instructor_1 uuid NULL,
	instructor_2 uuid NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	jurisdiction varchar(50) NULL,
	training_topic varchar(500) NULL,
	training_status varchar(50) NULL,
	room_no varchar(50) NULL,
	session_type varchar(50) NULL,
	session_no int4 NULL,
	CONSTRAINT pk_providerorientationtraining PRIMARY KEY (orientation_training_id)
);

-- Permissions

ALTER TABLE cjams.providerorientationtraining OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.providerorientationtraining TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.publicproviderstatusmanagement CASCADE;

CREATE TABLE cjams.publicproviderstatusmanagement (
	provider_status_management_id uuid NOT NULL DEFAULT gen_random_uuid(),
	object_id varchar(50) NULL,
	narrative varchar(5000) NULL,
	provider_status varchar(50) NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	approval_status varchar(50) NULL,
	dirty_status bool NULL,
	CONSTRAINT pk_publicproviderstatusmanagement PRIMARY KEY (provider_status_management_id)
);

-- Permissions

ALTER TABLE cjams.publicproviderstatusmanagement OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.publicproviderstatusmanagement TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.pubprovapphouseholdbgchecks CASCADE;

CREATE TABLE cjams.pubprovapphouseholdbgchecks (
	household_bg_id uuid NOT NULL DEFAULT gen_random_uuid(),
	household_member_id int4 NOT NULL,
	submission_data jsonb NULL,
	criminal_history_check_data jsonb NULL,
	CONSTRAINT pubprovapphouseholdbgchecks_id PRIMARY KEY (household_bg_id),
	CONSTRAINT pubprovapphouseholdbgchecks_foreign FOREIGN KEY (household_member_id) REFERENCES tb_public_provider_applicant_household(household_member_id)
);

-- Permissions

ALTER TABLE cjams.pubprovapphouseholdbgchecks OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.pubprovapphouseholdbgchecks TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.publicproviderhomeinfo CASCADE;

CREATE TABLE cjams.publicproviderhomeinfo (
	home_info_id uuid NOT NULL DEFAULT gen_random_uuid(),
	home_info_children_no varchar(50) NULL,
	home_info_bedroom_no varchar(50) NULL,
	is_home_water bool NULL,
	is_home_swimming_pool bool NULL,
	home_info_pool_location varchar(50) NULL,
	home_is_other_agency bool NULL,
	home_info_agency_nm varchar(50) NULL,
	is_child_care_provider bool NULL,
	home_info_child_care_details varchar(50) NULL,
	home_phone varchar(50) NULL,
	interested_in varchar(50) NULL,
	explanatory_text varchar(50) NULL,
	is_previously_applied bool NULL,
	previous_state varchar(50) NULL,
	previous_source varchar(50) NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	object_id varchar(50) NULL,
	CONSTRAINT pk_publicproviderhomeinfo PRIMARY KEY (home_info_id)
);

-- Permissions

ALTER TABLE cjams.publicproviderhomeinfo OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.publicproviderhomeinfo TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.publicproviderreconsideration CASCADE;

CREATE TABLE cjams.publicproviderreconsideration (
	recon_id uuid NOT NULL DEFAULT gen_random_uuid(),
	recon_number varchar(50) NULL,
	object_id varchar(50) NULL,
	recon_date date NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	recon_type varchar(50) NULL,
	CONSTRAINT pk_publicproviderreconsideration PRIMARY KEY (recon_id)
);

-- Permissions

ALTER TABLE cjams.publicproviderreconsideration OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.publicproviderreconsideration TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.providerapprovalphaserecord CASCADE;

CREATE TABLE cjams.providerapprovalphaserecord (
	provider_approval_record_id uuid NOT NULL DEFAULT gen_random_uuid(),
	referral_id varchar(50) NULL,
	applicant_id varchar(50) NULL,
	provider_id varchar(50) NULL,
	is_referral_accepted bool NULL,
	is_pre_app_accepted bool NULL,
	is_application_accepted bool NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	CONSTRAINT pk_providerapprovalphaserecord PRIMARY KEY (provider_approval_record_id)
);

-- Permissions

ALTER TABLE cjams.providerapprovalphaserecord OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.providerapprovalphaserecord TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.providerapproval CASCADE;

CREATE TABLE cjams.providerapproval (
	providerapprovalid uuid NOT NULL,
	providerid uuid NOT NULL,
	approvaltypekey varchar(100) NULL,
	approvalstatuskey varchar(100) NULL,
	recommendkey varchar(100) NULL,
	entrydate timestamp NULL,
	effectivedate timestamp NULL,
	nextrecondate timestamp NULL,
	approvedbedsno int4 NULL,
	approvaldate timestamp NULL,
	approvalcomments varchar(2000) NULL,
	requestapprvoalflag int4 NULL,
	nohouseholdflag int4 NULL,
	nopetsflag int4 NULL,
	firerequestdate timestamp NULL,
	firecompletedate timestamp NULL,
	healthrequestdate timestamp NULL,
	healthcompletedate timestamp NULL,
	originalmot varchar(1000) NULL,
	changemot varchar(1000) NULL,
	homedesc varchar(1000) NULL,
	apppersoninfokey varchar(50) NULL,
	copersonalinfokey varchar(50) NULL,
	appbackgroundkey varchar(50) NULL,
	cobackgroundkey varchar(50) NULL,
	appchildhoodkey varchar(50) NULL,
	cochildhoodkey varchar(50) NULL,
	appadulthoodkey varchar(50) NULL,
	coadulthoodkey varchar(50) NULL,
	householdkey varchar(50) NULL,
	petskey varchar(50) NULL,
	checklistkey varchar(50) NULL,
	motivationkey varchar(50) NULL,
	childevalkey varchar(50) NULL,
	familysystemkey varchar(50) NULL,
	referencekey varchar(50) NULL,
	backupkey varchar(50) NULL,
	reconcheckkey varchar(50) NULL,
	reconevalkey varchar(50) NULL,
	insertedon timestamp NULL,
	insertedby varchar(10) NULL,
	updatedon timestamp NULL,
	updatedby varchar(10) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	refapprovalid int4 NULL,
	appclearancekey varchar(50) NULL,
	coclearancekey varchar(50) NULL,
	famclearancekey varchar(50) NULL,
	effectiveenddate timestamp NULL,
	comarregulation varchar(50) NULL,
	haapprovalstatuskey varchar(50) NULL,
	haapprovaldate timestamp NULL,
	harevokeapprovalstatuskey varchar(50) NULL,
	harevokeapprovaldate timestamp NULL,
	familyassessmentkey varchar(50) NULL,
	coapplicantflag int4 NULL,
	recommendedchildren varchar(2000) NULL,
	daycareokflag int4 NULL,
	morethaneightflag int4 NULL,
	checklistcomments varchar(2000) NULL,
	approvalreasonkey varchar(50) NULL,
	flag int4 NULL,
	trainingcompletiondate timestamp NULL,
	prerevokestatuskey varchar(50) NULL,
	prerevokeactiveflag int4 NOT NULL DEFAULT 1,
	old_id varchar(50) NULL
);

-- Permissions

ALTER TABLE cjams.providerapproval OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.providerapproval TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.publicproviderpetinfo CASCADE;

CREATE TABLE cjams.publicproviderpetinfo (
	provider_pet_id uuid NOT NULL DEFAULT gen_random_uuid(),
	object_id varchar(50) NULL,
	pet_type_tx varchar(50) NULL,
	pet_breed_tx varchar(50) NULL,
	pet_nm varchar(50) NULL,
	age_of_pet_tx varchar(50) NULL,
	rabies_certificate_expiry_dt date NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	CONSTRAINT pk_publicproviderpetinfo PRIMARY KEY (provider_pet_id)
);

-- Permissions

ALTER TABLE cjams.publicproviderpetinfo OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.publicproviderpetinfo TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.providerformconfig CASCADE;

CREATE TABLE cjams.providerformconfig (
	template_id uuid NOT NULL DEFAULT gen_random_uuid(),
	external_template_id varchar(50) NULL,
	template_nm varchar(50) NULL,
	template_description varchar(500) NULL,
	template_category varchar(50) NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	CONSTRAINT pk_providerformconfig PRIMARY KEY (template_id)
);

-- Permissions

ALTER TABLE cjams.providerformconfig OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.providerformconfig TO welfareadmin;

-----

DROP TABLE IF EXISTS cjams.providerformdetails CASCADE;

CREATE TABLE cjams.providerformdetails (
	form_detail_id uuid NOT NULL DEFAULT gen_random_uuid(),
	template_id uuid NULL,
	provider_id varchar(50) NULL,
	form_data jsonb NULL,
	create_ts timestamp NOT NULL DEFAULT now(),
	create_user_id varchar(50) NULL,
	update_ts timestamp NOT NULL DEFAULT now(),
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar,
	active_flag int4 NOT NULL DEFAULT 1,
	object_id varchar(50) NULL,
	CONSTRAINT pk_providerformdetails PRIMARY KEY (form_detail_id)
);

-- Permissions

ALTER TABLE cjams.providerformdetails OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.providerformdetails TO welfareadmin;