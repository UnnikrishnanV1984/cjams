
DROP TABLE IF EXISTS adoptioncasedisposition;

CREATE TABLE adoptioncasedisposition (
	adoptioncasedispositionid uuid NOT NULL DEFAULT gen_random_uuid(),
	adoptioncaseid uuid NOT NULL,
	statusdate timestamp NULL DEFAULT now(),
	intakeserreqstatustypekey varchar(15) NULL,
	dispositioncode varchar(15) NULL,
	"comments" text NULL,
	effectivedate timestamp NOT NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	expirationdate timestamp NULL,
	old_id varchar(50) NULL,
	CONSTRAINT pk_adoptioncasedisposition PRIMARY KEY (adoptioncasedispositionid),
	CONSTRAINT fk_adoptioncasedisposition_dispositioncode FOREIGN KEY (dispositioncode) REFERENCES dispositioncode(dispositioncode),
    CONSTRAINT fk_adoptioncasedisposition_intakeserreqstatustype FOREIGN KEY (intakeserreqstatustypekey) REFERENCES intakeserreqstatustype(intakeserreqstatustypekey),
	CONSTRAINT fk_adoptioncasedisposition_adoptioncase FOREIGN KEY (adoptioncaseid) REFERENCES adoptioncase(adoptioncaseid)
);