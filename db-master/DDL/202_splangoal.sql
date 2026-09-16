-- Drop table

-- DROP TABLE cjams.splangoal

CREATE TABLE cjams.splangoal (
	splangoalid uuid NOT NULL DEFAULT gen_random_uuid(),
	serviceplanid uuid NOT NULL,
	insertedby uuid NULL,
	insertedon timestamp NULL,
	updatedby uuid NULL,
	updatedon timestamp NULL,
	activeflag int4 NULL,
	goalname varchar(100) NULL,
	approvalstatustypekey varchar(150) NULL,
	CONSTRAINT pk_splangoal PRIMARY KEY (splangoalid),
	CONSTRAINT fk_serviceplan FOREIGN KEY (serviceplanid) REFERENCES serviceplan(serviceplanid)
);

-- Permissions

ALTER TABLE cjams.splangoal OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.splangoal TO welfareadmin;