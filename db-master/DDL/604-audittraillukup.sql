DROP TABLE IF EXISTS cjams.audittraillukup;

CREATE TABLE IF NOT EXISTS cjams.audittraillukup (
	audittraillukupid uuid NOT NULL DEFAULT gen_random_uuid(),
	typekey varchar NULL,
	fieldjson json NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	CONSTRAINT audittraillukup_audittraillukupid PRIMARY KEY (audittraillukupid)
);
