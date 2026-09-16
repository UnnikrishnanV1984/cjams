-- Drop table

 DROP TABLE if exists cjams.afcarscaresin;

CREATE TABLE cjams.afcarscaresin (
	id bigint NOT NULL,
	cjamspid bigint NULL,
	cisid varchar(50) NULL,
	removaldate timestamp NULL,
	returndate timestamp NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedon timestamp NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	insertedby varchar(50) NULL,
	"extract" varchar(50) NULL,
	old_id varchar(50) NULL
);
