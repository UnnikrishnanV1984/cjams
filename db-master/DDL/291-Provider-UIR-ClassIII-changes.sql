DROP TABLE IF EXISTS cjams.provider_uir_contact_detail;

CREATE TABLE cjams.provider_uir_contact_detail (
	provider_uir_contact_detail_id uuid NOT NULL DEFAULT gen_random_uuid(),
	uir_no varchar(50) NOT NULL,
	provider_uir_id varchar NOT NULL,
	firstname varchar(50) NULL,
	lastname varchar(50) NULL,
	email varchar(50) NULL,
	phonenumber varchar(32) NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	activeflag int4 NULL
);

DROP TABLE IF EXISTS cjams.provider_uir_incident_detail;

CREATE TABLE cjams.provider_uir_incident_detail (
provider_uir_incident_detail_id uuid NOT NULL DEFAULT gen_random_uuid(),
uir_no varchar(50) NOT NULL,
provider_uir_id uuid NOT NULL,
incident_type varchar(50) NULL,
incident_precipitating_event varchar(50) NULL,
other_class3 varchar(50) NULL,
incident_level_of_supervision int4 NULL,
incident_location varchar(50) NULL,
incident_area varchar(50) NULL,
inserted_by varchar(50) NULL,
inserted_on timestamp NULL DEFAULT now(),
updated_by varchar(50) NULL,
updated_on timestamp NULL,
activeflag int4 NULL DEFAULT 1
);

alter table provider_uir_actor_detail add column identifier_no varchar(50);
alter table provider_uir_actor_detail add column admitting_charge varchar(50);
alter table provider_uir_actor_detail add column provider_id varchar(50);