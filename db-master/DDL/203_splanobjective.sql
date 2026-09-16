-- Drop table

-- DROP TABLE cjams.splanobjective

CREATE TABLE cjams.splanobjective (
	splanobjectiveid uuid NOT NULL DEFAULT gen_random_uuid(),
	splangoalid uuid NOT NULL,
	serviceplanid uuid NOT NULL,
	insertedby uuid NULL,
	insertedon timestamp NULL,
	updatedby uuid NULL,
	updatedon timestamp NULL,
	activeflag int4 NULL,
	objectivename varchar(100) NULL,
	needs jsonb NULL,
	strengths jsonb NULL, 
	approvalstatustypekey varchar(150) NULL,
	"comments" varchar(150) NULL,
	CONSTRAINT pk_splanobjective PRIMARY KEY (splanobjectiveid),
	CONSTRAINT fk_serviceplangoal FOREIGN KEY (splangoalid) REFERENCES splangoal(splangoalid)
);

-- Permissions

ALTER TABLE cjams.splanobjective OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.splanobjective TO welfareadmin;