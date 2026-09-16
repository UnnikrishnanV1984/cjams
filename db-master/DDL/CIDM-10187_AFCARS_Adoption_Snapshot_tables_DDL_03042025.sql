-- CIDM-10187 -- AFCARS Data Improvements
-- New snapshot tables to capture the AFCARS FC transaction history

-- DROP SEQUENCE if exists cjams.sq_afcars_history;
CREATE SEQUENCE cjams.sq_afcars_history
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;
								
-- AFCARS Fostercare 

-- DROP TABLE cjams.afcarsfostercaresummary_history;

CREATE TABLE cjams.afcarsfostercaresummary_history (
	afcarsfostercaresummaryhistoryid uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercaresummaryid int8 NULL,
	totalnorecords varchar(20) NULL,
	periodendingdate varchar(20) NULL,
	chunderoneyear varchar(20) NULL,
	choneyear varchar(20) NULL,
	chtwoyear varchar(20) NULL,
	chthreeyear varchar(20) NULL,
	chfouryear varchar(20) NULL,
	chfiveyear varchar(20) NULL,
	chsixyear varchar(20) NULL,
	chsevenyear varchar(20) NULL,
	cheightyear varchar(20) NULL,
	chnineyear varchar(20) NULL,
	chtenyear varchar(20) NULL,
	chelevenyear varchar(20) NULL,
	chtwelveyear varchar(20) NULL,
	chthirteenyear varchar(20) NULL,
	chfourteenyear varchar(20) NULL,
	chfifteenyear varchar(20) NULL,
	chsixteenyear varchar(20) NULL,
	chseventeenyear varchar(20) NULL,
	cheighteenyear varchar(20) NULL,
	chovereighteenyear varchar(20) NULL,
	insertedon timestamp NULL,
	insertedby varchar(10) NULL,
	updatedon timestamp NULL,
	updatedby varchar(10) NULL,
	activeflag int4 NULL,
	old_id varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT afcarsfostercaresummary_history_pkey PRIMARY KEY (afcarsfostercaresummaryhistoryid)
);
CREATE INDEX afcarsfostercaresummary_history_idx ON cjams.afcarsfostercaresummary_history USING btree(afcars_history_id);

COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.afcarsfostercaresummaryhistoryid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.afcarsfostercaresummaryid IS 'Original PK of transaction table';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.totalnorecords IS 'Total number of children in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.periodendingdate IS 'AFCARS Submission Period';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chunderoneyear IS 'Total number of children under one year in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.choneyear IS 'Total number of children one year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chtwoyear IS 'Total number of children two year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chthreeyear IS 'Total number of children three year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chfouryear IS 'Total number of children four year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chfiveyear IS 'Total number of children five year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chsixyear IS 'Total number of children six year old in the AFCARS Submission'; 
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chsevenyear IS 'Total number of children seven year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.cheightyear IS 'Total number of children eigth year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chnineyear IS 'Total number of children nine year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chtenyear IS 'Total number of children ten year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chelevenyear IS 'Total number of children eleven year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chtwelveyear IS 'Total number of children twelve year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chthirteenyear IS 'Total number of children thirteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chfourteenyear IS 'Total number of children fourteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chfifteenyear IS 'Total number of children fifteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chsixteenyear IS 'Total number of children sixteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chseventeenyear IS 'Total number of children seventeen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.cheighteenyear IS 'Total number of children eighteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.chovereighteenyear IS 'Total number of children nineteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.old_id IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.etl_userid IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.etl_load_date IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.afcarsfostercaresummary_history.activeflag IS 'Status of the record - active or inactive.';

-- DROP TABLE cjams.afcarsfostercare_new_history;

CREATE TABLE cjams.afcarsfostercare_new_history (
	afcarsfostercarehistoryid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL,
	statetypekey varchar(50) NULL,
	reportpdenddate varchar NULL,
	localagencytypekey varchar(50) NULL,
	recordno varchar(50) NULL,
	periodicreviewdate varchar NULL,
	childdob varchar(20) NULL,
	gendertypekey varchar(50) NULL,
	raceaitypekey varchar(50) NULL,
	raceasiantypekey varchar(50) NULL,
	raceblacktypekey varchar(50) NULL,
	racehawaiiantypekey varchar(50) NULL,
	racewhitetypekey varchar(50) NULL,
	raceuntypekey varchar(50) NULL,
	hispanictypekey varchar(50) NULL,
	childdiagnosedtypekey varchar(50) NULL,
	mentalretardationtypekey varchar(50) NULL,
	visualhearingtypekey varchar(50) NULL,
	physicaldisabledtypekey varchar(50) NULL,
	emotionaldisturbedtypekey varchar(50) NULL,
	otherdiagnosedconditiontypekey varchar(50) NULL,
	childadoptedtypekey varchar(50) NULL,
	ageadoptionlegalized varchar(20) NULL,
	firstremovaldate varchar NULL,
	numremovals varchar(20) NULL,
	lastdischargedate varchar NULL,
	latestremovaldate varchar NULL,
	removaltransactiondate varchar NULL,
	placementdate varchar NULL,
	numplacement varchar(50) NULL,
	removaltypetypekey varchar(50) NULL,
	physicalabuseflag varchar NULL,
	sexualabuseflag varchar NULL,
	neglectflag varchar NULL,
	paralcoholabuseflag varchar NULL,
	pardrugabuseflag varchar NULL,
	childalcoholabuseflag varchar NULL,
	childdrugabuseflag varchar NULL,
	childdisabilityflag varchar NULL,
	childbehaviorflag varchar NULL,
	parentdeathflag varchar NULL,
	parentincarcerationflag varchar NULL,
	caretakerillnessflag varchar NULL,
	abandonmentflag varchar NULL,
	relinquishmentflag varchar NULL,
	inadequatehousingflag varchar NULL,
	placementsettingtypekey varchar(50) NULL,
	outofstateplacementflag varchar NULL,
	caseplangoaltypekey varchar(50) NULL,
	caretakerfamilystructuretypekey varchar(50) NULL,
	caretaker1birthyear varchar(20) NULL,
	caretaker2birthyear varchar(20) NULL,
	mothertprdate varchar NULL,
	fathertprdate varchar NULL,
	fosterfamilystructuretypekey varchar(50) NULL,
	fostercare1birthyear varchar(20) NULL,
	fostercare2birthyear varchar(20) NULL,
	fostercare1raceaitypekey varchar(50) NULL,
	fostercare1raceasiantypekey varchar(50) NULL,
	fostercare1raceblacktypekey varchar(50) NULL,
	fostercare1racehawaiiantypekey varchar(50) NULL,
	fostercare1racewhitetypekey varchar(50) NULL,
	fostercare1raceuntypekey varchar(50) NULL,
	fostercare1hispanictypekey varchar(50) NULL,
	fostercare2raceaitypekey varchar(50) NULL,
	fostercare2raceasiantypekey varchar(50) NULL,
	fostercare2raceblacktypekey varchar(50) NULL,
	fostercare2racehawaiiantypekey varchar(50) NULL,
	fostercare2racewhitetypekey varchar(50) NULL,
	fostercare2raceuntypekey varchar(50) NULL,
	fostercare2hispanictypekey varchar(50) NULL,
	dischargedate varchar NULL,
	dischargetransactiondt varchar NULL,
	dischargereasontypekey varchar(50) NULL,
	ivefostercareflag varchar NULL,
	iveadoptionflag varchar NULL,
	ivaflag varchar NULL,
	ivdflag varchar NULL,
	xixflag varchar NULL,
	ssiorssaflag varchar NULL,
	nofederalsupportflag varchar NULL,
	fostercarepaymentamt varchar(20) NULL,
	insertedon varchar NULL,
	insertedby varchar(10) NULL,
	updatedon varchar NULL,
	updatedby varchar(10) NULL,
	activeflag varchar NULL,
	fk_id varchar(50) NULL,
	caseid varchar NULL,
	placementid varchar NULL,
	removalid varchar NULL,
	datavalidflag varchar NULL,
	old_id varchar(50) NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT afcarsfostercare_new_history_pkey PRIMARY KEY (afcarsfostercarehistoryid)
);
CREATE INDEX afcarsfostercare_new_history_idx ON cjams.afcarsfostercare_new_history USING btree(afcars_history_id);

COMMENT ON COLUMN cjams.afcarsfostercare_new_history.afcarsfostercarehistoryid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.afcarsfostercareid IS 'Original PK of transaction table';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.old_id IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.activeflag IS 'Status of the record - active or inactive.';
/*
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.statetypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.reportpdenddate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.localagencytypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.recordno IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.periodicreviewdate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.childdob IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.gendertypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.raceaitypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.raceasiantypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.raceblacktypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.racehawaiiantypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.racewhitetypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.raceuntypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.hispanictypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.childdiagnosedtypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.mentalretardationtypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.visualhearingtypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.physicaldisabledtypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.emotionaldisturbedtypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.otherdiagnosedconditiontypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.childadoptedtypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.ageadoptionlegalized IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.firstremovaldate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.numremovals IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.lastdischargedate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.latestremovaldate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.removaltransactiondate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.placementdate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.numplacement IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.removaltypetypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.physicalabuseflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.sexualabuseflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.neglectflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.paralcoholabuseflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.pardrugabuseflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.childalcoholabuseflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.childdrugabuseflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.childdisabilityflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.childbehaviorflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.parentdeathflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.parentincarcerationflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.caretakerillnessflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.abandonmentflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.relinquishmentflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.inadequatehousingflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.placementsettingtypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.outofstateplacementflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.caseplangoaltypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.caretakerfamilystructuretypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.caretaker1birthyear IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.caretaker2birthyear IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.mothertprdate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fathertprdate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fosterfamilystructuretypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1birthyear IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2birthyear IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1raceaitypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1raceasiantypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1raceblacktypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1racehawaiiantypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1racewhitetypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1raceuntypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare1hispanictypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2raceaitypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2raceasiantypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2raceblacktypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2racehawaiiantypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2racewhitetypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2raceuntypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercare2hispanictypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.dischargedate IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.dischargetransactiondt IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.dischargereasontypekey IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.ivefostercareflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.iveadoptionflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.ivaflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.ivdflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.xixflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.ssiorssaflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.nofederalsupportflag IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fostercarepaymentamt IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.fk_id IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.caseid IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.placementid IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.removalid IS '';
COMMENT ON COLUMN cjams.afcarsfostercare_new_history.datavalidflag IS '';
*/


-- DROP TABLE cjams.afcarscaresin_history;

CREATE TABLE cjams.afcarscaresin_history (
    historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	id int8 NULL,
	cjamspid int8 NULL,
	cisid varchar(50) NULL,
	removaldate timestamp NULL,
	returndate timestamp NULL,
	activeflag int4 NULL,
	insertedon timestamp NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	insertedby varchar(50) NULL,
	"extract" varchar(50) NULL,
	old_id varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT afcarscaresin_history_pkey PRIMARY KEY (historyid)
);
CREATE INDEX afcarscaresin_history_idx ON cjams.afcarscaresin_history USING btree(afcars_history_id);


COMMENT ON COLUMN cjams.afcarscaresin_history.historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcarscaresin_history.id IS 'Original PK of transaction table';
COMMENT ON COLUMN cjams.afcarscaresin_history.old_id IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarscaresin_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.afcarscaresin_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.afcarscaresin_history.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.afcarscaresin_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.afcarscaresin_history.activeflag IS 'Status of the record - active or inactive.';
COMMENT ON COLUMN cjams.afcarscaresin_history.cjamspid IS 'Unique Idetifier CJAMS Client Record';
COMMENT ON COLUMN cjams.afcarscaresin_history.cisid IS 'CIS CLIENT ID /IRN';
COMMENT ON COLUMN cjams.afcarscaresin_history.removaldate IS 'Child Removal Start Date';
COMMENT ON COLUMN cjams.afcarscaresin_history.returndate IS 'Child Removal End Date';
COMMENT ON COLUMN cjams.afcarscaresin_history."extract" IS 'Formatted String of Child Removal data to interface with E&E';


-- DROP TABLE cjams.afcars_fc_adoptive_parents_info_history;

CREATE TABLE cjams.afcars_fc_adoptive_parents_info_history (
	adoptive_parents_info_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	e157_marital_status_of_adoptive_parents varchar NULL,
	e158_relationship_to_adoptive_parents_relative varchar NULL,
	e159_relationship_to_adoptive_parents_kin varchar NULL,
	e160_relationship_to_adoptive_parents_non_relative varchar NULL,
	e161_relationship_to_adoptive_parents_foster_parent varchar NULL,
	e162_adoptive_parent1_birth_date varchar NULL,
	e163_adoptive_parent1_tribal_membership varchar NULL,
	e164_adoptive_parent1_race_american_indian_alaska_native varchar NULL,
	e165_adoptive_parent1_race_asian varchar NULL,
	e166_adoptive_parent1_race_black varchar NULL,
	e167_adoptive_parent1_race_native_hawaiian_pacific_islander varchar NULL, 
	e168_adoptive_parent1_race_white varchar NULL,
	e169_adoptive_parent1_race_unknown varchar NULL,
	e170_adoptive_parent1_race_declined varchar NULL,
	e171_adoptive_parent1_hispanic_latino varchar NULL,
	e172_adoptive_parent1_sex varchar NULL,
	e173_adoptive_parent2_birth_date varchar NULL,
	e174_adoptive_parent2_tribal_membership varchar NULL,
	e175_adoptive_parent2_race_american_indian_alaska_native varchar NULL,
	e176_adoptive_parent2_race_asian varchar NULL,
	e177_adoptive_parent2_race_black varchar NULL,
	e178_adoptive_parent2_race_native_hawaiian_pacific_islander varchar NULL, 
	e179_adoptive_parent2_race_white varchar NULL, 
	e180_adoptive_parent2_race_unknown varchar NULL,
	e181_adoptive_parent2_race_declined varchar NULL,
	e182_adoptive_parent2_hispanic_latino varchar NULL,
	e183_adoptive_parent2_sex varchar NULL,
	e184_inter_intrajurisdictional_adoption varchar NULL,
	e185_assistance_agreement_type varchar NULL, 
	e186_siblings_in_adoptive_home varchar NULL, 
	adoption_cjamspid varchar NULL, 
	adoption_casenumber varchar NULL, 
	cjamspid varchar NULL, 
	caseid varchar NULL,
	adoption_gap_casetype varchar NULL, 
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT adoptive_parents_info_history_pkey PRIMARY KEY (adoptive_parents_info_historyid)
);
CREATE INDEX adoptive_parents_info_history_idx ON cjams.afcars_fc_adoptive_parents_info_history USING btree (afcars_history_id);


COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e162_adoptive_parent1_birth_date IS 'Adoptive Parent 1_Birth Date';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e163_adoptive_parent1_tribal_membership IS 'Adoptive Parent 1 Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e164_adoptive_parent1_race_american_indian_alaska_native IS 'Race of Adoptive Parent 1: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e165_adoptive_parent1_race_asian IS 'Race of Adoptive Parent 1: Asian';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e166_adoptive_parent1_race_black IS 'Race of Adoptive Parent 1: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e167_adoptive_parent1_race_native_hawaiian_pacific_islander IS 'Race of Adoptive Parent 1: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e168_adoptive_parent1_race_white IS 'Race of Adoptive Parent 1: White';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e169_adoptive_parent1_race_unknown IS 'Race of Adoptive Parent 1: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e170_adoptive_parent1_race_declined IS 'Race of Adoptive Parent 1: Declined';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e171_adoptive_parent1_hispanic_latino IS 'Adoptive Parent 1 is Hispanic Latino';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e172_adoptive_parent1_sex IS 'Adoptive Parent 1 Gender';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e173_adoptive_parent2_birth_date IS 'Adoptive Parent 2_Birth Date';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e174_adoptive_parent2_tribal_membership IS 'Adoptive Parent 2 Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e175_adoptive_parent2_race_american_indian_alaska_native IS 'Race of Adoptive Parent 2: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e176_adoptive_parent2_race_asian IS 'Race of Adoptive Parent 2: Asian';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e177_adoptive_parent2_race_black IS 'Race of Adoptive Parent 2: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e178_adoptive_parent2_race_native_hawaiian_pacific_islander IS 'Race of Adoptive Parent 2: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e179_adoptive_parent2_race_white IS 'Race of Adoptive Parent 2: White';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e180_adoptive_parent2_race_unknown IS 'Race of Adoptive Parent 2: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e181_adoptive_parent2_race_declined IS 'Race of Adoptive Parent 2: Declined';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e182_adoptive_parent2_hispanic_latino IS 'Adoptive Parent 2 is Hispanic Latino';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e183_adoptive_parent2_sex IS 'Adoptive Parent 2 Gender';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e184_inter_intrajurisdictional_adoption IS 'Adoptive is Intrajurisdictional';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e185_assistance_agreement_type IS 'Adoptive Type is Assistance Agreement';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.e186_siblings_in_adoptive_home IS 'Siblings are in same Adoptive Home';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.adoption_cjamspid IS 'CJAMS Adoption Client Number';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.adoption_casenumber IS 'CJAMS Adoption Case Number';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.adoption_gap_casetype IS 'CJAMS Case Type Adoption or GAP';
COMMENT ON COLUMN cjams.afcars_fc_adoptive_parents_info_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcars_fc_caseworker_visits_history;

CREATE TABLE cjams.afcars_fc_caseworker_visits_history (
	caseworker_visits_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL, 
	removalid varchar NULL,
	e151_case_worker_visit_date varchar NULL, 
	e152_case_worker_visit_location varchar NULL, 
	progressnoteid varchar NULL,
	cjamspid varchar NULL, 
	caseid varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT caseworker_visits_history_pkey PRIMARY KEY (caseworker_visits_historyid)
);
CREATE INDEX caseworker_visits_history_idx ON cjams.afcars_fc_caseworker_visits_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.caseworker_visits_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.e151_case_worker_visit_date IS 'Case Worker Visit Date';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.e152_case_worker_visit_location IS 'Location of Case Worker Visit';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.progressnoteid IS 'Foreign key - PK of progressnote table';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_caseworker_visits_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcars_fc_child_removals_history;

CREATE TABLE cjams.afcars_fc_child_removals_history (
    child_removals_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL, 
	recordno varchar(50) NULL, 
	e3_local_agency varchar NULL,
	e69_removal_date varchar NULL, 
	e70_removal_transaction_date varchar NULL, 
	e71_removal_environment varchar NULL, 
	e72_runaway varchar NULL, 
	e73_whereabouts_unknown varchar NULL,
	e74_physical_abuse varchar NULL, 
	e75_sexual_abuse varchar NULL, 
	e76_psychological_abuse varchar NULL,
	e77_neglect varchar NULL, 
	e78_medical_neglect varchar NULL,
	e79_domestic_violence varchar NULL, 
	e80_abandonment varchar NULL, 
	e81_failure_to_return varchar NULL,
	e82_caretaker_alcohol_use varchar NULL,
	e83_caretaker_drug_use varchar NULL, 
	e84_child_alcohol_use varchar NULL, 
	e85_child_drug_use varchar NULL, 
	e86_prenatal_alcohol_exposure varchar NULL, 
	e87_prenatal_drug_exposure varchar NULL, 
	e88_diagnosed_condition varchar NULL, 
	e89_inadequate_access_to_mental_health varchar NULL, 
	e90_inadequate_access_to_medical_service varchar NULL, 
	e91_child_behavior_problem varchar NULL, 
	e92_death_of_caretaker varchar NULL,
	e93_incarceration_of_caretaker varchar NULL, 
	e94_caretaker_impairment_physical_emotional varchar NULL,
	e95_caretaker_impairment_cognitive varchar NULL, 
	e96_inadequate_housing varchar NULL, 
	e97_voluntary_adoption varchar NULL, 
	e98_child_requested_placement varchar NULL, 
	e99_sex_trafficking varchar NULL, 
	e100_parental_immigration_detainment_deportation varchar NULL,
	e101_family_conflict_gender_orientation varchar NULL,
	e102_educational_neglect varchar NULL, 
	e103_public_agency_title_iv_agreement varchar NULL,
	e104_tribal_agreement varchar NULL, 
	e105_homelessness varchar NULL, 
	e153_exit_date varchar NULL, 
	e154_exit_transaction_date varchar NULL, 
	e155_exit_reason varchar NULL, 
	e156_transfer_to_another_agency varchar NULL, 
	removalid varchar NULL, 
	cjamspid varchar NULL, 
	caseid varchar NULL, 
	current_period_removal_sw varchar(1) NULL, 
	bio_cjamspid varchar NULL, 
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT child_removals_history_pkey PRIMARY KEY (child_removals_historyid)
);
CREATE INDEX afcars_fc_child_removals_history_idx ON cjams.afcars_fc_child_removals_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.child_removals_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.history_insertedon is 'History captured date and time';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e3_local_agency IS 'State Local Agency (5-digit State FIPS Code)';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e69_removal_date IS 'Removal Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e70_removal_transaction_date IS 'Removal Transaction Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e71_removal_environment IS 'Removal Environment';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e72_runaway IS 'Runaway Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e73_whereabouts_unknown IS 'Whereabouts Unknown Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e74_physical_abuse IS 'Physical Abuse Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e75_sexual_abuse IS 'Sexual Abuse Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e76_psychological_abuse IS 'Psychological Abuse Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e77_neglect IS 'Neglect Abuse Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e78_medical_neglect IS 'Medical Neglect Abuse Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e79_domestic_violence IS 'Domestic Violence Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e80_abandonment IS 'Abandonment Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e81_failure_to_return IS 'Failure To Return Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e82_caretaker_alcohol_use IS 'Caretaker Alcohol Use Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e83_caretaker_drug_use IS 'Caretaker Drug Use Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e84_child_alcohol_use IS 'Child Alcohol Use Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e85_child_drug_use IS 'Child Drug Use Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e86_prenatal_alcohol_exposure IS 'Prenatal Alcohol Exposure Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e87_prenatal_drug_exposure IS 'Prenatal Drug Exposure Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e88_diagnosed_condition IS 'Diagnosed Condition Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e89_inadequate_access_to_mental_health IS 'Inadequate Access To Mental Health Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e90_inadequate_access_to_medical_service IS 'Inadequate Access To Medical Dervice Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e91_child_behavior_problem IS 'Child Behavior Problem Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e92_death_of_caretaker IS 'Death of Caretaker Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e93_incarceration_of_caretaker IS 'Incarceration of Caretaker Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e94_caretaker_impairment_physical_emotional IS 'Caretaker Impairment Physical Emotional Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e95_caretaker_impairment_cognitive IS 'Caretaker Impairment Cognitive Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e96_inadequate_housing IS 'Inadequate Housing Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e97_voluntary_adoption IS 'Voluntary Adoption Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e98_child_requested_placement IS 'Child Requested Placement Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e99_sex_trafficking IS 'Sex Trafficking Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e100_parental_immigration_detainment_deportation IS 'Parental Immigration Detainment Deportation Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e101_family_conflict_gender_orientation IS 'Family Conflict Gender Rrientation Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e102_educational_neglect IS 'Educational Neglect Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e103_public_agency_title_iv_agreement IS 'Public Agency Title IV-E Agreement Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e104_tribal_agreement IS 'Tribal Agreement Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e105_homelessness IS 'Homelessness Circumstances for the Removal';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e153_exit_date IS 'Removal Exit Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e154_exit_transaction_date IS 'Removal Exit Transaction Date';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e155_exit_reason IS 'Removal Exit Reason';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.e156_transfer_to_another_agency IS 'Client Transfer to Another Agency';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.caseid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.current_period_removal_sw IS 'To Identify Removal is from Current AFCARS Period';
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.bio_cjamspid IS 'CJAMS Bio Client Number';



-- DROP TABLE cjams.afcars_fc_client_data_history;

CREATE TABLE cjams.afcars_fc_client_data_history (
	client_data_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL, 
	recordno varchar(50) NULL, 
	cjamspid varchar NULL, 
	e1_title_iv_agency varchar NULL, 
	e2_report_date varchar NULL, 
	e3_local_agency varchar NULL, 
	e4_child_record_number varchar NULL, 
	e5_date_of_birth varchar NULL, 
	e6_sex varchar NULL, 
	e7_agency_made_inquiries varchar NULL, 
	e8_tribal_membership varchar NULL, 
	e10_icwa varchar NULL,
	e11_icwa_date varchar NULL, 
	e12_icwa_notification varchar NULL, 
	e13_child_race_american_indian_alaska_native varchar NULL,
	e14_child_race_asian varchar NULL, 
	e15_child_race_black varchar NULL, 
	e16_child_race_native_hawaiian_pacific_islander varchar NULL,
	e17_child_race_white varchar NULL,
	e18_child_race_unknown varchar NULL, 
	e19_child_race_abandoned varchar NULL, 
	e20_child_race_declined varchar NULL,
	e21_child_hispanic_latino varchar NULL, 
	e22_health_assessment varchar NULL, 
	e23_health_conditions varchar NULL, 
	e24_health_intellectual_disability varchar NULL, 
	e25_health_autism_spectrum_disorder varchar NULL,
	e26_health_visual_impairment varchar NULL, 
	e27_health_hearing_impairment varchar NULL, 
	e28_health_orthopedic_impairment varchar NULL,
	e29_health_mental_disorder varchar NULL, 
	e30_health_adhd_add varchar NULL, 
	e31_health_serious_mental_disorder varchar NULL, 
	e32_health_developmental_delay varchar NULL, 
	e33_health_developmental_disability varchar NULL, 
	e34_health_other_condition varchar NULL, 
	e35_school_enrollment varchar NULL, 
	e36_school_highest_completed varchar NULL,
	e37_school_special_education varchar NULL,
	e38_pregnant varchar NULL,
	e39_fathered_or_bore_child varchar NULL,
	e40_child_and_children_together varchar NULL,
	e41_prior_adoption varchar NULL,
	e42_prior_adoption_date varchar NULL,
	e43_prior_adoption_intercountry varchar NULL,
	e44_prior_guardianship varchar NULL,
	e45_prior_guardianship_date varchar NULL,
	e46_support_assistance varchar NULL,
	e47_state_tribal_adoption_assistance varchar NULL,
	e48_state_tribal_foster_care varchar NULL,
	e49_adoption_subsidy varchar NULL,
	e50_guardianship_assistance varchar NULL,
	e51_tanf_assistance varchar NULL,
	e52_title_iv_b varchar NULL,
	e53_chafee_foster_program varchar NULL,
	e54_other_financial_support varchar NULL,
	e55_foster_care_payment varchar NULL,
	e56_total_siblings varchar NULL,
	e57_siblings_in_foster_care varchar NULL,
	e58_siblings_in_living_arrangement varchar NULL,
	e59_first_parent_birth_year varchar NULL,
	e60_second_parent_birth_year varchar NULL,
	e61_tribal_membership_mother varchar NULL,
	e62_tribal_membership_father varchar NULL,
	e63_tpr_parent1 varchar NULL,
	e64_tpr_parent2 varchar NULL,
	e65_tpr_petition_date_parent1 varchar NULL,
	e66_tpr_petition_date_parent2 varchar NULL,
	e67_tpr_date_parent1 varchar NULL,
	e68_tpr_date_parent2 varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT client_data_history_pkey PRIMARY KEY (client_data_historyid)
);
CREATE INDEX client_data_history_idx ON cjams.afcars_fc_client_data_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.client_data_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.history_insertedon is 'History captured date and time';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e1_title_iv_agency IS 'Title IV-E Agency (2-digit State FIPS Code)';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e2_report_date IS 'AFCARS Report Date';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e3_local_agency IS 'State Local Agency (5-digit State FIPS Code)';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e4_child_record_number IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e5_date_of_birth IS 'Client Date of Birth';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e6_sex IS 'Client Gender';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e7_agency_made_inquiries IS 'ICWA Status Inquiry Made by the Agency';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e8_tribal_membership IS 'Client is part of the Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e10_icwa IS 'Is Client ICWA under definition';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e11_icwa_date IS 'Date of ICWA Applies Notification';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e12_icwa_notification IS 'Indicate whether Legal Notice was sent to the Tribe';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e13_child_race_american_indian_alaska_native IS 'Client Race American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e14_child_race_asian IS 'Client Race Asian';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e15_child_race_black IS 'Client Race Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e16_child_race_native_hawaiian_pacific_islander IS 'Client Race Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e17_child_race_white IS 'Client Race White';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e18_child_race_unknown IS 'Client Race Unknown';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e19_child_race_abandoned IS 'Client Race Abandoned';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e20_child_race_declined IS 'Client Race Declined';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e21_child_hispanic_latino IS 'Client Ethnicity Hispanic or Latino';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e22_health_assessment IS 'Client Health Assessment Info Available';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e23_health_conditions IS 'Client Health Conditions';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e24_health_intellectual_disability IS 'Client is having Intellectual Disability';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e25_health_autism_spectrum_disorder IS 'Client is having Autism Spectrum Disorder';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e26_health_visual_impairment IS 'Client is having Visual Impairment and Blindness';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e27_health_hearing_impairment IS 'Client is having Hearing Impairment and Deafness';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e28_health_orthopedic_impairment IS 'Client is having Orthopedic Impairment or Other Physical Condition';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e29_health_mental_disorder IS 'Client is having Mental/Emotional Disorders';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e30_health_adhd_add IS 'Client is having Attention Deficit Hyperactivity Disorder';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e31_health_serious_mental_disorder IS 'Client is having Serious Mental Disorders';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e32_health_developmental_delay IS 'Client is having Developmental Delay';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e33_health_developmental_disability IS 'Client is having Developmental Disability';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e34_health_other_condition IS 'Client is having Other Diagnosed Condition';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e35_school_enrollment IS 'Client School Enrollment Status';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e36_school_highest_completed IS 'Highest Educational Level Completed';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e37_school_special_education IS 'Enrollment in Special Education';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e38_pregnant IS 'Client is Pregnant';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e39_fathered_or_bore_child IS 'Client Ever Fathered or Bore Children';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e40_child_and_children_together IS 'Child and His/Her Child(ren) Placed Together ';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e41_prior_adoption IS 'Client was Adopted Prior to this Removal';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e42_prior_adoption_date IS 'Prior Adoption Date';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e43_prior_adoption_intercountry IS 'Prior Adoption was Intercountry';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e44_prior_guardianship IS 'Client was under Guardianship Prior to this Removal';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e45_prior_guardianship_date IS 'Prior Guardianship Date';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e46_support_assistance IS 'Client is receiving Support/Assistance';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e47_state_tribal_adoption_assistance IS 'Client is receiving State/Tribal Adoption Assistance';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e48_state_tribal_foster_care IS 'Client is receiving State/Tribal Foster Care';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e49_adoption_subsidy IS 'Client is receiving Title IV-E Adoption Subsidy';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e50_guardianship_assistance IS 'Client is receiving Title IV-E Guardianship Assistance';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e51_tanf_assistance IS 'Client is receiving Title IV-A TANF Assistance';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e52_title_iv_b IS 'Client is receiving Title IV-B Assistance';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e53_chafee_foster_program IS 'Client is receiving Chafee Foster Care Independence Program Assistance';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e54_other_financial_support IS 'Client is receiving Other Financial Support';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e55_foster_care_payment IS 'Client is receiving Foster Care Maintenance Payment';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e56_total_siblings IS 'Client''s Total Number of Siblings';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e57_siblings_in_foster_care IS 'Client''s Siblings in Foster Care';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e58_siblings_in_living_arrangement IS 'Client''s Siblings in Living Arrangement';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e59_first_parent_birth_year IS 'Year of Birth of First Parent or Legal Guardian';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e60_second_parent_birth_year IS 'Year of Birth of Second Parent or Legal Guardian';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e61_tribal_membership_mother IS 'Tribal Membership of the Mother';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e62_tribal_membership_father IS 'Tribal Membership of the Father';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e63_tpr_parent1 IS 'Termination of Parental Rights Decison for First Parent';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e64_tpr_parent2 IS 'Termination of Parental Rights Decison for Second Parent';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e65_tpr_petition_date_parent1 IS 'Termination of Parental Rights Petition Date for First Parent';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e66_tpr_petition_date_parent2 IS 'Termination of Parental Rights Petition Date for Second Parent';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e67_tpr_date_parent1 IS 'Termination of Parental Rights Petition Date for First Parent';
COMMENT ON COLUMN cjams.afcars_fc_client_data_history.e68_tpr_date_parent2 IS 'Termination of Parental Rights Date for Second Parent';


-- DROP TABLE cjams.afcars_fc_periodic_reviews_history;
CREATE TABLE cjams.afcars_fc_periodic_reviews_history (
	periodic_reviews_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL, -- Foreign key - PK of afcarsfostercare_new table
	recordno varchar(50) NULL, -- Encrypted cjampspid
	removalid varchar NULL, -- Foreign key - PK of intakeservreqchildremoval table
	e149_periodic_review_date varchar NULL, -- Periodic Review Date
	intakeservicerequestcourthearingid varchar NULL, -- Foreign key - PK of intakeservicerequestcourthearing table
	cjamspid varchar NULL, -- CJAMS Service Case Number
	caseid varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT periodic_reviews_history_pkey PRIMARY KEY (periodic_reviews_historyid)
);
CREATE INDEX aafcars_fc_periodic_reviews_history_idx ON cjams.afcars_fc_periodic_reviews_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.periodic_reviews_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.e149_periodic_review_date IS 'Periodic Review Date';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.intakeservicerequestcourthearingid IS 'Foreign key - PK of intakeservicerequestcourthearing table';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_periodic_reviews_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcars_fc_permanency_hearings_history;

CREATE TABLE cjams.afcars_fc_permanency_hearings_history (
	permanency_hearings_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL, -- Foreign key - PK of afcarsfostercare_new table
	recordno varchar(50) NULL, -- Encrypted cjampspid
	removalid varchar NULL, -- Foreign key - PK of intakeservreqchildremoval table
	e150_permanency_hearing_date varchar NULL, -- Permanency Hearing Date
	intakeservicerequestcourthearingid varchar NULL, -- Foreign key - PK of intakeservicerequestcourthearing table
	cjamspid varchar NULL, -- CJAMS Service Case Number
	caseid varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT permanency_hearings_history_pkey PRIMARY KEY (permanency_hearings_historyid)
);
CREATE INDEX permanency_hearings_history_idx ON cjams.afcars_fc_permanency_hearings_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.permanency_hearings_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.e150_permanency_hearing_date IS 'Permanency Hearing Date';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.intakeservicerequestcourthearingid IS 'Foreign key - PK of intakeservicerequestcourthearing table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_permanency_hearings_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcars_fc_permanency_plans_history;

CREATE TABLE cjams.afcars_fc_permanency_plans_history (
    permanency_plans_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL, -- Foreign key - PK of afcarsfostercare_new table
	recordno varchar(50) NULL, -- Encrypted cjampspid
	removalid varchar NULL, -- Foreign key - PK of intakeservreqchildremoval table
	e147_permanency_plan_date varchar NULL, -- Permanency Plan Established Date
	e148_permanency_plan_type varchar NULL, -- Type of Permanency Plan
	permanencyplanid varchar NULL, -- Foreign key - PK of permanencyplan table
	cjamspid varchar NULL, -- CJAMS Service Case Number
	caseid varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT permanency_plans_history_pkey PRIMARY KEY (permanency_plans_historyid)
);
CREATE INDEX permanency_plans_history_idx ON cjams.afcars_fc_permanency_plans_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.permanency_plans_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.e147_permanency_plan_date IS 'Permanency Plan Established Date';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.e148_permanency_plan_type IS 'Type of Permanency Plan';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.permanencyplanid IS 'Foreign key - PK of permanencyplan table';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_permanency_plans_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcars_fc_placements_history;

CREATE TABLE cjams.afcars_fc_placements_history (
    placements_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL, 
	recordno varchar(50) NULL,
	removalid varchar NULL,
	e112_date_living_arrangement varchar NULL,
	e113_foster_family_home varchar NULL,
	e114_licensed_home varchar NULL,
	e115_therapeutic_home varchar NULL,
	e116_shelter_care_home varchar NULL,
	e117_relative_foster_family varchar NULL,
	e118_pre_adopt_home varchar NULL,
	e119_kin_foster_family varchar NULL,
	e120_other_living_arrangement_type varchar NULL,
	e121_location_of_living_arrangement varchar NULL,
	e122_jurisdiction_or_country varchar NULL,
	e123_marital_status_of_foster_parents varchar NULL,
	e124_relationship_to_foster_parents varchar NULL,
	e125_foster_parent1_birth_year varchar NULL,
	e126_foster_parent1_tribal_membership varchar NULL,
	e127_foster_parent1_race_american_indian_alaska_native varchar NULL,
	e128_foster_parent1_race_asian varchar NULL,
	e129_foster_parent1_race_black varchar NULL,
	e130_foster_parent1_race_native_hawaiian_pacific_islander varchar NULL,
	e131_foster_parent1_race_white varchar NULL,
	e132_foster_parent1_race_unknown varchar NULL,
	e133_foster_parent1_race_declined varchar NULL,
	e134_foster_parent1_hispanic_latino varchar NULL,
	e135_foster_parent1_sex varchar NULL,
	e136_foster_parent2_birth_year varchar NULL,
	e137_foster_parent2_tribal_membership varchar NULL,
	e138_foster_parent2_race_american_indian_alaska_native varchar NULL,
	e139_foster_parent2_race_asian varchar NULL,
	e140_foster_parent2_race_black varchar NULL,
	e141_foster_parent2_race_native_hawaiian_pacific_islander varchar NULL,
	e142_foster_parent2_race_white varchar NULL,
	e143_foster_parent2_race_unknown varchar NULL,
	e144_foster_parent2_race_declined varchar NULL,
	e145_foster_parent2_hispanic_latino varchar NULL,
	e146_foster_parent2_sex varchar NULL,
	placementid varchar NULL,
	cjamspid varchar NULL,
	caseid varchar NULL,
	placementtype varchar NULL,
	placementcpahomeid uuid NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT placements_history_pkey PRIMARY KEY (placements_historyid)
);
CREATE INDEX placements_idx ON cjams.afcars_fc_placements_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_placements_history.placements_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e112_date_living_arrangement IS 'Placement Entry Date';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e113_foster_family_home IS 'Provider Placement Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e114_licensed_home IS 'Provider is Licensed Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e115_therapeutic_home IS 'Provider is Therapeutic Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e116_shelter_care_home IS 'Provider is Shelter Care Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e117_relative_foster_family IS 'Provider is Relative Foster Family Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e118_pre_adopt_home IS 'Provider is Pre-adopt Home Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e119_kin_foster_family IS 'Provider is Kinship-foster family Yes/No';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e120_other_living_arrangement_type IS 'Living Arrangement Type';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e121_location_of_living_arrangement IS 'Location of Living Arrangement';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e122_jurisdiction_or_country IS 'Provider Location County';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e123_marital_status_of_foster_parents IS 'Marital Status of Foster Parents';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e124_relationship_to_foster_parents IS 'Client Relationship to Foster Parents';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e125_foster_parent1_birth_year IS 'First Foster Parent Birth Year';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e126_foster_parent1_tribal_membership IS 'First Foster Parent Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e127_foster_parent1_race_american_indian_alaska_native IS 'Race of First Foster Parent: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e128_foster_parent1_race_asian IS 'Race of First Foster Parent: Asian';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e129_foster_parent1_race_black IS 'Race of First Foster Parent: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e130_foster_parent1_race_native_hawaiian_pacific_islander IS 'Race of First Foster Parent: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e131_foster_parent1_race_white IS 'Race of First Foster Parent: White';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e132_foster_parent1_race_unknown IS 'Race of First Foster Parent: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e133_foster_parent1_race_declined IS 'Race of First Foster Parent: Declined';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e134_foster_parent1_hispanic_latino IS 'Hispanic or Latino Ethnicity of First Foster Parent';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e135_foster_parent1_sex IS 'Gender of First Foster Parent';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e136_foster_parent2_birth_year IS 'Second Foster Parent Birth Year';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e137_foster_parent2_tribal_membership IS 'Second Foster Parent Tribal Membership';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e138_foster_parent2_race_american_indian_alaska_native IS 'Race of Second Foster Parent: American Indian or Alaska Native';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e139_foster_parent2_race_asian IS 'Race of Second Foster Parent: Asian';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e140_foster_parent2_race_black IS 'Race of Second Foster Parent: Black or African American';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e141_foster_parent2_race_native_hawaiian_pacific_islander IS 'Race of Second Foster Parent: Native Hawaiian or Other Pacific Islander';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e142_foster_parent2_race_white IS 'Race of Second Foster Parent: White';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e143_foster_parent2_race_unknown IS 'Race of Second Foster Parent: Unknown';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e144_foster_parent2_race_declined IS 'Race of Second Foster Parent: Declined';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e145_foster_parent2_hispanic_latino IS 'Hispanic or Latino Ethnicity of Second Foster Parent';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.e146_foster_parent2_sex IS 'Gender of Second Foster Parent';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.placementid IS 'Foreign key - PK of placement table';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.placementtype IS 'PLacement Type - Living Arrangement or Provider Placement';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.placementcpahomeid IS 'Foreign key - PK of CPA Home placement table';
COMMENT ON COLUMN cjams.afcars_fc_placements_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcars_fc_recognized_tribes_history;

CREATE TABLE cjams.afcars_fc_recognized_tribes_history (
	recognized_tribes_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	cjamspid varchar NULL,
	e9_recognized_tribes varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT recognized_tribes_history_pkey PRIMARY KEY (recognized_tribes_historyid)
);
CREATE INDEX arecognized_tribes_history_idx ON cjams.afcars_fc_recognized_tribes_history USING btree (afcars_history_id);


-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes_history.recognized_tribes_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes_history.cjamspid IS 'CJAMS Client Number';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes_history.e9_recognized_tribes IS 'Client belongs to Federally Recognized Tribe (Tribal Standard Code)';
COMMENT ON COLUMN cjams.afcars_fc_recognized_tribes_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcars_fc_sex_trafficking_history;

CREATE TABLE cjams.afcars_fc_sex_trafficking_history (
	sex_trafficking_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	afcarsfostercareid varchar NULL,
	recordno varchar(50) NULL,
	removalid varchar NULL,
	e106_prior_victim_sex_trafficking varchar NULL,
	e107_prior_victim_sex_trafficking_reported varchar NULL,
	e108_prior_victim_sex_trafficking_reported_date varchar NULL,
	e109_victim_sex_trafficking varchar NULL,
	e110_victim_sex_trafficking_reported varchar NULL,
	e111_victim_sex_trafficking_reported_date varchar NULL,
	cjamspid varchar NULL,
	caseid varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT sex_trafficking_history_pkey PRIMARY KEY (sex_trafficking_historyid)

);
CREATE INDEX sex_trafficking_history_idx ON cjams.afcars_fc_sex_trafficking_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.sex_trafficking_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.afcarsfostercareid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.recordno IS 'Encrypted cjampspid';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.removalid IS 'Foreign key - PK of intakeservreqchildremoval table';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.e106_prior_victim_sex_trafficking IS 'Prior Sex Trafficking Flag';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.e107_prior_victim_sex_trafficking_reported IS 'Prior Sex Trafficking Reported';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.e108_prior_victim_sex_trafficking_reported_date IS 'Prior Sex Trafficking Reported Date';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.e109_victim_sex_trafficking IS 'Sex Trafficking Flag';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.e110_victim_sex_trafficking_reported IS 'Sex Trafficking Reported';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.e111_victim_sex_trafficking_reported_date IS 'Sex Trafficking Reported Date';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.cjamspid IS 'CJAMS Service Case Number';
COMMENT ON COLUMN cjams.afcars_fc_sex_trafficking_history.history_insertedon is 'History captured date and time';


-- AFCARS Adoption 
-- DROP TABLE cjams.afcarsadoptioncount_history;

CREATE TABLE cjams.afcarsadoptioncount_history (
	afcarsadoptioncount_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	countid int8 NULL,
	totalnorecords varchar(20) NULL,
	periodendingdate varchar(20) NULL,
	chunderoneyear varchar(20) NULL,
	choneyear varchar(20) NULL,
	chtwoyear varchar(20) NULL,
	chthreeyear varchar(20) NULL,
	chfouryear varchar(20) NULL,
	chfiveyear varchar(20) NULL,
	chsixyear varchar(20) NULL,
	chsevenyear varchar(20) NULL,
	cheightyear varchar(20) NULL,
	chnineyear varchar(20) NULL,
	chtenyear varchar(20) NULL,
	chelevenyear varchar(20) NULL,
	chtwelveyear varchar(20) NULL,
	chthirteenyear varchar(20) NULL,
	chfourteenyear varchar(20) NULL,
	chfifteenyear varchar(20) NULL,
	chsixteenyear varchar(20) NULL,
	chseventeenyear varchar(20) NULL,
	cheighteenyear varchar(20) NULL,
	chovereighteenyear varchar(20) NULL,
	insertedon timestamp NULL,
	insertedby varchar(10) NULL,
	updatedon timestamp NULL,
	updatedby varchar(10) NULL,
	activeflag int4 NULL,
	old_id varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT afcarsadoptioncount_history_pkey PRIMARY KEY (afcarsadoptioncount_historyid)
);
CREATE INDEX afcarsadoptioncount_history_idx ON cjams.afcarsadoptioncount_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.afcarsadoptioncount_historyid IS 'Foreign key - PK of afcarsfostercare_new table';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.countid IS 'Foreign key - PK of afcarsadoptioncount table';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.totalnorecords IS 'Total number of children in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.periodendingdate IS 'AFCARS Submission Period';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chunderoneyear IS 'Total number of children under one year in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.choneyear IS 'Total number of children one year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chtwoyear IS 'Total number of children two year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chthreeyear IS 'Total number of children three year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chfouryear IS 'Total number of children four year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chfiveyear IS 'Total number of children five year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chsixyear IS 'Total number of children six year old in the AFCARS Submission'; 
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chsevenyear IS 'Total number of children seven year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.cheightyear IS 'Total number of children eigth year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chnineyear IS 'Total number of children nine year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chtenyear IS 'Total number of children ten year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chelevenyear IS 'Total number of children eleven year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chtwelveyear IS 'Total number of children twelve year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chthirteenyear IS 'Total number of children thirteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chfourteenyear IS 'Total number of children fourteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chfifteenyear IS 'Total number of children fifteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chsixteenyear IS 'Total number of children sixteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chseventeenyear IS 'Total number of children seventeen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.cheighteenyear IS 'Total number of children eighteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.chovereighteenyear IS 'Total number of children nineteen year old in the AFCARS Submission';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.old_id IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.etl_userid IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.etl_load_date IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.activeflag IS 'Status of the record - active or inactive.';
COMMENT ON COLUMN cjams.afcarsadoptioncount_history.history_insertedon is 'History captured date and time';

-- DROP TABLE cjams.afcarsadoptionsummary_history;

CREATE TABLE cjams.afcarsadoptionsummary_history (
    afcarsadoptionsummary_historyid   uuid NOT NULL DEFAULT gen_random_uuid(), 
	summaryid int8 NULL,
	reportingperiod varchar(20) NULL,
	firstsubmitteddate timestamp NULL,
	lastsubmitteddate timestamp NULL,
	insertedon timestamp NULL,
	insertedby varchar(10) NULL,
	updatedon timestamp NULL,
	updatedby varchar(10) NULL,
	activeflag int4 NULL,
	old_id varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT aafcarsadoptionsummary_history_pkey PRIMARY KEY (afcarsadoptionsummary_historyid)
);
CREATE INDEX aafcarsadoptionsummary_history_idx ON cjams.afcarsadoptionsummary_history USING btree (afcars_history_id);

COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.afcarsadoptionsummary_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.summaryid  IS 'Foreign key - PK of afcarsadoptionsummary table';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.reportingperiod  IS 'AFCARS Submission Period';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.firstsubmitteddate IS 'AFCARS Submission Batch Run Start Tiemstamp';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.lastsubmitteddate IS 'AFCARS Submission Batch Run End Tiemstamp';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.old_id IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.etl_userid IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.etl_load_date IS 'Column used for Data migration purposes only';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.updatedby IS 'User who last updated the record';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.activeflag IS 'Status of the record - active or inactive.';
COMMENT ON COLUMN cjams.afcarsadoptionsummary_history.history_insertedon is 'History captured date and time';


-- AFCARS Adoption 

-- DROP TABLE cjams.afcarsadoptiondetail_history;

CREATE TABLE cjams.afcarsadoptiondetail_history (
	afcarsadoptiondetail_historyid  uuid NOT NULL DEFAULT gen_random_uuid(), 
	detailid uuid NULL,
	summaryid int8 NULL,
	personid uuid NULL,
	submittedperiod varchar(20) NULL,
	actualperiod varchar(20) NULL,
	statetypekey varchar(50) NULL,
	reportpdenddate varchar(20) NULL,
	recordno varchar(50) NULL,
	agencyinvolvementtypekey varchar(50) NULL,
	childdob varchar(20) NULL,
	gendertypekey varchar(50) NULL,
	raceaitypekey varchar(50) NULL,
	raceasiantypekey varchar(50) NULL,
	raceblacktypekey varchar(50) NULL,
	racehawaiiantypekey varchar(50) NULL,
	racewhitetypekey varchar(50) NULL,
	raceuntypekey varchar(50) NULL,
	hispanictypekey varchar(50) NULL,
	specialneedstypekey varchar(50) NULL,
	primarybasistypekey varchar(50) NULL,
	mentalretardationtypekey varchar(50) NULL,
	visualhearingtypekey varchar(50) NULL,
	physicaldisabledtypekey varchar(50) NULL,
	emotionaldisturbedtypekey varchar(50) NULL,
	otherdiagnosedconditiontypekey varchar(50) NULL,
	bmotherbirthyear varchar(20) NULL,
	bfatherbirthyear varchar(20) NULL,
	mothermarriedatbirthtypekey varchar(50) NULL,
	mothertprdt varchar(20) NULL,
	fathertprdt varchar(20) NULL,
	adoptionfinalizeddt varchar(20) NULL,
	adopfamilystructuretypekey varchar(50) NULL,
	adopmotherbirthyear varchar(20) NULL,
	adopfatherbirthyear varchar(20) NULL,
	adopmotherraceaitypekey varchar(50) NULL,
	adopmotherraceasiantypekey varchar(50) NULL,
	adopmotherraceblacktypekey varchar(50) NULL,
	adopmotherracehawaiiantypekey varchar(50) NULL,
	adopmotherracewhitetypekey varchar(50) NULL,
	adopmotherraceuntypekey varchar(50) NULL,
	adopmotherhispanictypekey varchar(50) NULL,
	adopfatherraceaitypekey varchar(50) NULL,
	adopfatherraceasiantypekey varchar(50) NULL,
	adopfatherraceblacktypekey varchar(50) NULL,
	adopfatherracehawaiiantypekey varchar(50) NULL,
	adopfatherracewhitetypekey varchar(50) NULL,
	adopfatherraceuntypekey varchar(50) NULL,
	adopfatherhispanictypekey varchar(50) NULL,
	adopparrelstepparenttypekey varchar(50) NULL,
	adopparrelotherreltypekey varchar(50) NULL,
	adopparrelnonreltypekey varchar(50) NULL,
	childplacedfromtypekey varchar(50) NULL,
	childplacedbytypekey varchar(50) NULL,
	adoptionsubsidytypekey varchar(50) NULL,
	subsidypaymentamount varchar(20) NULL,
	iveadoptionflag varchar NULL,
	insertedon timestamp NULL,
	insertedby varchar(10) NULL,
	updatedon timestamp NULL,
	updatedby varchar(10) NULL,
	activeflag int4 NULL,
	adopparrelfospartypekey varchar(50) NULL,
	datavalidflag int4 NULL,
	old_id varchar(50) NULL,
	clientid int4 NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	a12_child_race_abandoned varchar NULL,
	a13_child_race_declined varchar NULL,
	a15_assistance_agreement_type varchar NULL,
	agreement_start_date varchar NULL,
	a18_agreement_termination_date varchar NULL,
	a4_child_date_of_birth varchar NULL,
	adoption_gap_casetype varchar NULL,
	history_insertedon timestamp NULL DEFAULT now(), 
	afcars_history_id int8 NULL,
	CONSTRAINT afcarsadoptiondetail_history_pkey PRIMARY KEY (afcarsadoptiondetail_historyid)
);
CREATE INDEX afcarsadoptiondetail_history__idx ON cjams.afcarsadoptiondetail_history USING btree (afcars_history_id);

-- Column comments
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.afcarsadoptiondetail_historyid IS 'Primary key - Unique Idetifier.';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.a12_child_race_abandoned IS 'Client Race Abandoned';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.a13_child_race_declined IS 'Client Race Declined';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.a15_assistance_agreement_type IS 'Subsidy Type 1 = Adoption and 2 = GAP';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.agreement_start_date IS 'Adoption Agreement Start Date';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.a18_agreement_termination_date IS 'Adoption Agreement End Date';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.a4_child_date_of_birth IS 'Client Date of Birth';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.adoption_gap_casetype IS 'Column to Identify Case Type : Adoption or GAP';
COMMENT ON COLUMN cjams.afcarsadoptiondetail_history.history_insertedon is 'History captured date and time';

