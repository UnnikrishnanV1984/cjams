-- Drop table

-- DROP TABLE cjams.logopenam;

CREATE TABLE logopenam (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	logemail text NULL,
	insertedon timestamp NULL,
	request jsonb NULL,
	response jsonb NULL,
	apiurl  text NULL,
	CONSTRAINT logopenam_pk PRIMARY KEY (id)
);


