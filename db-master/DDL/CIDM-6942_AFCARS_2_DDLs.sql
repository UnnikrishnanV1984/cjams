-- B-157535 CJAMS-CW- AFCARS 2.0 XML Development User story (CIDM-6942)

-- cjams.personeducationalertactions definition

-- New Tables

-- Removals:
-- cjams.afcars_fc_child_removals definition
DROP TABLE if EXISTS cjams.afcars_fc_child_removals;
CREATE TABLE cjams.afcars_fc_child_removals (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	E3_local_agency varchar NULL,
	E69_removal_date varchar NULL, 
	E70_removal_transaction_date varchar NULL, 
	E71_removal_environment varchar NULL, 
	E72_runaway varchar NULL, 
	E73_whereabouts_unknown varchar NULL, 
	E74_physical_abuse varchar NULL, 
	E75_sexual_abuse varchar NULL, 
	E76_psychological_abuse varchar NULL, 
	E77_neglect varchar NULL, 
	E78_medical_neglect varchar NULL, 
	E79_domestic_violence varchar NULL, 
	E80_abandonment varchar NULL, 
	E81_failure_to_return varchar NULL, 
	E82_caretaker_alcohol_use varchar NULL, 
	E83_caretaker_drug_use varchar NULL, 
	E84_child_alcohol_use varchar NULL, 
	E85_child_drug_use varchar NULL, 
	E86_prenatal_alcohol_exposure varchar NULL, 
	E87_prenatal_drug_exposure varchar NULL, 
	E88_diagnosed_condition varchar NULL, 
	E89_inadequate_access_to_mental_health varchar NULL, 
	E90_inadequate_access_to_medical_service varchar NULL, 
	E91_child_behavior_problem varchar NULL, 
	E92_death_of_caretaker varchar NULL, 
	E93_incarceration_of_caretaker varchar NULL, 
	E94_caretaker_impairment_physical_emotional varchar NULL, 
	E95_caretaker_impairment_cognitive varchar NULL, 
	E96_inadequate_housing varchar NULL, 
	E97_voluntary_adoption varchar NULL, 
	E98_child_requested_placement varchar NULL, 
	E99_sex_trafficking varchar NULL, 
	E100_parental_immigration_detainment_deportation varchar NULL, 
	E101_family_conflict_gender_orientation varchar NULL, 
	E102_educational_neglect varchar NULL, 
	E103_public_agency_title_iv_agreement varchar NULL, 
	E104_tribal_agreement varchar NULL, 
	E105_homelessness varchar NULL, 
	E153_exit_date varchar NULL, 
	E154_exit_transaction_date varchar NULL, 
	E155_exit_reason varchar NULL, 
	E156_transfer_to_another_agency varchar NULL, 
	removalid varchar NULL,
	cjamspid varchar NULL,
	caseid varchar NULL,
	current_period_removal_sw varchar(1) NULL	
	);
CREATE INDEX afcars_fc_child_removals_idx ON cjams.afcars_fc_child_removals USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_child_rem_afc_idx ON cjams.afcars_fc_child_removals USING btree (removalid, afcarsfostercareid);

COMMENT ON COLUMN cjams.afcars_fc_child_removals.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E3_local_agency IS 'State Local Agency (5-digit State FIPS Code)';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E69_removal_date IS 'Removal Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E70_removal_transaction_date IS 'Removal Transaction Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E71_removal_environment IS 'Removal Environment';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E72_runaway IS 'Runaway Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E73_whereabouts_unknown IS 'Whereabouts Unknown Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E74_physical_abuse IS 'Physical Abuse Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E75_sexual_abuse IS 'Sexual Abuse Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E76_psychological_abuse IS 'Psychological Abuse Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E77_neglect IS 'Neglect Abuse Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E78_medical_neglect IS 'Medical Neglect Abuse Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E79_domestic_violence IS 'Domestic Violence Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E80_abandonment IS 'Abandonment Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E81_failure_to_return IS 'Failure To Return Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E82_caretaker_alcohol_use IS 'Caretaker Alcohol Use Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E83_caretaker_drug_use IS 'Caretaker Drug Use Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E84_child_alcohol_use IS 'Child Alcohol Use Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E85_child_drug_use IS 'Child Drug Use Circumstances for the Removal';	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E86_prenatal_alcohol_exposure IS 'Prenatal Alcohol Exposure Circumstances for the Removal';	  
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E87_prenatal_drug_exposure IS 'Prenatal Drug Exposure Circumstances for the Removal';	  
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E88_diagnosed_condition IS 'Diagnosed Condition Circumstances for the Removal';	  
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E89_inadequate_access_to_mental_health IS 'Inadequate Access To Mental Health Circumstances for the Removal';	  	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E90_inadequate_access_to_medical_service IS 'Inadequate Access To Medical Dervice Circumstances for the Removal';	  	 	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E91_child_behavior_problem IS 'Child Behavior Problem Circumstances for the Removal';	
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E92_death_of_caretaker IS 'Death of Caretaker Circumstances for the Removal';	
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E93_incarceration_of_caretaker IS 'Incarceration of Caretaker Circumstances for the Removal';	
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E94_caretaker_impairment_physical_emotional IS 'Caretaker Impairment Physical Emotional Circumstances for the Removal';	
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E95_caretaker_impairment_cognitive IS 'Caretaker Impairment Cognitive Circumstances for the Removal';	
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E96_inadequate_housing IS 'Inadequate Housing Circumstances for the Removal';	
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E97_voluntary_adoption IS 'Voluntary Adoption Circumstances for the Removal';		 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E98_child_requested_placement IS 'Child Requested Placement Circumstances for the Removal';		 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E99_sex_trafficking IS 'Sex Trafficking Circumstances for the Removal';		 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E100_parental_immigration_detainment_deportation IS 'Parental Immigration Detainment Deportation Circumstances for the Removal';		 	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E101_family_conflict_gender_orientation IS 'Family Conflict Gender Rrientation Circumstances for the Removal';		 	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E101_family_conflict_gender_orientation IS 'Family Conflict Gender Rrientation Circumstances for the Removal';		 	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E102_educational_neglect IS 'Educational Neglect Circumstances for the Removal';		 	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E103_public_agency_title_iv_agreement IS 'Public Agency Title IV-E Agreement Circumstances for the Removal';		 	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E104_tribal_agreement IS 'Tribal Agreement Circumstances for the Removal';		 	 
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E105_homelessness IS 'Homelessness Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E153_exit_date IS 'Removal Exit Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E155_exit_reason IS 'Removal Exit Reason';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E154_exit_transaction_date IS 'Removal Exit Transaction Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.E156_transfer_to_another_agency IS 'Client Transfer to Another Agency';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_child_removals.current_period_removal_sw IS 'To Identify Removal is from Current AFCARS Period'; 
 
 
-- Living Arrangement /Placement (Need child table)

-- cjams.afcars_fc_placements definition
DROP TABLE if EXISTS cjams.afcars_fc_placements;
CREATE TABLE cjams.afcars_fc_placements (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	E112_date_living_arrangement varchar NULL,
	E113_foster_family_home varchar NULL, 
	-- FC Provider
	E114_licensed_home varchar NULL,
	E115_therapeutic_home varchar NULL,
	E116_shelter_care_home varchar NULL,
	E117_relative_foster_family varchar NULL,
	E118_pre_adopt_home varchar NULL,
	E119_kin_foster_family varchar NULL,
	-- LA Details
	E120_other_living_arrangement_type varchar NULL,
	E121_location_of_living_arrangement varchar NULL,
	--
	E122_jurisdiction_or_country varchar NULL,
	-- FC Parents 
	E123_marital_status_of_foster_parents varchar NULL,
	E124_relationship_to_foster_parents varchar NULL,
	-- FC Parent 1
	E125_foster_parent1_birth_year varchar NULL,
	E126_foster_parent1_tribal_membership varchar NULL ,
	E127_foster_parent1_race_american_indian_alaska_native varchar NULL, 
	E128_foster_parent1_race_asian varchar NULL,
	E129_foster_parent1_race_black varchar NULL,
	E130_foster_parent1_race_native_hawaiian_pacific_islander varchar NULL,
	E131_foster_parent1_race_white varchar NULL,
	E132_foster_parent1_race_unknown varchar NULL,
	E133_foster_parent1_race_declined varchar NULL,
	E134_foster_parent1_hispanic_latino varchar NULL,
	E135_foster_parent1_sex varchar NULL,
	-- FC Parent 2
	E136_foster_parent2_birth_year varchar NULL,
	E137_foster_parent2_tribal_membership varchar NULL, 
	E138_foster_parent2_race_american_indian_alaska_native varchar NULL,
	E139_foster_parent2_race_asian varchar NULL,
	E140_foster_parent2_race_black varchar NULL,
	E141_foster_parent2_race_native_hawaiian_pacific_islander varchar NULL,
	E142_foster_parent2_race_white varchar NULL,
	E143_foster_parent2_race_unknown varchar NULL,
	E144_foster_parent2_race_declined varchar NULL,
	E145_foster_parent2_hispanic_latino varchar NULL,
	E146_foster_parent2_sex varchar NULL,
	placementid varchar NULL, -- alternetid from placement table
	cjamspid varchar NULL,
	caseid varchar NULL,
	placementtype varchar NULL
	-- latest_removal_sw varchar(1) NULL	
	);
CREATE INDEX afcars_fc_placements_idx ON cjams.afcars_fc_placements USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_placements_rem_afc_idx ON cjams.afcars_fc_placements USING btree (removalid, afcarsfostercareid);
CREATE INDEX afcars_fc_placements_placement_idx ON cjams.afcars_fc_placements USING btree (placementid);
CREATE INDEX afcars_fc_placements_removal_idx ON cjams.afcars_fc_placements USING btree (removalid);


COMMENT ON COLUMN cjams.afcars_fc_placements.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_placements.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_placements.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_placements.E112_date_living_arrangement IS 'Placement Entry Date';
COMMENT ON COLUMN cjams.afcars_fc_placements.E113_foster_family_home IS 'Provider Placement Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements.E114_licensed_home IS 'Provider is Licensed Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements.E115_therapeutic_home IS 'Provider is Therapeutic Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements.E116_shelter_care_home IS 'Provider is Shelter Care Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements.E117_relative_foster_family IS 'Provider is Relative Foster Family Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements.E118_pre_adopt_home IS 'Provider is Pre-adopt Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements.E119_kin_foster_family IS 'Provider is Kinship-foster family Yes/No';
-- LA Details
COMMENT ON COLUMN cjams.afcars_fc_placements.E120_other_living_arrangement_type IS 'Living Arrangement Type';
COMMENT ON COLUMN cjams.afcars_fc_placements.E121_location_of_living_arrangement IS 'Location of Living Arrangement';
--
COMMENT ON COLUMN cjams.afcars_fc_placements.E122_jurisdiction_or_country IS 'Provider Location County';
-- FC Parents 
COMMENT ON COLUMN cjams.afcars_fc_placements.E123_marital_status_of_foster_parents IS 'Marital Status of Foster Parents';
COMMENT ON COLUMN cjams.afcars_fc_placements.E124_relationship_to_foster_parents IS 'Client Relationship to Foster Parents';
-- FC Parent 1
COMMENT ON COLUMN cjams.afcars_fc_placements.E125_foster_parent1_birth_year IS 'First Foster Parent Birth Year';
COMMENT ON COLUMN cjams.afcars_fc_placements.E126_foster_parent1_tribal_membership IS 'First Foster Parent Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_placements.E127_foster_parent1_race_american_indian_alaska_native IS 'Race of First Foster Parent: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_placements.E128_foster_parent1_race_asian IS 'Race of First Foster Parent: Asian';
COMMENT ON COLUMN cjams.afcars_fc_placements.E129_foster_parent1_race_black IS 'Race of First Foster Parent: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_placements.E130_foster_parent1_race_native_hawaiian_pacific_islander IS 'Race of First Foster Parent: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_placements.E131_foster_parent1_race_white IS 'Race of First Foster Parent: White';
COMMENT ON COLUMN cjams.afcars_fc_placements.E132_foster_parent1_race_unknown IS 'Race of First Foster Parent: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_placements.E133_foster_parent1_race_declined IS 'Race of First Foster Parent: Declined';
COMMENT ON COLUMN cjams.afcars_fc_placements.E134_foster_parent1_hispanic_latino IS 'Hispanic or Latino Ethnicity of First Foster Parent';
COMMENT ON COLUMN cjams.afcars_fc_placements.E135_foster_parent1_sex IS 'Gender of First Foster Parent';
-- FC Parent 2
COMMENT ON COLUMN cjams.afcars_fc_placements.E136_foster_parent2_birth_year IS 'Second Foster Parent Birth Year';
COMMENT ON COLUMN cjams.afcars_fc_placements.E137_foster_parent2_tribal_membership IS 'Second Foster Parent Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_placements.E138_foster_parent2_race_american_indian_alaska_native IS 'Race of Second Foster Parent: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_placements.E139_foster_parent2_race_asian IS 'Race of Second Foster Parent: Asian';
COMMENT ON COLUMN cjams.afcars_fc_placements.E140_foster_parent2_race_black IS 'Race of Second Foster Parent: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_placements.E141_foster_parent2_race_native_hawaiian_pacific_islander IS 'Race of Second Foster Parent: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_placements.E142_foster_parent2_race_white IS 'Race of Second Foster Parent: White';
COMMENT ON COLUMN cjams.afcars_fc_placements.E143_foster_parent2_race_unknown IS 'Race of Second Foster Parent: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_placements.E144_foster_parent2_race_declined IS 'Race of Second Foster Parent: Declined';
COMMENT ON COLUMN cjams.afcars_fc_placements.E145_foster_parent2_hispanic_latino IS 'Hispanic or Latino Ethnicity of Second Foster Parent';
COMMENT ON COLUMN cjams.afcars_fc_placements.E146_foster_parent2_sex IS 'Gender of Second Foster Parent';
COMMENT ON COLUMN cjams.afcars_fc_placements.placementid IS 'Foreign key - PK of placement table';
COMMENT ON COLUMN cjams.afcars_fc_placements.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_placements.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_placements.placementtype IS 'PLacement Type - Living Arrangement or Provider Placement';


-- Permanency Plan (Need child table)
-- cjams.afcars_fc_permanency_plans definition
DROP TABLE if EXISTS cjams.afcars_fc_permanency_plans ;
CREATE TABLE cjams.afcars_fc_permanency_plans (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	E147_permanency_plan_date varchar NULL, 
	E148_permanency_plan_type varchar NULL, 
	permanencyplanid varchar NULL, -- PK of permanencyplan table
	cjamspid varchar NULL,
	caseid varchar NULL
	);
CREATE INDEX afcars_fc_permanency_plan_idx ON cjams.afcars_fc_permanency_plans USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_pp_rem_afc_idx ON cjams.afcars_fc_permanency_plans USING btree (removalid, afcarsfostercareid);

COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.E147_permanency_plan_date IS 'Permanency Plan Established Date';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.E148_permanency_plan_type IS 'Type of Permanency Plan';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.permanencyplanid IS 'Foreign key - PK of permanencyplan table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans.cjamspid IS 'CJAMS Service Case Number';

-- Periodic Reviews (Need child table)
DROP TABLE if EXISTS cjams.afcars_fc_periodic_reviews ;
CREATE TABLE cjams.afcars_fc_periodic_reviews (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	E149_periodic_review_date varchar NULL, -- hearingdatetime 
	intakeservicerequestcourthearingid varchar NULL, -- PK of intakeservicerequestcourthearing table ??? 
	cjamspid varchar NULL,
	caseid varchar NULL
	);
CREATE INDEX afcars_fc_periodic_reviews_idx ON cjams.afcars_fc_periodic_reviews USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_pr_rem_afc_idx ON cjams.afcars_fc_periodic_reviews USING btree (removalid, afcarsfostercareid);

COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews.E149_periodic_review_date IS 'Periodic Review Date';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews.intakeservicerequestcourthearingid IS 'Foreign key - PK of intakeservicerequestcourthearing table';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews.cjamspid IS 'CJAMS Service Case Number';

-- Permanency Hearings 	(Need child table)
DROP TABLE if EXISTS cjams.afcars_fc_permanency_hearings ;
CREATE TABLE cjams.afcars_fc_permanency_hearings (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	E150_permanency_hearing_date varchar NULL, -- hearingdatetime ??? 
	intakeservicerequestcourthearingid varchar NULL, -- PK of intakeservicerequestcourthearing table ??? 
	cjamspid varchar NULL,
	caseid varchar NULL
	-- latest_removal_sw varchar(1) NULL	
	);
CREATE INDEX afcars_fc_permanency_hearing_idx ON cjams.afcars_fc_permanency_hearings USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_ph_rem_afc_idx ON cjams.afcars_fc_permanency_hearings USING btree (removalid, afcarsfostercareid);

COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings.E150_permanency_hearing_date IS 'Permanency Hearing Date';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings.intakeservicerequestcourthearingid IS 'Foreign key - PK of intakeservicerequestcourthearing table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings.cjamspid IS 'CJAMS Service Case Number';

-- Case Worker Visit (Need child table)
DROP TABLE if EXISTS cjams.afcars_fc_caseworker_visits ;
CREATE TABLE cjams.afcars_fc_caseworker_visits (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	E151_case_worker_visit_date varchar NULL, 
	E152_case_worker_visit_location varchar NULL, 
	progressnoteid varchar NULL, -- progressnoteid from progressnote table
	cjamspid varchar NULL,
	caseid varchar NULL
	-- latest_removal_sw varchar(1) NULL	
	);
CREATE INDEX afcars_fc_cw_visits_idx ON cjams.afcars_fc_caseworker_visits USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_cw_visits_rem_afc_idx ON cjams.afcars_fc_caseworker_visits USING btree (removalid, afcarsfostercareid);

COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.E151_case_worker_visit_date IS 'Case Worker Visit Date';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.E152_case_worker_visit_location IS 'Location of Case Worker Visit';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.progressnoteid IS 'Foreign key - PK of progressnote table';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits.cjamspid IS 'CJAMS Service Case Number';


-- Adoptive Parents (Need child table)
DROP TABLE if EXISTS cjams.afcars_fc_adoptive_parents_info ;
CREATE TABLE cjams.afcars_fc_adoptive_parents_info (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	E157_marital_status_of_adoptive_parents varchar NULL,
	E158_relationship_to_adoptive_parents_relative varchar NULL, 
	E159_relationship_to_adoptive_parents_kin varchar NULL, 
	E160_relationship_to_adoptive_parents_non_relative varchar NULL, 
	E161_relationship_to_adoptive_parents_foster_parent varchar NULL, 
	E162_adoptive_parent1_birth_date varchar NULL,
	E163_adoptive_parent1_tribal_membership varchar NULL, 
	E164_adoptive_parent1_race_american_indian_alaska_native varchar NULL,
	E165_adoptive_parent1_race_asian varchar NULL, 
	E166_adoptive_parent1_race_black varchar NULL, 
	E167_adoptive_parent1_race_native_hawaiian_pacific_islander varchar NULL, 
	E168_adoptive_parent1_race_white varchar NULL, 
	E169_adoptive_parent1_race_unknown varchar NULL, 
	E170_adoptive_parent1_race_declined varchar NULL, 
	E171_adoptive_parent1_hispanic_latino varchar NULL, 
	E172_adoptive_parent1_sex varchar NULL, 
	E173_adoptive_parent2_birth_date varchar NULL, 
	E174_adoptive_parent2_tribal_membership varchar NULL, 
	E175_adoptive_parent2_race_american_indian_alaska_native varchar NULL, 
	E176_adoptive_parent2_race_asian varchar NULL, 
	E177_adoptive_parent2_race_black varchar NULL, 
	E178_adoptive_parent2_race_native_hawaiian_pacific_islander varchar NULL, 
	E179_adoptive_parent2_race_white varchar NULL, 
	E180_adoptive_parent2_race_unknown varchar NULL, 
	E181_adoptive_parent2_race_declined varchar NULL, 
	E182_adoptive_parent2_hispanic_latino varchar NULL, 
	E183_adoptive_parent2_sex varchar NULL, 
	E184_inter_intrajurisdictional_adoption varchar NULL,  
	E185_assistance_agreement_type varchar NULL,  
	E186_siblings_in_adoptive_home varchar NULL,  
	adoption_cjamspid varchar NULL,
	adoption_casenumber varchar NULL,
	cjamspid varchar NULL,
	caseid varchar NULL,
	adoption_gap_casetype varchar NULL
	-- latest_removal_sw varchar(1) NULL	
	);
CREATE INDEX afcars_fc_adoptive_parents_idx ON cjams.afcars_fc_adoptive_parents_info USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_adoptive_parents_rem_afc_idx ON cjams.afcars_fc_adoptive_parents_info USING btree (removalid, afcarsfostercareid);

COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E162_adoptive_parent1_birth_date IS 'Adoptive Parent 1_Birth Date';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E163_adoptive_parent1_tribal_membership IS 'Adoptive Parent 1 Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E164_adoptive_parent1_race_american_indian_alaska_native IS 'Race of Adoptive Parent 1: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E165_adoptive_parent1_race_asian IS 'Race of Adoptive Parent 1: Asian';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E166_adoptive_parent1_race_black IS 'Race of Adoptive Parent 1: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E167_adoptive_parent1_race_native_hawaiian_pacific_islander IS 'Race of Adoptive Parent 1: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E168_adoptive_parent1_race_white IS 'Race of Adoptive Parent 1: White';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E169_adoptive_parent1_race_unknown IS 'Race of Adoptive Parent 1: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E170_adoptive_parent1_race_declined IS 'Race of Adoptive Parent 1: Declined';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E171_adoptive_parent1_hispanic_latino IS 'Adoptive Parent 1 is Hispanic Latino';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E172_adoptive_parent1_sex IS 'Adoptive Parent 1 Gender';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E173_adoptive_parent2_birth_date IS 'Adoptive Parent 2_Birth Date';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E174_adoptive_parent2_tribal_membership IS 'Adoptive Parent 2 Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E175_adoptive_parent2_race_american_indian_alaska_native  IS 'Race of Adoptive Parent 2: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E176_adoptive_parent2_race_asian IS 'Race of Adoptive Parent 2: Asian';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E177_adoptive_parent2_race_black IS 'Race of Adoptive Parent 2: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E178_adoptive_parent2_race_native_hawaiian_pacific_islander IS 'Race of Adoptive Parent 2: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E179_adoptive_parent2_race_white IS 'Race of Adoptive Parent 2: White';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E180_adoptive_parent2_race_unknown IS 'Race of Adoptive Parent 2: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E181_adoptive_parent2_race_declined IS 'Race of Adoptive Parent 2: Declined';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E182_adoptive_parent2_hispanic_latino IS 'Adoptive Parent 2 is Hispanic Latino';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E183_adoptive_parent2_sex IS 'Adoptive Parent 2 Gender';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E184_inter_intrajurisdictional_adoption IS 'Adoptive is Intrajurisdictional';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E185_assistance_agreement_type IS 'Adoptive Type is Assistance Agreement';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.E186_siblings_in_adoptive_home IS 'Siblings are in same Adoptive Home';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.adoption_cjamspid IS 'CJAMS Adoption Client Number';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.adoption_casenumber IS 'CJAMS Adoption Case Number';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info.adoption_gap_casetype IS 'CJAMS Case Type Adoption or GAP';


-- Sex Trafficking  (Need child table)
DROP TABLE if EXISTS cjams.afcars_fc_sex_trafficking ;
CREATE TABLE cjams.afcars_fc_sex_trafficking (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	E106_prior_victim_sex_trafficking varchar NULL, 
	E107_prior_victim_sex_trafficking_reported varchar NULL, 
	E108_prior_victim_sex_trafficking_reported_date varchar NULL, 
	E109_victim_sex_trafficking varchar NULL, 
	E110_victim_sex_trafficking_reported varchar NULL,
	E111_victim_sex_trafficking_reported_date varchar NULL, 
	cjamspid varchar NULL,
	caseid varchar NULL
	-- latest_removal_sw varchar(1) NULL	
	);
CREATE INDEX afcars_fc_sex_trafficking_idx ON cjams.afcars_fc_sex_trafficking USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_sex_traf_parents_rem_afc_idx ON cjams.afcars_fc_sex_trafficking USING btree (removalid, afcarsfostercareid);

COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.E106_prior_victim_sex_trafficking IS 'Prior Sex Trafficking Flag';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.E107_prior_victim_sex_trafficking_reported IS 'Prior Sex Trafficking Reported';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.E108_prior_victim_sex_trafficking_reported_date IS 'Prior Sex Trafficking Reported Date';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.E109_victim_sex_trafficking IS 'Sex Trafficking Flag';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.E110_victim_sex_trafficking_reported IS 'Sex Trafficking Reported';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.E111_victim_sex_trafficking_reported_date IS 'Sex Trafficking Reported Date';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking.cjamspid IS 'CJAMS Service Case Number';


-- New Table for Child level Data
DROP TABLE if EXISTS cjams.afcars_fc_client_data ;
CREATE TABLE cjams.afcars_fc_client_data (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	cjamspid varchar NULL,
	E1_title_iv_agency varchar NULL,
	E2_report_date varchar NULL,
	E3_local_agency varchar NULL,
	E4_child_record_number varchar NULL,
	E5_date_of_birth varchar NULL,
	E6_sex varchar NULL, 
	E7_agency_made_inquiries varchar NULL,
	E8_tribal_membership varchar NULL,
	E10_icwa varchar NULL,
	E11_icwa_date varchar NULL, 
	E12_icwa_notification varchar NULL, 
	E13_child_race_american_indian_alaska_native varchar NULL, 
	E14_child_race_asian varchar NULL, 
	E15_child_race_black varchar NULL, 
	E16_child_race_native_hawaiian_pacific_islander varchar NULL, 
	E17_child_race_white varchar NULL, 
	E18_child_race_unknown varchar NULL,
	E19_child_race_abandoned varchar NULL, 
	E20_child_race_declined varchar NULL,
	E21_child_hispanic_latino varchar NULL, 
	E22_health_assessment varchar NULL,
	E23_health_conditions varchar NULL, 
	E24_health_intellectual_disability varchar NULL, 
	E25_health_autism_spectrum_disorder varchar NULL, 
	E26_health_visual_impairment varchar NULL, 
	E27_health_hearing_impairment varchar NULL, 
	E28_health_orthopedic_impairment varchar NULL, 
	E29_health_mental_disorder varchar NULL,
	E30_health_adhd_add varchar NULL, 
	E31_health_serious_mental_disorder varchar NULL, 
	E32_health_developmental_delay varchar NULL, 
	E33_health_developmental_disability varchar NULL, 
	E34_health_other_condition varchar NULL,
	E35_school_enrollment varchar NULL, 
	E36_school_highest_completed varchar NULL, 
	E37_school_special_education varchar NULL,
	E38_pregnant varchar NULL, 
	E39_fathered_or_bore_child varchar NULL, 
	E40_child_and_children_together varchar NULL,
	E41_prior_adoption varchar NULL,
	E42_prior_adoption_date varchar NULL, 
	E43_prior_adoption_intercountry varchar NULL, 
	E44_prior_guardianship varchar NULL,
	E45_prior_guardianship_date varchar NULL, 
	E46_support_assistance varchar NULL, 
	E47_state_tribal_adoption_assistance varchar NULL, 
	E48_state_tribal_foster_care varchar NULL,
	E49_adoption_subsidy varchar NULL, 
	E50_guardianship_assistance varchar NULL,
	E51_tanf_assistance varchar NULL, 
	E52_title_iv_b varchar NULL, 
	E53_chafee_foster_program varchar NULL, 
	E54_other_financial_support varchar NULL,
	E55_foster_care_payment varchar NULL, 
	E56_total_siblings varchar NULL, 
	E57_siblings_in_foster_care varchar NULL, 
	E58_siblings_in_living_arrangement varchar NULL, 
	E59_first_parent_birth_year varchar NULL, 
	E60_second_parent_birth_year varchar NULL, 
	E61_tribal_membership_mother varchar NULL,
	E62_tribal_membership_father varchar NULL,
	E63_tpr_parent1 varchar NULL, 
	E64_tpr_parent2 varchar NULL, 
	E65_tpr_petition_date_parent1 varchar NULL, 
	E66_tpr_petition_date_parent2 varchar NULL, 
	E67_tpr_date_parent1 varchar NULL, 
	E68_tpr_date_parent2 varchar NULL 
	);
CREATE INDEX afcars_fc_client_data_idx ON cjams.afcars_fc_client_data USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_client_data_cjamspid_idx ON cjams.afcars_fc_client_data USING btree (cjamspid);

COMMENT ON COLUMN cjams.afcars_fc_client_data.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_client_data.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_client_data.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E1_title_iv_agency IS 'Title IV-E Agency (2-digit State FIPS Code)';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E2_report_date IS 'AFCARS Report Date';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E3_local_agency IS 'State Local Agency (5-digit State FIPS Code)';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E4_child_record_number IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E5_date_of_birth IS 'Client Date of Birth';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E6_sex IS 'Client Gender'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E7_agency_made_inquiries IS 'ICWA Status Inquiry Made by the Agency';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E8_tribal_membership IS 'Client is part of the Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E10_icwa IS 'Is Client ICWA under definition';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E11_icwa_date IS 'Date of ICWA Applies Notification'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E12_icwa_notification IS 'Indicate whether Legal Notice was sent to the Tribe'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E13_child_race_american_indian_alaska_native IS 'Client Race American Indian or Alaska Native'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E14_child_race_asian IS 'Client Race Asian'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E15_child_race_black IS 'Client Race Black or African American'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E16_child_race_native_hawaiian_pacific_islander IS 'Client Race Native Hawaiian or Other Pacific Islander'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E17_child_race_white IS 'Client Race White'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E18_child_race_unknown IS 'Client Race Unknown';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E19_child_race_abandoned IS 'Client Race Abandoned'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E20_child_race_declined IS 'Client Race Declined';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E21_child_hispanic_latino IS 'Client Ethnicity Hispanic or Latino'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E22_health_assessment IS 'Client Health Assessment Info Available';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E23_health_conditions IS 'Client Health Conditions'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E24_health_intellectual_disability IS 'Client is having Intellectual Disability'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E25_health_autism_spectrum_disorder IS 'Client is having Autism Spectrum Disorder'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E26_health_visual_impairment IS 'Client is having Visual Impairment and Blindness'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E27_health_hearing_impairment IS 'Client is having Hearing Impairment and Deafness'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E28_health_orthopedic_impairment IS 'Client is having Orthopedic Impairment or Other Physical Condition'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E29_health_mental_disorder IS 'Client is having Mental/Emotional Disorders';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E30_health_adhd_add IS 'Client is having Attention Deficit Hyperactivity Disorder'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E31_health_serious_mental_disorder IS 'Client is having Serious Mental Disorders'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E32_health_developmental_delay IS 'Client is having Developmental Delay'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E33_health_developmental_disability IS 'Client is having Developmental Disability'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E34_health_other_condition IS 'Client is having Other Diagnosed Condition';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E35_school_enrollment IS 'Client School Enrollment Status'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E36_school_highest_completed IS 'Highest Educational Level Completed'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E37_school_special_education IS 'Enrollment in Special Education';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E38_pregnant IS 'Client is Pregnant'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E39_fathered_or_bore_child IS 'Client Ever Fathered or Bore Children'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E40_child_and_children_together IS 'Child and His/Her Child(ren) Placed Together ';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E41_prior_adoption IS 'Client was Adopted Prior to this Removal';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E42_prior_adoption_date IS 'Prior Adoption Date'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E43_prior_adoption_intercountry IS 'Prior Adoption was Intercountry'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E44_prior_guardianship IS 'Client was under Guardianship Prior to this Removal';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E45_prior_guardianship_date IS 'Prior Guardianship Date'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E46_support_assistance IS 'Client is receiving Support/Assistance'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E47_state_tribal_adoption_assistance IS 'Client is receiving State/Tribal Adoption Assistance'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E48_state_tribal_foster_care IS 'Client is receiving State/Tribal Foster Care';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E49_adoption_subsidy IS 'Client is receiving Title IV-E Adoption Subsidy'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E50_guardianship_assistance IS 'Client is receiving Title IV-E Guardianship Assistance';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E51_tanf_assistance IS 'Client is receiving Title IV-A TANF Assistance'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E52_title_iv_b IS 'Client is receiving Title IV-B Assistance'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E53_chafee_foster_program IS 'Client is receiving Chafee Foster Care Independence Program Assistance'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E54_other_financial_support IS 'Client is receiving Other Financial Support';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E55_foster_care_payment IS 'Client is receiving Foster Care Maintenance Payment'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E56_total_siblings IS 'Client''s Total Number of Siblings'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E57_siblings_in_foster_care IS 'Client''s Siblings in Foster Care'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E58_siblings_in_living_arrangement IS 'Client''s Siblings in Living Arrangement'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E59_first_parent_birth_year IS 'Year of Birth of First Parent or Legal Guardian'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E60_second_parent_birth_year IS 'Year of Birth of Second Parent or Legal Guardian'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E61_tribal_membership_mother IS 'Tribal Membership of the Mother';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E62_tribal_membership_father IS 'Tribal Membership of the Father';
COMMENT ON COLUMN cjams.afcars_fc_client_data.E63_tpr_parent1 IS 'Termination of Parental Rights Decison for First Parent'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E64_tpr_parent2 IS 'Termination of Parental Rights Decison for Second Parent'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E65_tpr_petition_date_parent1 IS 'Termination of Parental Rights Petition Date for First Parent'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E66_tpr_petition_date_parent2 IS 'Termination of Parental Rights Petition Date for Second Parent'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E67_tpr_date_parent1 IS 'Termination of Parental Rights Petition Date for First Parent'; 
COMMENT ON COLUMN cjams.afcars_fc_client_data.E68_tpr_date_parent2 IS 'Termination of Parental Rights Date for Second Parent';

-- Federally Recognized Tribe (Need child table) 
DROP TABLE if EXISTS cjams.afcars_fc_recognized_tribes ;
CREATE TABLE cjams.afcars_fc_recognized_tribes (
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	cjamspid varchar NULL,
	E9_recognized_tribes varchar NULL
	);
CREATE INDEX afcars_fc_cw_visit_idx ON cjams.afcars_fc_recognized_tribes USING btree (afcarsfostercareid);
CREATE INDEX afcars_fc_cw_visit_cjamspid_idx ON cjams.afcars_fc_recognized_tribes USING btree (cjamspid);

COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes.E9_recognized_tribes IS 'Client belongs to Federally Recognized Tribe (Tribal Standard Code)';

-- Modifiy afcarsadoptiondetail
-- Child Race: Abandoned
ALTER TABLE cjams.afcarsadoptiondetail ADD COLUMN IF NOT EXISTS A12_child_race_abandoned varchar NULL;
COMMENT ON COLUMN cjams.afcarsadoptiondetail.A12_child_race_abandoned IS 'Client Race Abandoned'; 

-- Childs Race: Declined 	
ALTER TABLE cjams.afcarsadoptiondetail ADD COLUMN IF NOT EXISTS A13_child_race_declined varchar NULL;
COMMENT ON COLUMN cjams.afcarsadoptiondetail.A13_child_race_declined IS 'Client Race Declined';

-- Assistance Agreement Type
-- 1 = Adoption 
-- 2 = Guardianship 
ALTER TABLE cjams.afcarsadoptiondetail ADD COLUMN IF NOT EXISTS A15_assistance_agreement_type varchar NULL;
COMMENT ON COLUMN cjams.afcarsadoptiondetail.A15_assistance_agreement_type IS 'Subsidy Type 1 = Adoption and 2 = GAP';

-- Adoption Agreement Start Date
ALTER TABLE cjams.afcarsadoptiondetail ADD COLUMN IF NOT EXISTS Agreement_Start_date varchar NULL;
COMMENT ON COLUMN cjams.afcarsadoptiondetail.Agreement_Start_date IS 'Adoption Agreement Start Date';

-- Adoption Agreement End Date (Agreement Termination Date)
ALTER TABLE cjams.afcarsadoptiondetail ADD COLUMN IF NOT EXISTS A18_agreement_termination_date varchar NULL;
COMMENT ON COLUMN cjams.afcarsadoptiondetail.A18_agreement_termination_date IS 'Adoption Agreement End Date';

