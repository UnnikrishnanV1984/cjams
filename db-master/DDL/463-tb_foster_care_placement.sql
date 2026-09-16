-- Drop table

-- DROP TABLE cjams.tb_foster_care_placement

CREATE TABLE IF NOT EXISTS cjams.tb_foster_care_placement (
	clientid int8 NOT NULL,
	removalid int8 NOT NULL,
	periodtype varchar NULL,
	islapsesinplacement varchar NULL,
	typeoflapses varchar NULL,
	kindoflapses varchar NULL,
	insertedon timestamp NULL,
	insertedby varchar   NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL
);
