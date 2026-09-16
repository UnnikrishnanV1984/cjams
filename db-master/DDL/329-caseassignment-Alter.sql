ALTER TABLE caseassignment  ADD COLUMN IF NOT EXISTS assignmenttype character varying(5);
ALTER TABLE intakeservicerequest  ADD COLUMN IF NOT EXISTS isscreening int;
ALTER TABLE userprofile  ADD COLUMN IF NOT EXISTS primarycountyid uuid;
ALTER TABLE userprofile  ADD COLUMN IF NOT EXISTS supervisorid character varying(50);

DROP TABLE IF EXISTS cjams.caseassignmentactor;

CREATE TABLE caseassignmentactor (
	caseassignmentactorid uuid NOT NULL DEFAULT gen_random_uuid(),
	caseassignmentid uuid NOT NULL,
	intakeservicerequestactorid uuid NOT NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	old_id varchar(25) NULL,
	CONSTRAINT pk_caseassignmentactor PRIMARY KEY (caseassignmentactorid),
	CONSTRAINT fk_caseassignmentactor_intakeservicerequestactor FOREIGN KEY (intakeservicerequestactorid) REFERENCES intakeservicerequestactor(intakeservicerequestactorid)
);



