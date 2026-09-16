DROP TABLE IF EXISTS cjams.provider_uir_youth_detail;
CREATE TABLE cjams.provider_uir_youth_detail (
	provider_uir_youth_detail_id uuid NOT NULL DEFAULT gen_random_uuid(),
	uir_no varchar(50) NOT NULL,
	provider_uir_id varchar NOT NULL,
	provider_uir_actor_id varchar NOT NULL,
	provider_id varchar(50) NULL,	
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	activeflag int4 NULL
);
