
DROP TABLE IF EXISTS collateralroleconfig;

CREATE TABLE collateralroleconfig (
	collateralroleconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	collateralid uuid NOT NULL,
	actortypekey varchar(50)  NOT NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	old_id varchar(25) NULL,
	CONSTRAINT pk_collateralroleconfig PRIMARY KEY (collateralroleconfigid)	
);
