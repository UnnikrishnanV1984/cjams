-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 05/19/2026 Varun Venugopal - CIDM-11277 - Create statements related to implementing the missing primary key for all the tables 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---New 
ALTER TABLE cjams.personalert ADD COLUMN id uuid DEFAULT cjams.gen_random_uuid(), ADD CONSTRAINT personalert_id_pk PRIMARY KEY (id);
COMMENT ON COLUMN cjams.personalert.id IS 'Unique id for each row';
ALTER TABLE cjams.goalobjectives ADD COLUMN id uuid DEFAULT cjams.gen_random_uuid(), ADD CONSTRAINT goalobjectives_id_pk PRIMARY KEY (id);
COMMENT ON COLUMN cjams.goalobjectives.id IS 'Unique id for each row';
ALTER TABLE cjams.serviceplangoaldetails ADD COLUMN id uuid DEFAULT cjams.gen_random_uuid(), ADD CONSTRAINT serviceplangoaldetails_id_pk PRIMARY KEY (id);
COMMENT ON COLUMN cjams.serviceplangoaldetails.id IS 'Unique id for each row';

---Delete Duplicate record & existing column PK-------------  
ALTER TABLE cjams.courtorderlanguage add primary key (courtorderid);
ALTER TABLE cjams.courtorderlanguage ALTER COLUMN courtorderid SET DEFAULT cjams.gen_random_uuid(); 
ALTER TABLE cjams.placementadmissionauthorizationtype add primary key (placementadmissionauthorizationtypeid);
ALTER TABLE cjams.placementadmissionclassificationtype add primary key (placementadmissionclassificationid );
ALTER TABLE cjams.placementadmissiontype add primary key (placementadmissiontypeid);
ALTER TABLE cjams.placementprimaryadmissionreasontype add primary key (placementprimaryadmissionreasontypeid);
ALTER TABLE cjams.placementprimaryapprovedalttype add primary key (placementprimaryapprovedalttypeid);
ALTER TABLE cjams.tb_client_assets ALTER COLUMN asset_id TYPE integer;
CREATE SEQUENCE cjams.tb_client_assets_asset_id_seq;
ALTER TABLE cjams.tb_client_assets ALTER COLUMN asset_id SET DEFAULT nextval('cjams.tb_client_assets_asset_id_seq');
SELECT setval('cjams.tb_client_assets_asset_id_seq',COALESCE((SELECT MAX(asset_id) FROM cjams.tb_client_assets), 1));
ALTER TABLE cjams.tb_client_assets ADD PRIMARY KEY (asset_id);
ALTER TABLE cjams.tb_client_deprivation ALTER COLUMN deprivtion_id TYPE integer;
CREATE SEQUENCE cjams.tb_client_deprivation_deprivtion_id_seq;
ALTER TABLE cjams.tb_client_deprivation ALTER COLUMN deprivtion_id SET DEFAULT nextval('cjams.tb_client_deprivation_deprivtion_id_seq');
SELECT setval('cjams.tb_client_deprivation_deprivtion_id_seq',COALESCE((SELECT MAX(deprivtion_id) FROM cjams.tb_client_deprivation), 0));
ALTER TABLE cjams.tb_client_deprivation ADD PRIMARY KEY (deprivtion_id);
ALTER TABLE cjams.tb_gap_rates_revision ALTER COLUMN gap_rates_revision_id TYPE integer;
CREATE SEQUENCE cjams.tb_gap_rates_revision_gap_rates_revision_id_seq;
ALTER TABLE cjams.tb_gap_rates_revision ALTER COLUMN gap_rates_revision_id SET DEFAULT nextval('cjams.tb_gap_rates_revision_gap_rates_revision_id_seq');
SELECT setval('cjams.tb_gap_rates_revision_gap_rates_revision_id_seq',COALESCE((SELECT MAX(gap_rates_revision_id) FROM cjams.tb_gap_rates_revision), 0));
ALTER TABLE cjams.tb_gap_rates_revision ADD PRIMARY KEY (gap_rates_revision_id);
ALTER TABLE cjams.tb_gap_suspension_revision add primary key (gap_suspension_revision_id); 
ALTER TABLE cjams.tb_guardian_subsidy_suspension ALTER COLUMN suspension_id TYPE integer;
CREATE SEQUENCE cjams.tb_guardian_subsidy_suspension_suspension_id_seq;
ALTER TABLE cjams.tb_guardian_subsidy_suspension ALTER COLUMN suspension_id SET DEFAULT nextval('cjams.tb_guardian_subsidy_suspension_suspension_id_seq');
SELECT setval('cjams.tb_guardian_subsidy_suspension_suspension_id_seq',COALESCE((SELECT MAX(suspension_id) FROM cjams.tb_guardian_subsidy_suspension), 0));
ALTER TABLE cjams.tb_guardian_subsidy_suspension ADD PRIMARY KEY (suspension_id);
ALTER TABLE cjams.tb_ive_deemed_income_clients ALTER COLUMN ive_deemed_income_clients_id TYPE integer;
CREATE SEQUENCE cjams.tb_ive_deemed_income_clients_ive_deemed_income_clients_id_seq;
ALTER TABLE cjams.tb_ive_deemed_income_clients ALTER COLUMN ive_deemed_income_clients_id SET DEFAULT nextval('cjams.tb_ive_deemed_income_clients_ive_deemed_income_clients_id_seq');
SELECT setval('cjams.tb_ive_deemed_income_clients_ive_deemed_income_clients_id_seq',COALESCE((SELECT MAX(ive_deemed_income_clients_id) FROM cjams.tb_ive_deemed_income_clients), 0));
ALTER TABLE cjams.tb_ive_deemed_income_clients ADD PRIMARY KEY (ive_deemed_income_clients_id);
ALTER TABLE cjams.tb_montg_cnty_payment_interface ALTER COLUMN mc_interface_record_id TYPE integer;
CREATE SEQUENCE cjams.tb_montg_cnty_payment_interface_mc_interface_record_id_seq;
ALTER TABLE cjams.tb_montg_cnty_payment_interface ALTER COLUMN mc_interface_record_id SET DEFAULT nextval('cjams.tb_montg_cnty_payment_interface_mc_interface_record_id_seq');
SELECT setval('cjams.tb_montg_cnty_payment_interface_mc_interface_record_id_seq',COALESCE((SELECT MAX(mc_interface_record_id) FROM cjams.tb_montg_cnty_payment_interface), 0));
ALTER TABLE cjams.tb_montg_cnty_payment_interface ADD PRIMARY KEY (mc_interface_record_id);
ALTER TABLE cjams.cinasubpoenad add primary key (cinasubpoenadid); 
ALTER TABLE cjams.intakeagencyrequesttype add primary key (intakeagencyreqtypeid); 
ALTER TABLE cjams.intakeserreqinterstate add primary key (intakeserreqinterstateid);
ALTER TABLE cjams.petitionwitness add primary key (petitionwitnessid); 
ALTER TABLE cjams.tb_ticklers ALTER COLUMN tickler_id TYPE integer;
CREATE SEQUENCE cjams.tb_ticklers_tickler_id_seq;
ALTER TABLE cjams.tb_ticklers ALTER COLUMN tickler_id SET DEFAULT nextval('cjams.tb_ticklers_tickler_id_seq');
SELECT setval('cjams.tb_ticklers_tickler_id_seq',COALESCE((SELECT MAX(tickler_id) FROM cjams.tb_ticklers), 0));
ALTER TABLE cjams.tb_ticklers ADD PRIMARY KEY (tickler_id);
ALTER TABLE cjams.tb_jcr_foster_care add primary key (jcr_fc_id); 