DROP TABLE IF EXISTS provider_uir_lawenforcement_detail;
CREATE TABLE cjams.provider_uir_lawenforcement_detail (
provider_uir_lawenforcement_detail_id uuid NOT NULL DEFAULT gen_random_uuid(),
uir_no varchar(50) NOT NULL,
provider_uir_id uuid NOT NULL,
report_number varchar(50) NULL,
contact_first_name varchar(50) NULL,
contact_last_name varchar(50) NULL,
phone_no varchar(50) NULL,
date timestamp NULL,
time varchar(32) NULL,
inserted_by varchar(50) NULL,
inserted_on timestamp NULL DEFAULT now(),
updated_by varchar(50) NULL,
active_flag int4 NULL,
updated_on timestamp NULL
);

ALTER TABLE cjams.provider_uir_lawenforcement_detail ADD CONSTRAINT fk_provider_uir_id FOREIGN KEY (provider_uir_id) REFERENCES provider_uir(provider_uir_id);

