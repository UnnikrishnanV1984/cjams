

CREATE TABLE IF NOT EXISTS cjams.tb_licprov_activities  ( 
   lic_prov_activity_id       integer NOT NULL,
   license_application_id     integer NULL,
   activity_type_cd           varchar(50) NULL,
   activity_dt                date NULL,
   activity_comment_tx        varchar(500) NULL,
   staff_id                   integer NULL,
   create_ts                  timestamp NOT NULL,
   create_user_id             varchar(50) NULL,
   update_ts                  timestamp  NULL,
   update_user_id             varchar(50) NULL,
   delete_sw                  char(1) NULL DEFAULT 'N'::bpchar,
   pre_post_sw                char(1) NULL,
   activity_end_dt            date NULL,
   action_insert_timestamp    timestamp NULL,
   action_insert_src_name     varchar(50) NULL,
   action_update_timestamp    timestamp NULL,
   action_update_src_name     varchar(50) NULL,
   CONSTRAINT pk_licp_act PRIMARY KEY(lic_prov_activity_id)
);

-- Sequence set up
DROP SEQUENCE IF EXISTS SQ_LICPROV_ACTIVITIES CASCADE;	
CREATE SEQUENCE SQ_LICPROV_ACTIVITIES
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 10000001
CACHE 1;

ALTER TABLE tb_licprov_activities ALTER COLUMN lic_prov_activity_id SET DEFAULT nextval('SQ_LICPROV_ACTIVITIES');




CREATE TABLE IF NOT EXISTS cjams.TB_PROVIDER_SERVICES_PICKLIST 
 ( 
	PROVIDER_SERVICES_PICKLIST_ID INTEGER NOT NULL,
	PROVIDER_SERVICE_ID INTEGER NULL, 
	PICKLIST_TYPE_ID INTEGER , 
	PICKLIST_VALUE_CD VARCHAR(5) , 
	CREATE_TS TIMESTAMP NULL, 
	CREATE_USER_ID VARCHAR(50) NULL, 
	UPDATE_TS TIMESTAMP NULL, 
	UPDATE_USER_ID VARCHAR(50) NULL, 
	DELETE_SW CHAR(1) NOT NULL DEFAULT 'N'::bpchar
);

-- Sequence set up
DROP SEQUENCE IF EXISTS SQ_PROVIDER_SERVICES_PICKLIST CASCADE;	
CREATE SEQUENCE SQ_PROVIDER_SERVICES_PICKLIST
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 10000001
CACHE 1;

ALTER TABLE TB_PROVIDER_SERVICES_PICKLIST ALTER COLUMN PROVIDER_SERVICES_PICKLIST_ID SET DEFAULT nextval('SQ_PROVIDER_SERVICES_PICKLIST');



ALTER TABLE cjams.tb_prov_accomodation ADD COLUMN IF NOT EXISTS old_prov_accomodation_id int4 NULL;

-- Sequence set up
DROP SEQUENCE IF EXISTS SQ_PROV_ACCOMODATION CASCADE;	
CREATE SEQUENCE SQ_PROV_ACCOMODATION
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 10000001
CACHE 1;

ALTER TABLE tb_prov_accomodation ALTER COLUMN old_prov_accomodation_id SET DEFAULT nextval('SQ_PROV_ACCOMODATION');