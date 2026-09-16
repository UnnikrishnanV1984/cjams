DROP TABLE IF EXISTS cjams.intakeservicerequesthearingactor;
CREATE TABLE cjams.intakeservicerequesthearingactor (
	intakeservicerequesthearingactorid uuid NOT NULL DEFAULT gen_random_uuid(),
	intakeservicerequestcourthearingid uuid ,
	intakeservicerequestactorid uuid ,
	courtcasenumber character varying(50) ,
	isotherclient int,
	activeflag int NOT NULL DEFAULT 1,
	insertedby character varying(50) NULL,
	updatedby character varying(50) NULL,
	effectivedate timestamp NULL DEFAULT now(),
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedon timestamp NOT NULL DEFAULT now(),
	old_id character varying(50) NULL,
 
	CONSTRAINT pk_intakeservicerequesthearingactor PRIMARY KEY (intakeservicerequesthearingactorid),
	CONSTRAINT fk_intakeservicerequesthearingactor_intakeservicerequestactor FOREIGN KEY (intakeservicerequestactorid) REFERENCES intakeservicerequestactor(intakeservicerequestactorid),
	CONSTRAINT fk_intakeservicerequesthearingactor_intakeservicerequestcourthearing FOREIGN KEY (intakeservicerequestcourthearingid) REFERENCES intakeservicerequestcourthearing(intakeservicerequestcourthearingid)
);