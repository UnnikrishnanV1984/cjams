-- DROP TABLE cjams.donotexpunge;

CREATE TABLE cjams.donotexpunge (
	donotexpungeid uuid NOT NULL DEFAULT gen_random_uuid(),
	intakeserviceid uuid NULL,
	donotexpunge bool NULL,
	donotexpungejustification text NULL,
	releasedon timestamp NULL,
	releasejustification text NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1
);
CREATE INDEX indx_donotexpunge_intakeserviceid ON cjams.donotexpunge USING btree (intakeserviceid);
